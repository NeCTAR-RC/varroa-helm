{{- define "varroa-conf" }}
[DEFAULT]
{{- if .Values.conf.transport_url }}
transport_url={{ .Values.conf.transport_url }}
{{- end }}

[database]
connection_recycle_time=600
{{- if .Values.conf.database.connection }}
connection={{ .Values.conf.database.connection }}
{{- end }}

[oslo_messaging_rabbit]
rabbit_ha_queues=True
ssl=True
amqp_durable_queues=True

[service_auth]
auth_url={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_token_roles_required=True

{{- end }}
