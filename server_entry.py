"""直接以 Web API 模式启动 TikTokDownloader"""
from asyncio import run
from src.application.TikTokDownloader import TikTokDownloader
from src.application.main_server import APIServer
from src.custom import SERVER_HOST, SERVER_PORT

async def main():
    app = TikTokDownloader()
    async with app:
        # 模拟选择 "Web API 模式" (菜单选项 7)
        app.check_config()
        await app.check_settings(restart=False)
        print(f"Starting TikTokDownloader API Server on {SERVER_HOST}:{SERVER_PORT}")
        server = APIServer(
            app.parameter,
            app.database,
        )
        await server.run_server(SERVER_HOST, SERVER_PORT)

if __name__ == "__main__":
    run(main())
