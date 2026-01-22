FROM python:3.12-slim

WORKDIR /app
COPY exporter.py /app/exporter.py

EXPOSE 8000

ENTRYPOINT ["python3", "/app/exporter.py"]
