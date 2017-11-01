# Spring OAUTH2 #

Roadmap

* Overview Spring Oauth2 
* Build from scratch
* Live Demo

## Spring Oauth2 ##

* Zipkin was originally developed at Twitter
* Efficient tools for distributed tracing in microservices ecosystem
    * latency measurement
    * how much time
* Helps in identifying that slow component among in the ecosystem, by filter or sort all traces based on the application

### Internally it has 4 modules ###

* Collector - Once any component send the trace data to Zipkin collector daemon, it is validated, store & indexed for lookups by the Zipkin collector
* Storage - This module store and index the lookup data in backend. (Cassandra, Elastic Search & MySQL are supported)
* Search - This module provides a simple JSON API
* Web UI - A very nice UI Interface for viewing traces

## Using Zipkin ##

* Just add some depndency on `pom.xml`in the spring boot project

    ```
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-server</artifactId>
    </dependency>
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-autoconfigure-ui</artifactId>
        <scope>runtime</scope>
    </dependency>
    ```

## Spring Cloud Sleuth ##

* Distributed tracing solution for Spring Cloud
    * trace id
    * span id
    * add these information to the service calls in the header and MDC
* It can be used by ZIPKIN
* It automatically integrated to the common communication channels
    * request made with the RestTemplate
    * request that pass throught a Netflix Zull Proxy
    * HTTP headers received at Spring MVC controller
    * Request over messaging technologies like Apache Kafka or RabbitMQ etc
    
### Using Sleuth ###

* Is very easy. Just need to add it's `pom.xml` in the spring boot project

    ```
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-sleuth</artifactId>
    </dependency>
    ```


## Build and Run ##

### Spring Boot Initializr ###

1. Create Zipkin Server --> Browse [https://start.spring.io/] (https://start.spring.io/)

2. Fill Project Metadata

    Group
    
    ```
    com.sheringsession.balicamp.zipkin    
    ```

    Artifact
    
    ```
    zipkin-sleuth
    ```
   
    Dependencies
    
    ```
    Zipkin UI, Eureka Discovery, Config Client
    ```
   
3. Generate Project

4. Download dan import to your IDE


### Build with Maven ###

1. In `pom.xml` makesure for dependency
    
    ```
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-config</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-eureka</artifactId>
    </dependency>
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-server</artifactId>
    </dependency>
    <dependency>
        <groupId>io.zipkin.java</groupId>
        <artifactId>zipkin-autoconfigure-ui</artifactId>
        <scope>runtime</scope>
    </dependency>
    ```

2. `applicatioin.properties` rename into `bootstrap.yml`

    ```
    spring:
      application:
        name: zipkin
      cloud:
        config:
          discovery:
            enabled: true
            service-id: configservice
          fail-fast: true

    ---
    spring:
      profiles: native
    server:
      port: 8898
    eureka:
      instance:
        hostname: localhost:8898
      client:
          serviceUrl:
            defaultZone: http://localhost:8761/eureka/,http://localhost:8762/eureka/
    ```

### Build with IDE ###

3. Add `@EnableZipkinServer` into your spring project configuration

    ```
    @SpringBootApplication
    @EnableZipkinServer
    public class ZipkinApplication {

        public static void main(String[] args) {
            SpringApplication.run(ZipkinApplication.class, args);
        }
    }
    ```

### Configure In Microservice (Client) ###

1. In `pom.xml` add new dependency
    
    ```
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-sleuth-zipkin</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-sleuth</artifactId>
    </dependency>
    ```

2. In `bootstrap.yml` add new properties

    ```
    spring:
        ...
        zipkin:
            base-url: http://localhost:8765 #or your zipkin server uri
        sleuth:
            sampler:
              percentage: 1.0
    ```

3. You will see something like this in the logging, ex: browse from catalog service

    ```
    2017-10-30 17:45:00.923  INFO [catalog,4a10e06c3fe40f0f,4a10e06c3fe40f0f,false] 2829 --- [nio-8764-exec-1] i.t.t.m.c.c.ProductApiController         : ##### Mengambil data semua produk
    ```

In the example, `catalog` is the `spring.application.name`, `4a10e06c3fe40f0f` is the trace ID and `4a10e06c3fe40f0f` is the span ID.

### FINISH ###