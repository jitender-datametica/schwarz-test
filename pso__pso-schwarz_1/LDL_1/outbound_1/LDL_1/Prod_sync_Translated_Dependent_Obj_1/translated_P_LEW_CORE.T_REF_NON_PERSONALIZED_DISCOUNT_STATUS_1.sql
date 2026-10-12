CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_non_personalized_discount_status_1 (
np_discount_status_cd STRING(100) NOT NULL OPTIONS(description='Code of the non personalized discount status.'),
np_discount_status_descr STRING(250) NOT NULL
OPTIONS(description='Description of the non personalized discount status.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_status_cd) NOT ENFORCED
) OPTIONS(description='This table contains the different status_1 of a non personalized discount.');