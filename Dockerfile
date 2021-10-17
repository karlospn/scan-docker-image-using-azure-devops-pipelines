#############
## Stage 1 ##
#############
FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build-env
WORKDIR /app

## Copy the applications .csproj
COPY /src/WebApp/*.csproj ./src/WebApp/

## Restore packages
RUN dotnet restore "./src/WebApp/WebApp.csproj" -s "https://api.nuget.org/v3/index.json"

## Copy everything else
COPY . ./

## Build the app
RUN dotnet build "./src/WebApp/WebApp.csproj" -c Release --no-restore

## Run dotnet test setting the output on the /coverage folder
RUN dotnet test test/WebApp.Tests/*.csproj --collect:"XPlat Code Coverage" --results-directory ./coverage

## Publish the app
RUN dotnet publish src/WebApp/*.csproj -c Release -o /app/publish --no-build --no-restore

#############
## Stage 2 ##
#############
FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim
WORKDIR /app
COPY --from=build-env /app/publish .
ENTRYPOINT ["dotnet", "WebApp.dll"]