CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_lago_item_descr_2
(
    client_id
  , item_id
  , orig_item_nr
  , item_descr
  , language_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
  SELECT
      a.client_id
    , a.item_id
    , a.orig_item_nr
    , a.item_descr
    , a.language_id
    , a.valid_from
    , a.valid_until
    , a.cs_updated
    , a.cs_created
    , a.cs_load_id
  FROM P_LEW_MART_CS.v_lago_item_descr_2 a;