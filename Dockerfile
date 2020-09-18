FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY /source .
RUN dotnet build --configuration Release
RUN dotnet publish --configuration Release --framework netcoreapp3.1 --output /publish --no-build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
EXPOSE 80
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "KubernetesNetworkTest.Web.dll"]
