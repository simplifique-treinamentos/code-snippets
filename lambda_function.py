import boto3
import csv

# Inserir nomes dos buckets 
bucket_entrada = 'seu-bucket-entrada'
bucket_saida = 'seu-bucket-saida'

# Inserir nomes dos arquivos
arquivo_entrada = 'pedidos.csv'
arquivo_saida = 'resumo_pedidos.csv'


def lambda_handler(event, context):
    
    # Configurar o cliente S3
    s3 = boto3.client('s3')
    
    try:
        
        # Lê o arquivo CSV de entrada do S3
        response = s3.get_object(Bucket=bucket_entrada, Key=arquivo_entrada)
        conteudo = response['Body'].read().decode('utf-8').splitlines()
    
        # Crio um dicionário para armazenar o resumo por mês
        resumo_por_mes = {}
        
        # Itero pelas linhas do CSV, pulando o cabeçalho e calculo o resumo por mês
        for row in conteudo[1:]:
            data, nome_cliente, valor_total = row.split(',')
            mes = data.split('-')[1]
    
            if mes not in resumo_por_mes:
                resumo_por_mes[mes] = {'quantidade_pedidos': 0, 'valor_total_compras': 0}
    
            resumo_por_mes[mes]['quantidade_pedidos'] += 1
            resumo_por_mes[mes]['valor_total_compras'] += float(valor_total)

    
        # Preparo o resumo como uma lista de listas
        resumo_lista = [['mes', 'quantidade_pedidos', 'valor_total_compras']]
        
        # Adiciono os dados como sublistas
        for mes, dados in resumo_por_mes.items():
            resumo_lista.append([mes, dados['quantidade_pedidos'], dados['valor_total_compras']])

    
        # Preparo o resumo como uma string CSV
        output_csv = '\n'.join([','.join(map(str, row)) for row in resumo_lista])

    
        # Envio o arquivo de saída para o bucket S3
        s3.put_object(Bucket=bucket_saida, Key=arquivo_saida, Body=output_csv.encode('utf-8'))

    
        return {
            'statusCode': 200,
            'body': 'Resumo de pedidos criado com sucesso!'
        }
        
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Erro: {str(e)}'
        }
