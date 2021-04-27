# Container image that runs your code
FROM openjdk:11-jdk
EXPOSE 8080:8080
# Copies your code file from your action repository to the filesystem path `/` of the container
#COPY entrypoint.sh /entrypoint.sh
COPY dist /dist
COPY start.sh /start.sh
#CMD ["app"]
# Code file to execute when the docker container starts up (`entrypoint.sh`)
#ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["/start.sh"]
ENTRYPOINT ["dist/bin/app"]
# ${{ github.action_path }}/dist/bin/app ${{ inputs.who-to-greet }}