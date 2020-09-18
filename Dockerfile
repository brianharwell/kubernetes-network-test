FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY /source .
RUN dotnet restore "KubernetesNetworkTest.csproj"
RUN dotnet build "KubernetesNetworkTest.csproj" --configuration Release
RUN dotnet publish "KubernetesNetworkTest.csproj" --configuration Release --framework netcoreapp3.1 --output /publish --no-build

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS final
EXPOSE 80
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "KubernetesNetworkTest.dll"]
