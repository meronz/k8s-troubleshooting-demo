# syntax=docker/dockerfile:1.4
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

COPY src/SensorsAPI/Client/*.csproj            /src/SensorsAPI/Client/
COPY src/BlazorCharts/Client/*.csproj   /src/BlazorCharts/Client/
COPY src/BlazorCharts/Server/*.csproj   /src/BlazorCharts/Server/
COPY src/BlazorCharts/Shared/*.csproj   /src/BlazorCharts/Shared/
COPY src/BlazorCharts/*.sln             /src/BlazorCharts/
RUN dotnet restore /src/BlazorCharts/

COPY src/SensorsAPI/Client/         /src/SensorsAPI/Client/
COPY src/BlazorCharts/Client /src/BlazorCharts/Client/
COPY src/BlazorCharts/Server /src/BlazorCharts/Server/
COPY src/BlazorCharts/Shared /src/BlazorCharts/Shared/
WORKDIR /src/BlazorCharts/Server/
RUN dotnet publish --no-restore -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
COPY --from=build /app /app
WORKDIR /app
ENTRYPOINT ["dotnet", "BlazorCharts.Server.dll"]
EXPOSE 8080
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS='http://+:8080'
ENV ASPNETCORE_ENVIRONMENT='Production'
ENV Logging__Console__FormatterName='Simple'
