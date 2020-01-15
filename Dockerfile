# Start with a base image containing Java runtime
FROM openjdk:8-jdk-alpine

# Add Maintainer Info
LABEL maintainer="edmw@capgroup.com"

# Add a volume pointing to /tmp
VOLUME /tmp

# enhance security by not running as root
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Make port 8080 available to the world outside this container
EXPOSE 8080

#1
# The application's jar file
ARG JAR_FILE=target/*.jar

# Copy the application's jar to the container
COPY ${JAR_FILE} book_service-1.0.jar

# Or 2
# The application's jar file
#ARG JAR_FILE=target/book_service-1.0.jar
# Add the application's jar to the container
#ADD ${JAR_FILE} book_service-1.0.jar

# Run the jar file
# https://stackoverflow.com/questions/58991966/what-java-security-egd-option-is-for
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom", "-jar","/book_service-1.0.jar"]

#information on adding container
#oc new-app registry.access.redhat.com/openjdk/openjdk-11-rhel7:latest~. --name=jsbackend --build-env="MAVEN_MIRROR_URL=https://cgrepo.capgroup.com/repository/cgmaven"

#and start a build
#C:\Users\edmw\JetBrain\workspace\java\book_service>oc start-build jsbackend --from-dir=. --follow

#and expose route
#oc expose svc/jsbackend

#to check the springboot application log
#oc logs -f svc/jsbackend