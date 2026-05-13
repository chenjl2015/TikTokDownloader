# ---- 阶段 1: 构建器 (Builder) ----
FROM python:3.12-bullseye as builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix="/install" -r requirements.txt

# ---- 阶段 2: 最终镜像 (Final Image) ----
FROM python:3.12-slim

WORKDIR /app

LABEL name="DouK-Downloader" authors="JoeanAmier" repository="https://github.com/JoeanAmier/TikTokDownloader"

COPY --from=builder /install /usr/local

COPY src /app/src
COPY locale /app/locale
COPY static /app/static
COPY license /app/license
COPY main.py /app/main.py
COPY server_entry.py /app/server_entry.py

EXPOSE 15558

VOLUME /app/Volume

CMD ["python", "server_entry.py"]
