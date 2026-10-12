CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORT_BEWART_SPR_ZU (
   mandant_id,
   lvs_bewart_id,
   lagernummer_id,
   spr_id,
   lvs_bewart_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.lvs_bewart_id,
   v01.lagernummer_id,
   v01.spr_id,
   v01.lvs_bewart_bez
FROM
   dbp_view.v_transport_bewart_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;