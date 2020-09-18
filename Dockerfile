FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY /source .
RUN dotnet restore "KubernetesConnectivityTest.csproj"
RUN dotnet build "KubernetesConnectivityTest.csproj" --configuration Release
RUN dotnet publish "KubernetesConnectivityTest.csproj" --configuration Release --framework netcoreapp3.1 --output /publish --no-build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
EXPOSE 80
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "KubernetesConnectivityTest.dll"]
