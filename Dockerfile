
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ./src/CounterApi.csproj ./src/
RUN dotnet restore ./src/CounterApi.csproj

COPY . .

RUN dotnet publish ./src/CounterApi.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "CounterApi.dll"]
