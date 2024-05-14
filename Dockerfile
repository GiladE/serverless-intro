FROM public.ecr.aws/sam/build-java21:latest as build-image

ARG SCRATCH_DIR=/var/task/build

COPY src/ src/
COPY gradle/ gradle/
COPY build.gradle gradlew ./

RUN mkdir build
COPY gradle/lambda-build-init.gradle ./build

RUN ./gradlew --project-cache-dir $SCRATCH_DIR/gradle-cache -Dsoftware.amazon.aws.lambdabuilders.scratch-dir=$SCRATCH_DIR --init-script $SCRATCH_DIR/lambda-build-init.gradle build
RUN rm -r $SCRATCH_DIR/gradle-cache
RUN rm -r $SCRATCH_DIR/lambda-build-init.gradle
RUN cp -r $SCRATCH_DIR/*/build/distributions/lambda-build/* .

FROM public.ecr.aws/lambda/java:21

COPY --from=build-image /var/task/META-INF ./
COPY --from=build-image /var/task/helloworld ./helloworld
COPY --from=build-image /var/task/lib/ ./lib

CMD ["helloworld.App::handleRequest"]