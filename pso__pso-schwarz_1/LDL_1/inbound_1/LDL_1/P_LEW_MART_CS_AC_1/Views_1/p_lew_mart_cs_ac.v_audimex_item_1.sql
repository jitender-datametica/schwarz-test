CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_audimex_item_1
(
    client_id
  , country_iso_cd
  , orig_item_nr
  , item_descr
  , plu_nr
  , subitemgroup_id
  , descr_short
  , ag_reserve
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT  
    client_id
  , country_iso_cd
  , orig_item_nr
  , item_descr
  , plu_nr
  , subitemgroup_id
  , descr_short
  , ag_reserve
  , cs_updated
  , cs_created
  , cs_load_id
FROM    P_LEW_MART_CS.v_audimex_item_1;
