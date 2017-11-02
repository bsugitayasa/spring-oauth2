# Spring OAUTH2 #

Roadmap

* Overview Spring Oauth2 
* Build from scratch
* Live Demo

## Spring Oauth2 ##

* Spring OAuth 2.0 sebenarnya adalah untuk Authorization
* Mengijinkan aplikasi pihak ketiga untuk mendapatkan akses terbatas ke HTTP service
* Satu login untuk banyak aplikasi, contoh : Google, Facebook, Instagram, Twitter, etc

## Entity / Terminology ##

![Oauth2-terminology](img/zull-proxy-1.jpg)

### Mode (Grant Type) of Auth Server ###

* Auth Code
* Implicit
* Resource Owner Password
* Client Credential
* Device

### Auth Code ###

* Applikasi web yang dapat menyimpan client key (secret/password)
* Resource Owner tidak pernah memberikan password ke client app
* Selalu berkaitan dengan Resoure Owner

### Implicit ###

* Tidak menyimpan client key
* Resource Owner tidak pernah memberikan password ke client app
* Selalu berkaitan dengan Resoure Owner

### Resource Owner Password ###

* Client app dan resource server didevelop oleh pihak yang sama
* Client app dapat langsung menerima username & password dari Resource Owner
* Selalu berkaitan dengan Resoure Owner

### Client Credential ###

* Langsung menerima client credential
* Client app tidak spesifik terhadap user data tertentu, contoh : treading topik pada twitter
* Hanya antara Client app dengan Resource Server

### Device ###

* Fitur terbaru --> kamera yang sudah terkoneksi dengan cloud service
* Input terbatas (misal tidak bisa buka browser)
* Menyediakan suatu kode unik saat ingin akses via browser


Authentication --> memastikan siapakah yang datang
Authorization --> berkaitan dengan permission atau ijin akses/ role / privileges


menit ke 16 . . . .


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