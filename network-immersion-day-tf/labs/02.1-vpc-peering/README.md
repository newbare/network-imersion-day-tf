Segue abaixo o conteúdo do README para o laboratório **02.1 – VPC Peering**, extraído e adaptado do laboratório 02, mantendo o mesmo padrão de formatação e foco exclusivo no peering.

---

# 🔗 Laboratório 02.1: VPC Peering (Opcional)

## 📘 Visão Geral

Uma **conexão de peering entre VPCs** é uma conexão de rede entre duas VPCs que permite rotear tráfego entre elas usando endereços IPv4 privados ou IPv6. As instâncias em qualquer uma das VPCs podem se comunicar como se estivessem na mesma rede. Você pode criar uma conexão de peering entre suas próprias VPCs ou com uma VPC em outra conta AWS. As VPCs podem estar em regiões diferentes (conexão de peering entre regiões).

Neste laboratório opcional, você estabelecerá conexões de peering entre **VPC A e VPC B**, e entre **VPC A e VPC C**, e verificará que o tráfego flui apenas entre aquelas VPCs com links de peering diretos (não há roteamento transitivo).

> 💡 **Nota:** Este laboratório é **opcional** e não é necessário para prosseguir com os laboratórios seguintes. Caso deseje avançar diretamente para o Transit Gateway, pule este laboratório.

---

## ✅ Pré‑requisitos

Antes de iniciar, certifique-se de que os recursos do laboratório **02 – Multiple VPCs** (ou o laboratório **01 – VPC Fundamentals**) estejam implantados. Você precisa de três VPCs (A, B, C) com subnets públicas/privadas e uma instância EC2 em cada VPC (nas subnets privadas). Se você está utilizando o Terraform, execute o `apply` do laboratório **02.1** (ele já criará toda a infraestrutura necessária). Se estiver seguindo o console, utilize o template CloudFormation fornecido no laboratório 02 para criar o ambiente base.

As VPCs devem ter os seguintes CIDRs não sobrepostos:

- **VPC A:** `10.0.0.0/16`
- **VPC B:** `10.1.0.0/16`
- **VPC C:** `10.2.0.0/16`

Cada VPC deve conter uma instância EC2 em uma subnet privada na zona `us-east-1a` com o agente SSM instalado e perfil IAM adequado para acesso via Session Manager.

---

## 🔧 Configuração do Peering

### 📍 Criar a Conexão de Peering entre VPC A e VPC B

#### 1. Criar a Conexão de Peering

1. No console VPC, clique em **Peering Connections**.
2. Clique em **Create peering connection** no canto superior direito.  
   ![Peering Button](../../img/peering_vpcs_ab_create_button.png)
3. Especifique o nome da conexão de peering como **VPC A <> VPC B**.
4. Em **Select a local VPC to peer with**, selecione **VPC A** como VPC ID (Requester).  
   ![Select Requester](../../img/peering_vpcs_ab_select_requester.png)
5. Em **Select another VPC to peer with**, certifique-se de que **My Account** está selecionado para **Account**.
6. Para **Region**, selecione a região deste workshop (por exemplo, **This Region (us-east-1)**).
7. Para **VPC ID (Accepter)**, selecione **VPC B**.  
   ![Select Accepter](../../img/peering_vpcs_ab_select_accepter.png)
8. Clique em **Create peering connection**.  
   ![Create Connection](../../img/peering_vpcs_ab_create_connection.png)

A nova conexão de peering ficará no estado **Pending Acceptance**.

9. Na tela resultante, em **Actions**, clique em **Accept request**.  
   ![Accept](../../img/peering_vpcs_ab_accept_request.png)
10. No pop-up seguinte, clique em **Accept request**.  
    ![Accept Request Popup](../../img/peering_vpcs_ab_popup_accept.png)
11. Clique em **Modify my route tables now** na tela resultante.  
    ![Modify Route Tables](../../img/peering_vpcs_ab_modify_route_tables.png)

