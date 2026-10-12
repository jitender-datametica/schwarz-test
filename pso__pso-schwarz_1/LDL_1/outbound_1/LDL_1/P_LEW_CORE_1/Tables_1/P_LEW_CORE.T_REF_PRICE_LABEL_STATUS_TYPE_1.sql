CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_label_status_type_1 (
price_label_status_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for the status_1 type of electronic price shields.'),
price_label_status_type_descr STRING(250)
OPTIONS(description='The status_1 type code description for the electronic price shield.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (price_label_status_type_cd) NOT ENFORCED
)
OPTIONS(description='The list of possible status_1 types for a price label.             - Lifecycle (Active, Inactive)             - Warranty (Excluded Warranty, In Warranty, Out of Warranty)             Source: Manual (ESL)');