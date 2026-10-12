create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VERKAUFSORGANISATION_SPR_ZU(
	MANDANT_ID,
	VERKAUFSORGANISATION_ID,
	SPR_ID,
	VERKAUFSORGANISATION_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.verkaufsorganisation_id,
   v01.spr_id,
   v01.verkaufsorganisation_bez
FROM
   dbp_view.v_verkaufsorganisation_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;