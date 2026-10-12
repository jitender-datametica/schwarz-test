CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORT_GV_SPR_ZU (
   mandant_id,
   transport_gv_id,
   spr_id,
   transport_gv_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.transport_gv_id,
   v01.spr_id,
   v01.transport_gv_bez
FROM
   dbp_view.v_transport_gv_spr_zu v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;