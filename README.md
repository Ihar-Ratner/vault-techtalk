# Enable kubernetes atuh
vault auth enable kubernetes

# Write config auth
vault write auth /kubernetes/config \
kubernetes_host=https://${CLUSTER_IP}:6443 \
kubernetes_ca_cert=/home/ihar_ratner/ca.crt

# Write auth role for kubernetes
vault write auth/kubernetes/role/vault-demo-${NAMESPACE} \
    bound_service_account_names=vault-serviceaccount \
    bound_service_account_namespaces= ${NAMESPACE} \
    policies=vault-demo-policy \
    ttl=1h
    
# Create policy
cat <<EOF | vault policy write vault-demo-policy -
path "sys/mounts" { capabilities = ["read"] }
path "secret/data/demo/*" { capabilities = ["read"] }
path "secret/metadata/demo/*" { capabilities = ["list"] }
EOF

# Create secrets
vault kv put secret/demo/most-used-password password=123456
vault kv put secret/demo/first one=1234567890 two=2345678901
vault kv put secret/demo/second green=lantern poison=ivy
vault kv put secret/demo/greek/alpha philosopher=plato
vault kv put secret/demo/greek/beta god=zeus
vault kv put secret/demo/greek/gamma mountain=olympus

### In kubernetes manifest replace ENV values for yours
##### VAULT_ADDR - vault server ip address
##### VAULT_ROLE - kubernetes role for access in vault server
##### VAULT_SECRETS - path to your secrets in vault
### env:
        - name: VAULT_ADDR
          value: <pleasechangeme>
        - name: VAULT_ROLE
          value: <pleasechangeme>
        - name: VAULT_SECRETS
          value: <pleasechangeme>
          
# Consul-template example
          
