from aws_lambda_powertools.utilities.data_classes import event_source, APIGatewayProxyEvent
from names_generator import generate_name


@event_source(data_class=APIGatewayProxyEvent)
def handler(event: APIGatewayProxyEvent, context):
    name = generate_name(style='capital')
    return {
        "statusCode": 200,
        "body": f"Hello {name}!"
    }
