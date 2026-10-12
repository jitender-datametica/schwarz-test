CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_ITEM_DESCR_2
(
    client_id
    , item_sid
    , lang_sid
    , lang_cd
    , item_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   item_sid,
   lang_sid,
   lang_cd,
   item_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core_ac.v_item_descr_2
;