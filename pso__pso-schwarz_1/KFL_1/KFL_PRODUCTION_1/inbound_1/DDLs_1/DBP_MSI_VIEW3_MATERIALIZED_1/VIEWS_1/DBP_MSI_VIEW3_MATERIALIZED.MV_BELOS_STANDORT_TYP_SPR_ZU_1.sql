create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BELOS_STANDORT_TYP_SPR_ZU_1(
	BELOS_STANDORT_TYP_ID,
	SPR_ID,
	BELOS_STANDORT_TYP_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.belos_standort_typ_id,
   v01.spr_id,
   v01.belos_standort_typ_bez
FROM
   dbp_view.v_belos_standort_typ_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;