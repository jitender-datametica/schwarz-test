CREATE TABLE P_LEW_PRECORE.T_CACHE_CUSTINFO_EVENTS_2
(
  client_id NUMBER(38,0),
  event_id VARCHAR(200),
  country_code VARCHAR(10),
  src_customerid VARCHAR(100),
  data_type VARCHAR(100),
  sso_client_app_id VARCHAR(200),
  loyalty_cards_loyalty_id VARCHAR(100),
  loyalty_cards_type VARCHAR(100),
  source_name VARCHAR(100),
  date_key DATE,
  valid_time_key TIMESTAMP_NTZ(9),
  l1_insert_time_key TIMESTAMP_NTZ(9),
  scrm_extract_timestamp TIMESTAMP_NTZ(9),
  extraction_dt DATE,
  dwh_load_id NUMBER(38,0),
  dwh_created TIMESTAMP_NTZ(9),
  dwh_updated TIMESTAMP_NTZ(9)
)
;