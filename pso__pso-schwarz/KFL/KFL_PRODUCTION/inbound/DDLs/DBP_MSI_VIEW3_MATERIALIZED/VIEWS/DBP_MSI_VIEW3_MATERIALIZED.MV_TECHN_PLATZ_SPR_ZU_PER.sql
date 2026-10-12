create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TECHN_PLATZ_SPR_ZU_PER(
	TECHN_PLATZ_ID,
	SPR_ID,
	DAT_VON,
	DAT_BIS,
	TECH_PLATZ_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.techn_platz_id,
   v01.spr_id,
   v01.dat_von,
   v01.dat_bis,
   v01.tech_platz_bez
FROM
   dbp_view.v_techn_platz_spr_zu_per v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.dat_bis = '9999-12-31';