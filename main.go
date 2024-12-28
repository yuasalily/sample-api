package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	// ヘルスチェックエンドポイント
	e.GET("/health", status)

	// サーバー起動
	e.Logger.Fatal(e.Start(":8080"))
}

func status(c echo.Context) error {
	return c.JSON(http.StatusOK, map[string]string{
		"status": "OK",
	})
}
