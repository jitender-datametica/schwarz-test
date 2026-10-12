/* --------------------------------------------------------------------------------
   DDL for table: T_INTERNAL_SALES_RECEIPT_2
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_internal_sales_receipt_2 (
sales_receipt_nr STRING(250) NOT NULL OPTIONS(description='The business receipt number of the internal sales_2 receipt.'),
recipient_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party.'),
receipt_dt DATE NOT NULL OPTIONS(description='The date of the receipt.'),
desired_dt DATE NOT NULL OPTIONS(description='The desired delivery date of the client.'),
invoice_dt DATE NOT NULL OPTIONS(description='The date of the invoice.'),
permitted_partial_delivery_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of permitted partial deliveries per position.'),
receipt_condition_nr STRING(250) NOT NULL OPTIONS(description='The number of the receipt condition.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (sales_receipt_nr) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Contains receipts for the internal sale of goods to stores from the LExIS system. - Source - Lexis');