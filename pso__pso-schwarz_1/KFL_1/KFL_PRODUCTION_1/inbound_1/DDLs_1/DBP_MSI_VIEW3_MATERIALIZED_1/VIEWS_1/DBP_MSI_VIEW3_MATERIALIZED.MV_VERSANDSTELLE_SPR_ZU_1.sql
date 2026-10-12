create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_VERSANDSTELLE_SPR_ZU_1(
	MANDANT_ID,
	VERSANDSTELLE_ID,
	VERSANDSTELLE_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.versandstelle_id,
   v01.versandstelle_bez
FROM
   dbp_view.v_versandstelle_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;