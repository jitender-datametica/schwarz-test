CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_lago_supp_item_wh_1
(
  client_id
  , country_iso_cd
  , wh_id
  , supplier_id
  , item_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT
  client_id
  , country_iso_cd
  , wh_id
  , supplier_id
  , item_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
FROM P_LEW_MART_CS.v_lago_supp_item_wh_1;