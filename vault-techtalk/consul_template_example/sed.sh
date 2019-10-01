#!/bin/sh
X=`cat /home/vagrant/vault/.vault-token`
echo $X
sed -i "/token / s/="[^"][^"]*"/=\"$X\"/" config.hcl
echo $VAULT_ADDR
#sed -i "11s#.*# s#="[^"][^"]*"#=\"$VAULT_ADDR\"#" config.hcl
sed -i "11s#.*# address = \"$VAULT_ADDR\"#" config.hcl
