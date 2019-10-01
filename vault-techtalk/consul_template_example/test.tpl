{{ with secret "secret/data/demo/second" }}
export SECRET_PASS={{ .Data.data.green }}
export SECRET_USER={{ .Data.data.poison }}
{{ end }}