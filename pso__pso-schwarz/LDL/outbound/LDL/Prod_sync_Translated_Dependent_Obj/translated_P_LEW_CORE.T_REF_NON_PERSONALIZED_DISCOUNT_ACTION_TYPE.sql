CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_non_personalized_discount_action_type (
np_discount_action_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the action type for the non personalized discount.'),
np_discount_action_type_name STRING(100) NOT NULL
OPTIONS(description='Name of the action type for the non personalized discount.'),
np_discount_action_type_descr STRING(250) NOT NULL
OPTIONS(description='Description of the action type for the non personalized discount.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_action_type_cd) NOT ENFORCED
) OPTIONS(description='This table contains the different action type for a non personalized discount.');