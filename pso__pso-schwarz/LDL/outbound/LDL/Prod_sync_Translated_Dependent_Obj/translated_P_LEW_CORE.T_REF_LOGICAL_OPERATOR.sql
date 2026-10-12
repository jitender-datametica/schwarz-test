CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_logical_operator (
logical_operator_cd STRING(100) NOT NULL
OPTIONS(description='Code of  item/itemgroup combination type for a non personalized discount.'),
logical_operator_descr STRING(250) NOT NULL
OPTIONS(description='Description of  item/itemgroup combination type for a non personalized discount.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (logical_operator_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the different item/itemgroup combination type for a non personalized discount.(Mix&Match)');