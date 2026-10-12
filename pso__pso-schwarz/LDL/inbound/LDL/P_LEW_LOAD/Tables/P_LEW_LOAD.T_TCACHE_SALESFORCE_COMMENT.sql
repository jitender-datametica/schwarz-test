CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_SALESFORCE_COMMENT
(
  row_num NUMBER(38),
  item_ian NUMBER(38),
  range_plan_cd NUMBER(38),
  mdm_item_name VARCHAR(200),
  description_sentiment NUMBER(38),
  sentiment_type NUMBER(38),
  number_words NUMBER(38),
  case_number VARCHAR(200),
  prod_nr NUMBER(38),
  variant_nr NUMBER(38),
  variant_title VARCHAR(200),
  created_date DATE,
  extraction_dt DATE,
  dwh_load_id NUMBER(38),
  dwh_created TIMESTAMP(6),
  dwh_updated TIMESTAMP(6)
)
;