#### 2. Atualizar a Tabela de Rotas na VPC A

1. Selecione a caixa de seleção para a **VPC A Private Route Table**.
2. Role para baixo e clique na aba **Routes**.
3. Clique em **Edit routes**.  
   ![Edit Routes](../../img/peering_vpcs_ab_route_select_vpc_a.png)
4. Adicione uma entrada de rota para "VPC B" usando o CIDR `10.1.0.0/16` e selecionando **Peering Connection** `VPC A <> VPC B` como alvo.  
   ![Add VPC B Route](../../img/peering_vpcs_ab_route_select_vpc_b.png)
5. Clique em **Save changes**.
6. Confirme que a nova rota aparece na aba **Routes**.  
   ![Routes Updated](../../img/peering_vpcs_ab_routes_updated_vpc_a.png)

#### 3. Atualizar a Tabela de Rotas na VPC B

1. Clique em **Route tables**.
2. Selecione a caixa de seleção para a **VPC B Private Route Table**.
3. Clique na aba **Routes**.
4. Clique em **Edit routes**.  
   ![Edit Routes](../../img/peering_vpcs_ab_route_select_vpc_a.png) *(imagem similar)*
5. Adicione uma entrada de rota para VPC A usando o CIDR `10.0.0.0/16` como destino e `VPC A <> VPC B` como alvo.  
   ![Select Target](../../img/peering_vpcs_ab_route_select_vpc_a.png)
6. Clique em **Save changes**.
7. A tabela de rotas será atualizada com as rotas para a conexão de peering.  
   ![Route Table Updated](../../img/peering_vpcs_ab_routes_updated_vpc_b.png)

### 📍 Configurar o Peering entre VPC A e VPC C

#### 1. Criar a Conexão de Peering entre VPC A e VPC C

1. No painel VPC, clique em **Peering Connections**.
2. Clique em **Create peering connection** no canto superior direito.  
   ![Create Connection](../../img/peering_vpcs_ac_button.png)
3. Especifique o nome da conexão de peering como **VPC A <> VPC C**.
4. Em **Select a local VPC to peer with**, selecione **VPC A** como VPC ID (Requester).
5. Em **Select another VPC to peer with**, certifique-se de que **My Account** está selecionado.
6. Para **Region**, selecione a região deste workshop.
7. Para **VPC ID (Accepter)**, selecione **VPC C**.  
   ![Select VPC C](../../img/peering_vpcs_ac_settings.png)
8. Clique em **Create peering connection**.  
   ![Create](../../img/peering_vpcs_ac_create.png)

A nova conexão de peering ficará no estado **Pending Acceptance**.

9. Na tela resultante, em **Actions**, clique em **Accept request**.  
   ![Accept](../../img/peering_vpcs_ac_actions_accept.png)
10. No pop-up seguinte, clique em **Accept request**.
11. Clique em **Modify my route tables now** na tela resultante.  
    ![Modify Route Tables](../../img/peering_vpcs_ac_modify_rt_button.png)

#### 2. Atualizar a Tabela de Rotas na VPC A

1. Selecione a caixa de seleção para a **VPC A Private Route Table**.
2. Role para baixo e clique na aba **Routes**.
3. Clique em **Edit routes**.  
   ![Edit Routes](../../img/peering_vpcs_ac_route_select_vpc_a.png)
4. Adicione uma entrada de rota para "VPC C" usando o CIDR `10.2.0.0/16` e selecionando **Peering Connection** `VPC A <> VPC C` como alvo.  
   ![Add Route](../../img/peering_vpcs_ac_route_select_vpc_c.png)
5. Clique em **Save changes**.  
   ![Save](../../img/peering_vpcs_ac_routes_updated_vpc_a.png)
6. Confirme que a nova rota aparece na aba **Routes**.  
   ![Routes Tab](../../img/peering_vpcs_ac_routes_updated_vpc_a.png)

