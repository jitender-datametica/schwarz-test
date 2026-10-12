CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_PRUEFMERKMAL_2
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, werk_id
, stp_merkmal_id
)
AS
   SELECT
   v01.mandant_id, v01.werk_id, v01.stp_merkmal_id

   FROM dbp_view.v_flw_l_pruefmerkmal_2 v01;