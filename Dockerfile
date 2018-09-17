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
ENV GF_DATABASE_MAX_OPEN_CONN=2
ENV GF_DATABASE_MAX_IDLE_CONN=1

USER grafana

ENTRYPOINT [ "/start.sh" ]