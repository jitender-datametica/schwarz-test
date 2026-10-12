CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_audimex_item_wh_1
(
    client_id
  , country_iso_cd
  , wh_id
  , orig_item_nr
  , case_size
  , item_status_id
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT  
    client_id
  , country_iso_cd
  , wh_id
  , orig_item_nr
  , case_size  
  , item_status_id
  , cs_updated
  , cs_created
  , cs_load_id
FROM P_LEW_MART_CS.v_audimex_item_wh_1;