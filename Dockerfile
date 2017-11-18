 # Sample contents of Dockerfile
 # Stage 1
 FROM microsoft/aspnetcore-build AS builder
 WORKDIR /source
 
 # caches restore result by copying csproj file separately
 RUN mkdir /source/webapi
 COPY src/webapi/webapi.csproj ./webapi
 WORKDIR /source/webapi
 RUN dotnet restore

 # copies the rest of your code
 WORKDIR /source
 COPY src .
 WORKDIR /source/webapi
 RUN dotnet publish --output /app/ --configuration Release

 # Stage 2
 FROM microsoft/aspnetcore
 WORKDIR /app
 COPY --from=builder /app .
 ENTRYPOINT ["dotnet", "webapi.dll"]