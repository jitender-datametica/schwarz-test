CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_store_operating_type_2 (
store_operating_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for an operating types for a store  ( regular opening , public holiday , permanent closure)'),
store_operating_type_descr STRING(250) NOT NULL OPTIONS(description='A description for a store operating types'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (store_operating_type_cd) NOT ENFORCED
)
OPTIONS(description='A  reference table containing possible operating types for a store ( Regular opening , Sunday Opening , Permanent Closure , etc)');