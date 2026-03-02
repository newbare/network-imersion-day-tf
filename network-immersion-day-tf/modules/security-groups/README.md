# Módulo Terraform: security-groups

Descrição do módulo e exemplos de uso.

O que esperar
A instância pública responderá a pings do seu IP.

A instância privada conseguirá pingar a pública (devido às regras de security group que permitem ICMP entre os grupos).

A instância privada terá acesso à internet via NAT Gateway (ping para example.com deve funcionar).
