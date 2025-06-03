
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ./src/CounterApi.csproj ./src/
RUN dotnet restore ./src/CounterApi.csproj

COPY . .
WORKDIR /src
RUN dotnet build ./src/CounterApi.csproj -c RELEASE -o /app/build

FROM build as publish
RUN dotnet publish ./src/CounterApi.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CounterApi.dll"]
