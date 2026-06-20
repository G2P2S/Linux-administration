# =========================
# STAGE 1: build
# =========================
FROM python:3.11-slim AS builder

WORKDIR /app

ENV PYTHONPATH=/app

ENV PYTHONUNBUFFERED=1

# системные зависимости (нужны для psycopg)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# копируем проект
COPY pyproject.toml .
COPY src ./src
COPY tests ./tests

# устанавливаем зависимости проекта
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir .


# =========================
# STAGE 2: runtime
# =========================
FROM python:3.11-slim

WORKDIR /app

# runtime библиотеки PostgreSQL
RUN apt-get update && apt-get install -y \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

# копируем установленное из builder
COPY --from=builder /usr/local /usr/local

# копируем код
COPY src ./src
COPY tests ./tests

RUN pip install --no-cache-dir pytest pytest-asyncio httpx

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

EXPOSE 58529

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "58529"]
