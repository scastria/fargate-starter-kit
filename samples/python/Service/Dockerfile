FROM python:3
WORKDIR /app
EXPOSE 80
#Assumes Dockerfile is located inside published output directory
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python", "program.py"]
