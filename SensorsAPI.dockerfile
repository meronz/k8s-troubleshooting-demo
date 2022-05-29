# syntax=docker/dockerfile:1.4
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

COPY src/SensorsAPI/Client/*.csproj /src/SensorsAPI/Client/
COPY src/SensorsAPI/Server/*.csproj /src/SensorsAPI/Server/
COPY src/SensorsAPI/*.sln /src/SensorsAPI/
RUN dotnet restore /src/SensorsAPI/

COPY /src/SensorsAPI/Client /src/SensorsAPI/Client/
COPY /src/SensorsAPI/Server /src/SensorsAPI/Server/
WORKDIR /src/SensorsAPI/Server/
RUN dotnet publish --no-restore -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
COPY --from=build /app /app
WORKDIR /app
ENTRYPOINT ["dotnet", "SensorsAPI.Server.dll"]
EXPOSE 8080
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS='http://+:8080'
ENV ASPNETCORE_ENVIRONMENT='Production'
ENV Logging__Console__FormatterName='Simple'
