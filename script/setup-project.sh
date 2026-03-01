#!/bin/bash

# Script para gerar a estrutura de diretórios do projeto
# Networking Immersion Day com Terraform

set -e  # interrompe em caso de erro

PROJECT_ROOT="network-immersion-day-tf"

echo "📁 Criando estrutura do projeto em: $PROJECT_ROOT"

# Cria diretório raiz
mkdir -p "$PROJECT_ROOT"

# Função para criar arquivo com conteúdo básico
create_file() {
  local file="$1"
  local content="$2"
  if [ ! -f "$file" ]; then
    echo "$content" > "$file"
    echo "   ✨ Criado: $file"
  else
    echo "   ⏩ Já existe: $file"
  fi
}

# Navega para o diretório do projeto
cd "$PROJECT_ROOT"

# -------------------------
# Arquivo README.md raiz
# -------------------------
create_file "README.md" "# Networking Immersion Day - Laboratórios Terraform

Este repositório contém a implementação em Terraform dos laboratórios do workshop **AWS Networking Immersion Day**, organizados como uma landing zone reutilizável seguindo as melhores práticas do Well-Architected Framework.

## Estrutura

- \`modules/\`: Módulos compartilhados e reutilizáveis.
- \`labs/\`: Laboratórios independentes para cada capítulo do workshop.
- \`global/\`: Recursos compartilhados entre laboratórios (IAM, etc.).
- \`scripts/\": Scripts utilitários (deploy/destroy em lote).
- \`docs/\": Documentação adicional, checklists de boas práticas.

## Pré-requisitos

- Terraform >= 1.3
- AWS CLI configurado
- Bucket S3 e tabela DynamoDB para state remoto (veja cada lab)

## Como usar

1. Navegue até o laboratório desejado: \`cd labs/01-vpc-fundamentals\`
2. Copie \`terraform.tfvars.example\` para \`terraform.tfvars\` e preencha as variáveis.
3. Execute \`terraform init\`, \`terraform plan\`, \`terraform apply\`.
4. Use os scripts em \`scripts/\` para testar a conectividade.
"

# -------------------------
# Módulos compartilhados
# -------------------------
MODULES=(
  "vpc"
  "subnets"
  "security-groups"
  "ec2-instance"
  "vpc-endpoints"
  "transit-gateway"
  "vpc-peering"
  "site-to-site-vpn"
  "network-monitoring"
)

for mod in "${MODULES[@]}"; do
  module_path="modules/$mod"
  mkdir -p "$module_path"

  create_file "$module_path/main.tf" "# Módulo: $mod\n\n# Recursos serão definidos aqui."
  create_file "$module_path/variables.tf" "# Variáveis de entrada para o módulo $mod\n"
  create_file "$module_path/outputs.tf" "# Outputs do módulo $mod\n"
  create_file "$module_path/README.md" "# Módulo Terraform: $mod\n\nDescrição do módulo e exemplos de uso."
done

# -------------------------
# Laboratórios
# -------------------------
LABS=(
  "01-vpc-fundamentals"
  "02-multiple-vpcs"
  "03-security-controls"
  "04-connecting-to-on-premises"
  "05-connecting-to-sdwan"
  "06-network-monitoring"
  "07-advanced-gwlb"
  "08-advanced-tgw-multicast"
)

for lab in "${LABS[@]}"; do
  lab_path="labs/$lab"
  mkdir -p "$lab_path"

  create_file "$lab_path/README.md" "# Laboratório: $lab\n\nObjetivos e instruções específicas."
  create_file "$lab_path/main.tf" "# Configuração principal do laboratório $lab\n\n# Chamada de módulos e recursos específicos."
  create_file "$lab_path/variables.tf" "# Variáveis do laboratório $lab\n"
  create_file "$lab_path/outputs.tf" "# Outputs do laboratório $lab\n"
  create_file "$lab_path/terraform.tfvars.example" "# Exemplo de variáveis para o laboratório $lab\n\n# environment = \"dev\"\n# region      = \"us-east-1\"\n"

  # scripts de teste
  mkdir -p "$lab_path/scripts"
  create_file "$lab_path/scripts/test-connectivity.sh" "#!/bin/bash\n# Script para testar conectividade no laboratório $lab\n\necho \"Testando...\"\n"
  chmod +x "$lab_path/scripts/test-connectivity.sh"

  # ambientes (dev, stage) – opcional
  mkdir -p "$lab_path/envs/dev"
  create_file "$lab_path/envs/dev/terraform.tfvars" "# Configurações para ambiente dev\n"

  mkdir -p "$lab_path/envs/stage"
  create_file "$lab_path/envs/stage/terraform.tfvars" "# Configurações para ambiente stage\n"
done

# -------------------------
# Recursos globais
# -------------------------
mkdir -p "global/iam-policies"
create_file "global/iam-policies/README.md" "# Políticas IAM compartilhadas\n\nPolíticas reutilizadas entre laboratórios."

# -------------------------
# Scripts globais
# -------------------------
mkdir -p "scripts"
create_file "scripts/deploy-all.sh" "#!/bin/bash\n# Aplica todos os laboratórios em ordem (cuidado com dependências)\n"
chmod +x "scripts/deploy-all.sh"

create_file "scripts/destroy-all.sh" "#!/bin/bash\n# Destrói todos os laboratórios (ordem reversa)\n"
chmod +x "scripts/destroy-all.sh"

# -------------------------
# Documentação extra
# -------------------------
mkdir -p "docs"
create_file "docs/well-architected-checklist.md" "# Checklist Well-Architected\n\n## Como os laboratórios aplicam os pilares:\n- **Excelência operacional**\n- **Segurança**\n- **Confiabilidade**\n- **Eficiência de performance**\n- **Otimização de custos**\n"

echo "✅ Estrutura criada com sucesso em '$PROJECT_ROOT'."