CREATE OR REPLACE TABLE szd_production_core_rel.t_charge_log (
charge_log_uuid_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The unique identifier of the charge log entry.'),
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code of the charger provider system.'),
emp_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the party.'),
charger_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item.'),
charge_point_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the charge point.'),
customer_application_channel_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the channel.'),
invoice_curr_cd STRING(50) NOT NULL OPTIONS(description='The code identifying the currency used for the invoice.'),
charge_point_tariff_id INTEGER NOT NULL OPTIONS(description='The unique identifier of the charge point tariff.'),
charge_point_cost_rate_id INTEGER NOT NULL OPTIONS(description='The unique identifier of the charge point tariff.'),
roaming_interface_cd STRING(50) OPTIONS(description='The unique code of the roaming interface.'),
roaming_product_id INTEGER NOT NULL OPTIONS(description='The unique identifier of the roaming product.'),
roaming_identification_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the identification type when roaming is used.'),
roaming_identification_data_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - Identification data used for the roaming.'),
charge_log_id INTEGER NOT NULL OPTIONS(description='Descriptive Attribute - Technical key of the DL software.'),
charge_dt DATE NOT NULL OPTIONS(description='The date when the charge process happens.'),
start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp of the beginning of the charging process.'),
end_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp when the charging process was finished.'),
start_local_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - The timestamp of the beginning of the charging process in local time of the charging station.'),
end_local_tmsp TIMESTAMP
OPTIONS(description='Descriptive Attribute - The timestamp of finishing of the charging process in local time of the charging station.'),
duration_total_meas NUMERIC(29,5) OPTIONS(description='Duration of the charging process in seconds.'),
meter_start_meas NUMERIC(29,5) OPTIONS(description='Initial meter reading at the start of charging in watt hours.'),
meter_end_meas NUMERIC(29,5) OPTIONS(description='Final meter reading at the end of charging in watt hours.'),
meter_total_meas NUMERIC(29,5)
OPTIONS(description='Amount of energy consumed during the charging process in watt hours.'),
contract_identifier_nr STRING(250) OPTIONS(description='Descriptive Attribute - The identifier of the contract.'),
session_nr STRING(250) OPTIONS(description='Descriptive Attribute - The identifier of the charging session.'),
signed_values_url_txt STRING(1000) OPTIONS(description='Descriptive Attribute - URL of the signed data.'),
invoice_process_tmsp TIMESTAMP OPTIONS(description='Timestamp of the creation of the invoice.'),
account_document_nr STRING(250) OPTIONS(description='Descriptive Attribute - The number of the account document.'),
total_cost_val NUMERIC(29,5) OPTIONS(description='The total costs as per systems currency.'),
total_amount_of_local_curr_val NUMERIC(29,5) OPTIONS(description='The total costs as per local currency.'),
rate_id INTEGER OPTIONS(description='Descriptive Attribute - The identifier of teh tariff.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
roaming_partner_slug_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The business identifier of the roaming partner slug for this charge event.'),
emp_provider_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The business identifier of the electro mobility provider for this charge event.'),
PRIMARY KEY (charge_log_uuid_nr, charger_provider_system_cd) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Transactional fact capturing an event where a customer charges their electric vehicle. - Source - IOTCharger');