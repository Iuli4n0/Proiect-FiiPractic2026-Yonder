FROM gradle:jdk8 AS builder
WORKDIR /app
COPY --chown=gradle:gradle springboot /app
RUN chmod +x ./gradlew && ./gradlew build --no-daemon

FROM eclipse-temurin:8-jammy
WORKDIR /app
RUN useradd -r spring
COPY --from=builder /app/build/libs/spring-boot-FiiPractic-1.0.jar app.jar
RUN chown spring:spring app.jar
USER spring
EXPOSE 8080
ENTRYPOINT java -jar app.jar
