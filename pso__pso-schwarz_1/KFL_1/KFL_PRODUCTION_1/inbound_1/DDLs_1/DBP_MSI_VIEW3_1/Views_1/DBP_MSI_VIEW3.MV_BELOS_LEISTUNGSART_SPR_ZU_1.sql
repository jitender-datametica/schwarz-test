CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_LEISTUNGSART_SPR_ZU_1 (
   mandant_id,
   belos_leistungsart_id,
   spr_id,
   belos_leistungsart_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.belos_leistungsart_id,
   v01.spr_id,
   v01.belos_leistungsart_bez
FROM
   dbp_view.v_belos_leistungsart_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;