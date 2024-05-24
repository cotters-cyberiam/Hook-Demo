# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

WORKDIR /source

# copy csproj and restore as distinct layers
COPY k8sTestAPI/*.csproj .
RUN dotnet restore --use-current-runtime

# copy everything else and build app
COPY k8sTestAPI/. .
RUN dotnet clean
RUN dotnet publish --use-current-runtime --self-contained false --no-restore -o /app


# Enable globalization and time zones:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/enable-globalization.md
# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
WORKDIR /app
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

# Define dependent packages and updates
ENV BUILD_PACKAGES bash curl build-base vim
RUN apk add --no-cache icu-libs
RUN apk update && \
    apk upgrade && \
    apk add --upgrade libldap && \
    apk add $BUILD_PACKAGES && \
    ln -s libldap.so.2 /usr/lib/libldap-2.4.so.2 && \
    rm -rf /var/cache/apk/*

# Build the project and set the dependent environment variables
COPY --from=build /app .
ENTRYPOINT ["./k8sTestAPI"]
