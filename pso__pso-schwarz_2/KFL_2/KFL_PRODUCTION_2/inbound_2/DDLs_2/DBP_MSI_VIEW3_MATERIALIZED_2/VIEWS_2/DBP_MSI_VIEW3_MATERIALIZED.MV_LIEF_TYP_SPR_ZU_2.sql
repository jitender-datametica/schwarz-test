create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIEF_TYP_SPR_ZU_2(
	LIEF_TYP_BEZ,
	LIEF_TYP_ID,
	MANDANT_ID,
	SPR_ID
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lief_typ_bez,
   v01.lief_typ_id,
   v01.mandant_id,
   v01.spr_id
FROM
   dbp_view.v_lief_typ_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;