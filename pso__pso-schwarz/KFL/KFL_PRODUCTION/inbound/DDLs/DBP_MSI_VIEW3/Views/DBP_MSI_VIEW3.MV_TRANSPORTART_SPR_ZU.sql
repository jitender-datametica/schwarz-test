CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTART_SPR_ZU (
   mandant_id,
   spr_id,
   transportart_bez,
   transportart_id
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.spr_id,
   v01.transportart_bez,
   v01.transportart_id
FROM
   dbp_view.v_transportart_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;