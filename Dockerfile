# ベースイメージ
FROM golang:1.23 as builder

# 作業ディレクトリを作成
WORKDIR /app

# アプリケーションのソースコードをコピー
COPY . .
RUN go mod download

# 静的リンクでビルド
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main

# 実行環境の作成
FROM alpine:latest

# 必要なランタイムをインストール
RUN apk --no-cache add ca-certificates libc6-compat

# 作業ディレクトリを指定
WORKDIR /root/

# ビルド済みバイナリをコピー
COPY --from=builder /app/main .

# 実行権限を確認
RUN chmod +x main

# ポートを公開
EXPOSE 8080

# アプリケーションを実行
CMD ["./main"]