CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_non_personalized_discount_method_2 (
np_discount_method_cd STRING(100) NOT NULL
OPTIONS(description='Code of the calculation method of a non personalized discount for the new price.'),
np_discount_method_name STRING(100) NOT NULL
OPTIONS(description='Nameof the calculation method of a non personalized discount for the new price.'),
np_discount_method_descr STRING(250) NOT NULL
OPTIONS(description='Description of the calculation method of a non personalized discount for the new price.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_method_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the different calculation method of a non personalized discount for the new price.');