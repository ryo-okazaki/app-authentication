#!/bin/bash

set -e

# ==============================================================================
# ECS バックエンドサービス更新スクリプト
# ==============================================================================
# 最新のECRイメージでECSサービスを再デプロイします
#
# 使用方法:
#   ./scripts/update-backend-service.sh <environment> <aws-profile>
#
# 例:
#   ./scripts/update-backend-service.sh development dev-profile
# ==============================================================================

# 引数チェック
if [ $# -ne 2 ]; then
    echo "Usage: $0 <environment> <aws-profile>"
    echo "Example: $0 development dev-profile"
    exit 1
fi

ENVIRONMENT=$1
AWS_PROFILE=$2

# 変数設定
REGION="ap-northeast-1"
CLUSTER_NAME="dev-keycloak-cluster"
SERVICE_NAME="keycloak-service"

echo "=========================================="
echo "ECS Service Update"
echo "=========================================="
echo "Environment: ${ENVIRONMENT}"
echo "AWS Profile: ${AWS_PROFILE}"
echo "Region: ${REGION}"
echo "Cluster: ${CLUSTER_NAME}"
echo "Service: ${SERVICE_NAME}"
echo "=========================================="

# AWS認証確認
echo "🔍 Checking AWS credentials..."
aws sts get-caller-identity --profile ${AWS_PROFILE} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ AWS認証に失敗しました。プロファイルを確認してください: ${AWS_PROFILE}"
    exit 1
fi
echo "✅ AWS認証成功"

# クラスター存在確認
echo ""
echo "🔍 Checking ECS cluster..."
aws ecs describe-clusters \
    --clusters ${CLUSTER_NAME} \
    --profile ${AWS_PROFILE} \
    --region ${REGION} \
    --query 'clusters[0].status' \
    --output text > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "❌ ECSクラスターが見つかりません: ${CLUSTER_NAME}"
    exit 1
fi
echo "✅ クラスター確認完了"

# サービス存在確認
echo ""
echo "🔍 Checking ECS service..."
aws ecs describe-services \
    --cluster ${CLUSTER_NAME} \
    --services ${SERVICE_NAME} \
    --profile ${AWS_PROFILE} \
    --region ${REGION} \
    --query 'services[0].serviceName' \
    --output text > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "❌ ECSサービスが見つかりません: ${SERVICE_NAME}"
    exit 1
fi
echo "✅ サービス確認完了"

# 現在のタスク定義取得
echo ""
echo "📋 Getting current task definition..."
TASK_DEFINITION=$(aws ecs describe-services \
    --cluster ${CLUSTER_NAME} \
    --services ${SERVICE_NAME} \
    --profile ${AWS_PROFILE} \
    --region ${REGION} \
    --query 'services[0].taskDefinition' \
    --output text)

echo "Current task definition: ${TASK_DEFINITION}"

# サービス更新(強制デプロイ)
echo ""
echo "🚀 Updating ECS service with latest image..."
aws ecs update-service \
    --cluster ${CLUSTER_NAME} \
    --service ${SERVICE_NAME} \
    --force-new-deployment \
    --profile ${AWS_PROFILE} \
    --region ${REGION} \
    --no-cli-pager

if [ $? -ne 0 ]; then
    echo "❌ サービスの更新に失敗しました"
    exit 1
fi

echo ""
echo "✅ サービス更新リクエスト送信完了"
echo ""
echo "=========================================="
echo "デプロイ状況確認"
echo "=========================================="
echo ""
echo "デプロイの進行状況を監視しています..."
echo "※ Ctrl+C で監視を停止できます(デプロイは継続されます)"
echo ""

# デプロイ完了待機
aws ecs wait services-stable \
    --cluster ${CLUSTER_NAME} \
    --services ${SERVICE_NAME} \
    --profile ${AWS_PROFILE} \
    --region ${REGION}

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ デプロイ完了！"
    echo ""

    # デプロイ後の状態確認
    echo "=========================================="
    echo "サービス状態"
    echo "=========================================="
    aws ecs describe-services \
        --cluster ${CLUSTER_NAME} \
        --services ${SERVICE_NAME} \
        --profile ${AWS_PROFILE} \
        --region ${REGION} \
        --query 'services[0].{
            ServiceName: serviceName,
            Status: status,
            DesiredCount: desiredCount,
            RunningCount: runningCount,
            TaskDefinition: taskDefinition
        }' \
        --output table

    echo ""
    echo "🎉 バックエンドサービスの更新が完了しました！"
else
    echo ""
    echo "⚠️  デプロイの完了待機中にタイムアウトまたはエラーが発生しました"
    echo "   AWSコンソールで状態を確認してください"
    exit 1
fi
