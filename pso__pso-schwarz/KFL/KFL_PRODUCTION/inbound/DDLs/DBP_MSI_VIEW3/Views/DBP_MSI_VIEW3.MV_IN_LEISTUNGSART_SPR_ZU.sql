CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IN_LEISTUNGSART_SPR_ZU (
   mandant_id,
   co_leistungsart_id,
   spr_id,
   co_leistungsart_bez_kurz,
   co_leistungsart_bez_lang
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.co_leistungsart_id,
   v01.spr_id,
   v01.co_leistungsart_bez_kurz,
   v01.co_leistungsart_bez_lang
FROM
   dbp_view.v_in_leistungsart_spr_zu v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;