#### 3. Atualizar a Tabela de Rotas na VPC C

1. Navegue de volta para **Route tables** e selecione a caixa de seleção para a **VPC C Private Route Table**.
2. Clique na aba **Routes**.
3. Clique em **Edit routes**.  
   ![Edit Routes](../../img/peering_vpcs_ac_route_table_vpc_c.png)
4. Adicione uma entrada de rota para VPC A usando o CIDR `10.0.0.0/16` como destino e `VPC A <> VPC C` como alvo.  
   ![Add Route](../../img/peering_vpcs_ac_route_table_vpc_c.png)
5. Clique em **Save changes**.
6. A tabela de rotas será atualizada com as rotas para a conexão de peering.  
   ![Route Table Updated](../../img/peering_vpcs_ac_routes_updated_vpc_c.png)

---

## 🧪 Verificar a Conectividade

### A partir da VPC A

1. Acesse o **Console EC2**.
2. Selecione a instância EC2 **VPC A Private AZ1 Server** e clique em **Connect**.
3. Na aba **Session Manager**, clique em **Connect**.
4. Tente pingar as instâncias nas VPCs B e C usando os endereços privados (conforme definido no Terraform ou no CloudFormation, por exemplo `10.1.1.100` e `10.2.1.100`):

   ```bash
   ping 10.1.1.100 -c 5
   ping 10.2.1.100 -c 5
   ```

   Se o peering e o roteamento estiverem configurados corretamente, você verá respostas de ambas.  
   ![Ping success](../../img/peering_ping_from_vpc_a.png)

### A partir da VPC B

1. Termine a sessão anterior e conecte-se à instância **VPC B Private AZ1 Server** via Session Manager.
2. Pingue a instância na VPC A:

   ```bash
   ping 10.0.1.100 -c 5
   ```

   O ping deve funcionar.

3. Tente pingar a instância na VPC C:

   ```bash
   ping 10.2.1.100 -c 5
   ```

   **Resultado esperado:** falha (100% packet loss). Não há peering direto entre VPC B e VPC C, e o peering VPC **não suporta roteamento transitivo** (ou seja, o tráfego não pode passar de B para A e depois para C).

### A partir da VPC C

1. Conecte-se à instância **VPC C Private AZ1 Server** via Session Manager.
2. Pingue a VPC A (deve funcionar) e a VPC B (deve falhar), confirmando a ausência de rota direta e a falta de transitividade.

---

## 🗑️ Excluir as Conexões de Peering (Opcional)

Caso deseje remover as conexões de peering (por exemplo, para prosseguir com o laboratório de Transit Gateway):

1. No painel VPC, navegue até **Peering Connections**.
2. Selecione a conexão **VPC A <> VPC B**.
3. Em **Actions**, clique em **Delete peering connection**.  
   ![Delete](../../img/peering_vpcs_ab_delete.png)
4. Marque a opção **Delete related route table entries** para evitar rotas órfãs.
5. Digite **delete** na caixa de texto e confirme.
6. Repita para a conexão **VPC A <> VPC C**.

---

## 🚀 Execução com Terraform

Este laboratório pode ser totalmente automatizado com **Terraform** usando os módulos da estrutura `network-immersion-day-tf`. O código está no diretório `labs/02.1-vpc-peering`.

### Pré‑requisitos

- Terraform instalado (versão >= 1.0)
- Credenciais AWS configuradas (via variáveis de ambiente, `~/.aws/credentials` ou perfil)
- Backend remoto (opcional)

### Passos

1. Navegue até o diretório do laboratório:

   ```bash
   cd labs/02.1-vpc-peering
   ```

2. Inicialize o Terraform:

   ```bash
   terraform init
   ```

3. Revise as variáveis no arquivo `envs/dev/terraform.tfvars` e ajuste conforme necessário (tags, região, etc.).

4. Execute o plano para verificar as mudanças:

   ```bash
   terraform plan -var-file="envs/dev/terraform.tfvars"
   ```

