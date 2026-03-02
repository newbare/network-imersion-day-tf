## 📘 README do Laboratório 01 – VPC Fundamentals

Abaixo está o conteúdo completo para o arquivo `labs/01-vpc-fundamentals/README.md`. Ele inclui todos os elementos solicitados: comandos Terraform, testes de conectividade com explicação do Session Manager, orientações de git, e referências às imagens.

```markdown
# Laboratório 01: VPC Fundamentals

Este laboratório implementa os componentes fundamentais de uma VPC na AWS utilizando Terraform modular. O objetivo é provisionar uma infraestrutura de rede completa, incluindo VPC, subnets públicas/privadas, Internet Gateway, NAT Gateway, tabelas de roteamento, Network ACL, VPC Endpoints (KMS e S3), security groups, IAM roles e instâncias EC2, seguindo as melhores práticas do Well‑Architected Framework.

## 📋 Pré‑requisitos

Antes de iniciar, certifique‑se de que:

- Você configurou as credenciais AWS e verificou a conta conforme o [README principal](../../README.md#-verificando-sua-conta-aws).
- O Terraform (versão ≥ 1.3) está instalado.
- Seu IP público é conhecido (para liberar ICMP no security group público).  
  Para descobrir: `curl ifconfig.me` ou site https://www.iplocation.net/ 
- As variáveis de ambiente ou o arquivo `terraform.tfvars` contêm seu IP no formato CIDR (ex: `"201.13.45.78/32"`).
- Recomenda‑se usar a região `us-east-1` para corresponder às imagens do tutorial.

## 🧱 Estrutura do Laboratório

Este laboratório utiliza os seguintes módulos (localizados em `../../modules/`):

- `vpc` – Cria a VPC.
- `subnets` – Cria 2 subnets públicas e 2 privadas.
- `network-acl` – Cria uma NACL customizada associada a todas as subnets.
- `internet-gateway` – Cria e anexa o Internet Gateway.
- `nat-gateway` – Cria um NAT Gateway na primeira subnet pública.
- `route-tables` – Cria tabelas de rota pública (com rota para o IGW) e privada (com rota para o NAT).
- `security-groups` – Cria os security groups público, privado e para o endpoint KMS.
- `vpc-endpoints` – Cria endpoint de interface para KMS e endpoint de gateway para S3.
- `iam-roles` – Cria a IAM role e o instance profile para permitir acesso via Session Manager.
- `ec2-instance` – Lança uma instância pública (AZ2, IP `10.0.2.100`) e uma privada (AZ1, IP `10.0.1.100`).

## 🚀 Como Executar o Laboratório

### 1. Acesse o diretório do laboratório

```bash
cd labs/01-vpc-fundamentals
```

### 2. Configure as variáveis

Edite o arquivo `envs/dev/terraform.tfvars` com seus dados:

```hcl
environment = "dev"
region      = "us-east-1"

vpc_name             = "VPC A"
vpc_cidr             = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support   = true

public_subnet_cidrs  = ["10.0.0.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

my_ip_cidr      = "SEU_IP_PUBLICO/32"   # Substitua pelo seu IP
instance_type   = "t2.micro"
```

### 3. Inicialize o Terraform

```bash
terraform init
```

### 4. Revise o plano de execução

```bash
terraform plan -var-file="envs/dev/terraform.tfvars"
```

### 5. Aplique a configuração

```bash
terraform apply -var-file="envs/dev/terraform.tfvars" -auto-approve
```

A criação leva alguns minutos. Ao final, os outputs serão exibidos.

### 6. Obtenha os outputs

```bash
terraform output
```

Os principais outputs são:

- `public_instance_public_ip` – IP público da instância pública.
- `private_instance_private_ip` – IP privado da instância privada.
- `vpc_id` – ID da VPC.
- `public_subnet_ids` e `private_subnet_ids` – IDs das subnets.

## 🧪 Testes de Conectividade

### Teste 1: Ping da Internet para a Instância Pública

No seu terminal local (fora da AWS), execute:

```bash
ping -c 5 $(terraform output -raw public_instance_public_ip)
```

Você deve ver respostas ICMP.  
*Isso confirma que o Internet Gateway e a rota pública estão funcionando, e que o security group público permite ICMP do seu IP.*

### Teste 2: Acesso à Instância Privada via Session Manager

**Por que o Session Manager funciona?**  
As instâncias possuem um perfil IAM (`NetworkingWorkshopInstanceProfile-dev`) que anexa a política `AmazonSSMManagedInstanceCore`. Isso permite que elas se registrem no AWS Systems Manager. O usuário com permissões adequadas (conta AWS configurada) pode então conectar‑se diretamente pelo console ou CLI, sem necessidade de chave SSH ou IP público.

**Passos:**

1. Acesse o [console EC2](https://console.aws.amazon.com/ec2/).
2. Selecione a instância `VPC A Private AZ1 Server`.
3. Clique em **Connect** → aba **Session Manager** → **Connect**.
4. Uma nova aba de terminal será aberta.

### Teste 3: Ping da Instância Privada para a Pública

No terminal Session Manager da instância privada, execute:

```bash
ping 10.0.2.100 -c 5
```

Deverá receber respostas da instância pública.  
*Isso valida a comunicação entre subnets e as regras de security group (o grupo público permite ICMP do grupo privado, e vice‑versa).*

### Teste 4: Acesso à Internet via NAT Gateway

Ainda na instância privada, execute:

```bash
ping example.com -c 5
```

As respostas confirmam que o tráfego de saída está sendo roteado pelo NAT Gateway.

### Teste 5: Verificação dos VPC Endpoints

#### Endpoint de Interface (KMS)

No terminal da instância privada:

```bash
dig kms.us-east-1.amazonaws.com
```

A resposta deve conter endereços IP dentro do range das subnets privadas (ex: `10.0.1.xx` ou `10.0.3.xx`), indicando que o DNS resolve para o endpoint de interface.

#### Endpoint de Gateway (S3)

No terminal da instância privada, execute:

```bash
aws s3 ls --region us-east-1
```

Embora a conta possa não ter buckets, o comando não deve travar ou apresentar erro de timeout.  
No console VPC, verifique a tabela de rotas privada: deve haver uma rota para o prefix list do S3 apontando para o endpoint.

## 📦 Controle de Versão com Git

### .gitignore recomendado (já incluso na raiz)

Certifique‑se de que seu `.gitignore` na raiz do projeto contenha:

```
.terraform/
*.tfstate
*.tfstate.backup
*.tfvars
*.lock.hcl
```

### Commit inicial do laboratório

Após a criação bem‑sucedida, faça o commit:

```bash
git add .
git commit -m "feat(lab01): implementa VPC Fundamentals com módulos e validação

- Cria VPC, subnets, NACL, IGW, NAT, route tables, security groups, endpoints, IAM e EC2
- Aplica tags organizacionais via default_tags
- Adiciona testes de conectividade e documentação
- Segue boas práticas do Well-Architected Framework"
```

## 🧹 Limpeza

Para evitar custos, destrua todos os recursos quando não forem mais necessários:

```bash
terraform destroy -var-file="envs/dev/terraform.tfvars" -auto-approve
```

## 📚 Referências

- [Tutorial original – AWS Networking Immersion Day](https://catalog.workshops.aws/networking/en-US)
- [Documentação do Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

```

