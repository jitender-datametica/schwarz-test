create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_LEISTUNGSART_SPR_ZU_2(
	MANDANT_ID,
	CO_LEISTUNGSART_ID,
	SPR_ID,
	CO_LEISTUNGSART_BEZ_KURZ,
	CO_LEISTUNGSART_BEZ_LANG
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.co_leistungsart_id,
   v01.spr_id,
   v01.co_leistungsart_bez_kurz,
   v01.co_leistungsart_bez_lang
FROM
   dbp_view.v_in_leistungsart_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;