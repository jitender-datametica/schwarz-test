CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_2 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice.'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
local_np_discount_nr STRING(100) NOT NULL
OPTIONS(description='Unique identifier of  a non personalized discount within the country_2/ tenant.'),
np_discount_nr INTEGER NOT NULL OPTIONS(description='Global unique identifier of  a non personalized discount.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid) NOT ENFORCED
) OPTIONS(description='Non-personalized discount, excluding Lidl Plus.');