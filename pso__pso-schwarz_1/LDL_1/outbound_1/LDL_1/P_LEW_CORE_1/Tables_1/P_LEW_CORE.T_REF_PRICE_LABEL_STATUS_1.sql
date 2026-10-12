CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_label_status_1 (
price_label_status_cd STRING(100) NOT NULL OPTIONS(description='The code for the status_1 of electronic price shields.'),
price_label_status_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for the status_1 type of electronic price shields.'),
price_label_producer_name STRING(100) NOT NULL
OPTIONS(description='The name of the company that manufactures price labels.'),
price_label_status_descr STRING(250) OPTIONS(description='The status_1 code description for the electronic price shield.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (price_label_status_cd, price_label_status_type_cd, price_label_producer_name) NOT ENFORCED
)
OPTIONS(description='The list of possible statuses for a price shields.             - Lifecycle (Solum: SUCCESS - TIMEOUT - UNASSIGNED - PROCESSING, Imagotag: ACTIVE - DELETED)             - Warranty (Excluded Warranty, In Warranty , Out of Warranty)             - Connect (Imagotag: ONLINE , OFFLINE, WAITING_FOR_REGISTERING)                          Sources: Manual (ESL)');