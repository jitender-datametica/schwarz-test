CREATE OR REPLACE TABLE share_platform_uapc_etl.uapc_condition_discount_mapping (
mandant_id BIGNUMERIC(38,0) NOT NULL,
bon_id STRING(100) NOT NULL,
bon_dat DATE,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_zeile BIGNUMERIC(38,0) NOT NULL,
konditionsart_id STRING(50),
position_value STRING(50),
discount_value STRING(50),
condition_value STRING(50),
aktion_id STRING(50),
konditionsart_prio STRING(50),
id STRING(50),
c_order STRING(50),
serialnumbersection STRING(50)
);