5. Aplique a configuração:

   ```bash
   terraform apply -var-file="envs/dev/terraform.tfvars" -auto-approve
   ```

   Isso criará toda a infraestrutura: VPCs, subnets, rotas, instâncias, security groups, conexões de peering e as rotas associadas.

6. Após a criação, os outputs exibirão os IDs das VPCs e das conexões de peering.

### Testes com Terraform

Utilize o Session Manager (conforme descrito na seção anterior) para conectar-se às instâncias e validar a conectividade. Os IPs privados das instâncias são definidos no arquivo de variáveis (por exemplo, `10.0.1.100`, `10.1.1.100`, `10.2.1.100`). Você pode obtê‑los também via outputs do Terraform se tiver configurado.

### Limpeza

Para destruir todos os recursos criados por este laboratório:

```bash
terraform destroy -var-file="envs/dev/terraform.tfvars" -auto-approve
```

---

## 📚 Conclusão

Neste laboratório opcional você:

- Criou duas conexões de peering entre VPCs (A↔B e A↔C).
- Configurou as rotas necessárias nas tabelas de rotas privadas.
- Validou que o tráfego flui apenas entre VPCs com peering direto, confirmando a ausência de roteamento transitivo.
- (Opcional) Removeu as conexões para preparar o ambiente para o laboratório de Transit Gateway.

Este exercício demonstra a simplicidade do VPC Peering para conectar um pequeno número de VPCs, bem como sua limitação em cenários que exigem roteamento complexo ou muitas interconexões.

**Parabéns por concluir o Laboratório 02.1 – VPC Peering!** 🎉

---

Aqui está um **roteiro de teste simples** com os comandos para executar via Session Manager, ideal para colocar no final do README:

---

## 🧪 Roteiro de Testes (Session Manager)

Após a implantação completa do laboratório, utilize os comandos abaixo para validar a conectividade entre as VPCs.

### 1. Conectar à instância da VPC A

1. Acesse o console EC2.
2. Selecione a instância **VPC A Private AZ1 Server**.
3. Clique em **Connect** → aba **Session Manager** → **Connect**.

No terminal da VPC A, execute:

```bash
# Testar ping para VPC B
ping 10.1.1.100 -c 5

# Testar ping para VPC C
ping 10.2.1.100 -c 5
```

**Esperado:** ambos os pings devem funcionar (0% packet loss).

---

### 2. Conectar à instância da VPC B

Repita o processo para a instância **VPC B Private AZ1 Server**.

No terminal da VPC B, execute:

```bash
# Testar ping para VPC A
ping 10.0.1.100 -c 5

# Testar ping para VPC C
ping 10.2.1.100 -c 5
```

**Esperado:**  
- Ping para VPC A: ✅ sucesso  
- Ping para VPC C: ❌ falha (100% loss) – devido à ausência de peering direto e roteamento transitivo.

---

### 3. Conectar à instância da VPC C

Repita para a instância **VPC C Private AZ1 Server**.

No terminal da VPC C, execute:

```bash
# Testar ping para VPC A
ping 10.0.1.100 -c 5

# Testar ping para VPC B
ping 10.1.1.100 -c 5
```

**Esperado:**  
- Ping para VPC A: ✅ sucesso  
- Ping para VPC B: ❌ falha

---

### ✅ Resultado Esperado

| Origem | Destino | Resultado |
|--------|---------|-----------|
| VPC A  | VPC B   | ✅ Sucesso |
| VPC A  | VPC C   | ✅ Sucesso |
| VPC B  | VPC A   | ✅ Sucesso |
| VPC B  | VPC C   | ❌ Falha   |
| VPC C  | VPC A   | ✅ Sucesso |
| VPC C  | VPC B   | ❌ Falha   |

Isso confirma que as conexões de peering diretas estão funcionando e que **não há roteamento transitivo** entre VPC B e VPC C.