CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_FAKTURA_STATUS_SPR_ZU (
   spr_id,
   mandant_id,
   faktura_status_id,
   faktura_status_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.spr_id,
   v01.mandant_id,
   v01.faktura_status_id,
   v01.faktura_status_bez
FROM
   dbp_view.v_faktura_status_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;