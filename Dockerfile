
FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /source

COPY *.sln .
COPY runtest/*.csproj ./newtest/
RUN dotnet restore

COPY newtest/../newtest/
WORKDIR /source/newtest
RUN dotnet publish -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 80
ENTRYPOINT ["dotnet", "newtest.dll"]
