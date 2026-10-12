create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_LEISTUNGSART_SPR_ZU(
	MANDANT_ID,
	BELOS_LEISTUNGSART_ID,
	SPR_ID,
	BELOS_LEISTUNGSART_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.belos_leistungsart_id,
   v01.spr_id,
   v01.belos_leistungsart_bez
FROM
   dbp_view.v_belos_leistungsart_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;