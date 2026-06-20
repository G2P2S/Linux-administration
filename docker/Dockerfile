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
 && pip install --no-cache-dir ".[test]"


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

ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
