CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_ITEM_STATUS_DESCR_1
(
   client_id
   ,lang_sid
   ,lang_cd
   ,item_status_id
   ,item_status_descr
   ,dwh_load_id
   ,dwh_created
   ,dwh_updated
)
AS
SELECT
client_id,
lang_sid,
lang_cd,
item_status_id,
item_status_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_item_status_descr_1 ;






