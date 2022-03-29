FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/ResortForecaster.Migrations/ResortForecaster.Migrations.csproj", "src/ResortForecaster.Migrations/"]
COPY ["src/ResortForecaster.Migrations/Migrations/1CreateTables.sql", "src/ResortForecaster.Migrations/"]
RUN dotnet restore "src/ResortForecaster.Migrations/ResortForecaster.Migrations.csproj"
COPY . .

WORKDIR "/src/src/ResortForecaster.Migrations"
RUN dotnet build "ResortForecaster.Migrations.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ResortForecaster.Migrations.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
COPY "src/ResortForecaster.Migrations/" .
VOLUME /var/opt/mssql/data/resort-forecaster-database-volume
ENTRYPOINT ["dotnet", "ResortForecaster.Migrations.dll"]
CMD ["Docker"]