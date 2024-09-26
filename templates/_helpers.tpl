{{/*
Vault annotations
*/}}
{{- define "varroa.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/varroa/varroa.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
  {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
  {{ print "{{- if .Data.data.transport_url }}" }}
  {{ print "[DEFAULT]" }}
  {{ print "transport_url={{ .Data.data.transport_url }}" }}
  {{ print "{{- end }}" }}
  {{ print "{{- if .Data.data.notification_transport_url }}" }}
  {{ print "[oslo_messaging_notifications]" }}
  {{ print "transport_url={{ .Data.data.notification_transport_url }}" }}
  {{ print "{{- end }}" }}
  {{ print "{{- if .Data.data.database_connection }}" }}
  {{ print "[database]" }}
  {{ print "connection={{ .Data.data.database_connection }}" }}
  {{ print "{{- end }}" }}
  {{ print "[flask]" }}
  {{ print "secret_key={{ .Data.data.secret_key }}" }}
  {{ print "[service_auth]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "[keystone_authtoken]" }}
  {{ print "password={{ .Data.data.keystone_password }}" }}
  {{ print "{{- end -}}" }}
{{- end }}
