# ベースイメージ
FROM golang:1.22 as builder

# 作業ディレクトリを作成
WORKDIR /app

# アプリケーションのソースコードをコピー
COPY . .
RUN go mod download

# アプリケーションをビルド
RUN go build -o main

# 実行環境の作成
FROM alpine:latest

# 必要なランタイムをインストール
RUN apk --no-cache add ca-certificates

# 作業ディレクトリを指定
WORKDIR /root/

# ビルド済みバイナリをコピー
COPY --from=builder /app/mock-server .

# ポートを公開
EXPOSE 8080

# アプリケーションを実行
CMD ["./main"]
