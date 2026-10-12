CREATE OR REPLACE TABLE szd_production_core_rel.t_invoice_1 (
finance_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the invoice.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
invoice_type_cd STRING(50) NOT NULL OPTIONS(description='The unique type code of the invoice type.'),
consignee_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignee party.'),
consignor_stream_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the of the consignor stream.'),
invoice_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The invoice number provided by the business department creating the invoice.'),
booking_type_cd STRING(50) OPTIONS(description='The code of the booking type (as it comes from WWT).'),
invoice_reference_nr STRING(250) OPTIONS(description='The reference number of the invoice.'),
receipt_txt STRING(1000) OPTIONS(description='The receipt text for this invoice.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (finance_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - Special type of invoice for importing goods from overseas by a Lidl Country. - Source - WWT');