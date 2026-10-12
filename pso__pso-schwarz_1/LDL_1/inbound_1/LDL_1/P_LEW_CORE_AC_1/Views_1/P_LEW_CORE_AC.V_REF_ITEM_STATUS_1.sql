CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_ITEM_STATUS_1
(
   client_id
   ,item_status_id
   ,item_status_descr
   ,hq_level_fg
   ,wh_level_fg
   ,dwh_load_id
   ,dwh_created
   ,dwh_updated
  )
AS
SELECT
client_id,
item_status_id,
item_status_descr,
hq_level_fg,
wh_level_fg,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_item_status_1 ;


