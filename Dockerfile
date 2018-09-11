FROM grafana/grafana

USER root

RUN apt-get update -y \
 && apt-get install gettext-base \
 && chown grafana:grafana /etc/grafana/provisioning/datasources/ \
 && chown grafana:grafana /etc/grafana/provisioning/dashboards/

COPY configs /var/configs
COPY configs/dashboards/dashboards.yaml /etc/grafana/provisioning/dashboards/
COPY start.sh /start.sh

ENV GF_AUTH_ANONYMOUS_ENABLED=true
ENV GF_AUTH_ANONYMOUS_ORG_ROLE=Editor
ENV GF_AUTH_BASIC_ENABLED=false
#ENV GF_AUTH_DISABLE_LOGIN_FORM=true
#ENV GF_AUTH_DISABLE_SIGNOUT_MENU=true
#ENV GF_SECURITY_ADMIN_PASSWORD=secret

USER grafana

ENTRYPOINT [ "/start.sh" ]