{{- if .Values.analyzer.enabled }}
{{- include "presidio.analyzer-deployment" . }}
{{- include "presidio.analyzer-service" . }}
{{- end }}

{{- if .Values.anonymizer.enabled }}
{{- include "presidio.anonymizer-deployment" . }}
{{- include "presidio.anonymizer-service" . }}
{{- end }}

{{- if .Values.imageRedactor.enabled }}
{{- include "presidio.image-redactor-deployment" . }}
{{- include "presidio.image-redactor-service" . }}
{{- end }}
