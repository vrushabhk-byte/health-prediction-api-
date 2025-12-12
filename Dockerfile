# ------------------ BUILDER STAGE ------------------
FROM python:3.10-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --prefix=/install -r requirements.txt


# ------------------ RUNTIME STAGE ------------------
FROM python:3.10-slim

WORKDIR /app

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy dependencies from builder layer
COPY --from=builder /install /usr/local

# Copy application source code
COPY app ./app

# Create non-root user
RUN useradd -m appuser
USER appuser

# Expose FastAPI port
EXPOSE 8000

# Healthcheck uses curl
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Run application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
