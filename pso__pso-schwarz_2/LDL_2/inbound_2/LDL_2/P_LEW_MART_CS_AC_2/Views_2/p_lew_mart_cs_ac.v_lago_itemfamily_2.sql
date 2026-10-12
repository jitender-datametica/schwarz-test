CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_lago_itemfamily_2
(
    client_id
  , country_iso_cd
  , dat_rec_start
  , dat_rec_end
  , item_familygroup_id
  , itemfamily_cd
  , desc_short
  , desc_long  
  , language_id
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
  SELECT
      a.client_id
    , a.country_iso_cd
    , a.dat_rec_start
    , a.dat_rec_end
    , a.item_familygroup_id
    , a.itemfamily_cd
    , a.desc_short
    , a.desc_long  
    , a.language_id   
    , a.cs_updated
    , a.cs_created
    , a.cs_load_id
  FROM P_LEW_MART_CS.v_lago_itemfamily_2 a;