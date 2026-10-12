CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_salesforce_comment (
row_num BIGNUMERIC(38),
item_ian BIGNUMERIC(38),
range_plan_cd BIGNUMERIC(38),
mdm_item_name STRING(200),
description_sentiment BIGNUMERIC(38),
sentiment_type BIGNUMERIC(38),
number_words BIGNUMERIC(38),
case_number STRING(200),
prod_nr BIGNUMERIC(38),
variant_nr BIGNUMERIC(38),
variant_title STRING(200),
created_date DATE,
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME
);