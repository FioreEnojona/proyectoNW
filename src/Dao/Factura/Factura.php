<?php

namespace Dao\Factura;

use Dao\Table;

class Factura extends Table
{
    public static function obtenerFacturaPorId($id)
    {

        $json = '{
            "id": "5O190127TN364715T",
            "status": "APPROVED",
            "intent": "CAPTURE",
            "payment_source": {
                "paypal": {
                    "name": {
                        "given_name": "John",
                        "surname": "Doe"
                    },
                    "email_address": "[email protected]",
                    "account_id": "QYR5Z8XDVJNXQ"
                }
            },
            "purchase_units": [
                {
                    "reference_id": "d9f80740-38f0-11e8-b467-0ed5f89f718b",
                    "amount": {
                        "currency_code": "USD",
                        "value": "100.00"
                    }
                }
            ],
            "payer": {
                "name": {
                    "given_name": "John",
                    "surname": "Doe"
                },
                "email_address": "[email protected]",
                "payer_id": "QYR5Z8XDVJNXQ"
            },
            "create_time": "2018-04-01T21:18:49Z"
        }';

        return json_decode($json, true);
    }
}
