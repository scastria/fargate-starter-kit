FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
EXPOSE 80
#Assumes Dockerfile is located inside published output directory
COPY . .
ENTRYPOINT ["dotnet", "Service.dll"]
