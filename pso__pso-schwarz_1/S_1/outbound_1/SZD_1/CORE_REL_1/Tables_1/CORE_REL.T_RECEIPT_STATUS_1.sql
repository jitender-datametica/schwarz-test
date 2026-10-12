/* --------------------------------------------------------------------------------
   DDL for table: T_RECEIPT_STATUS_1
   generated from Powerdesigner on Montag, 17. Juli 2023 11:08:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_receipt_status_1 (
receipt_status_cd STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the receipt status.'),
receipt_status_wwt_cd STRING(250) NOT NULL
OPTIONS(description='The identifier of the receipt status_1 from the WWT system.'),
receipt_status_name STRING(100) NOT NULL OPTIONS(description='Descriptive Attribute - The name of the receipt status.'),
receipt_status_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - A brief description of the receipt status.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source.'),
PRIMARY KEY (receipt_status_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - Contains the possible status_1 values for an order position. - Source - Manual');