#!/bin/sh
X=`cat /home/vagrant/vault/.vault-token`
echo $X
sed -i "/token / s/="[^"][^"]*"/=\"$X\"/" config.hcl
echo $VAULT_ADDR
sed -i "/address / s/="[^"][^"]*"/=\"http:\/\/$VAULT_ADDR\"/" config.hcl