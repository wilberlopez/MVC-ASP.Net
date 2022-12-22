FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
RUN dotnet restore "MVC ASP.Net Core.csproj"
COPY . .
WORKDIR /src
RUN dotnet build "MVC ASP.Net Core.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MVC ASP.Net Core.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MVC ASP.Net Core.dll"]