import json
import boto3

from boto3.dynamodb.conditions import Key
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('clientes')

# Codificador JSON personalizado para lidar com objetos Decimal
class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, Decimal):
            return str(o)
        return super(DecimalEncoder, self).default(o)

def lambda_handler(event, context):
    
    if  event['routeKey'].upper() == 'GET /CLIENTES':
        return listar()
    elif event['routeKey'].upper() == 'GET /CLIENTES/{CPF}':
        cpf = event['pathParameters']['cpf']
        return listarPorCPF(cpf)
    elif event['routeKey'].upper() == 'POST /CLIENTES':
        item = event['body']
        return salvar(item)
    elif event['routeKey'].upper() == 'PUT /CLIENTES/{CPF}':
        cpf = event['pathParameters']['cpf']
        item = event['body']
        return atualizar(cpf, item)
    elif event['routeKey'].upper() == 'DELETE /CLIENTES/{CPF}':
        cpf = event['pathParameters']['cpf']
        return excluir(cpf)
    else:
        return {
            'statusCode': 200,
            'body': "{message:"+ event['routeKey'] + "}"
        }
        
def listar():
    
    try:
        response = table.scan()
        items = response['Items']
        
        # Converte os itens em um formato JSON usando o codificador personalizado
        result = json.dumps(items, indent=2, cls=DecimalEncoder)
        
        return {
            'statusCode': 200,
            'body': result
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }

def listarPorCPF(cpf):
    
    try:

        response = table.query(IndexName='cpf', 
                   KeyConditionExpression=Key('cpf').eq(int(cpf)))


        result = json.dumps(response, indent=2, cls=DecimalEncoder)
        
        return {
            'statusCode': 200,
            'body': result
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erro ao consultar: {cpf}") #{str(e)}
        }
        
def salvar(body):
    
    item = json.loads(body)
    
    try:
        
        response = table.put_item(Item=item)
        
        return {
            'statusCode': 200,
            'body': json.dumps("CPF incluído com sucesso!")
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }
        
def excluir(cpfExcluir):
    
    try:
        
        table.delete_item(
            Key={'cpf': cpfExcluir}
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps(f"CPF {cpfExcluir} excluído com sucesso!")
        }
  
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erro ao excluir: {cpfExcluir} - {str(e)}") #
        }
        
def atualizar(cpfAtualizar, body):
    
    cliente = json.loads(body)
    
    try:
        
        table.update_item(
            Key={'cpf': cpfAtualizar},
            UpdateExpression = "SET idade=:i",
            ExpressionAttributeValues={
                ':i': int(cliente['idade'])
            }
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps(f"CPF {cpfAtualizar} atualizado com sucesso!")
        }

        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erro ao atualizar: {cpfAtualizar} - {str(e)}") #
        }