create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_OWG_SPR_ZU_1(
	OWG_ID,
	OWG_BEZ,
	OWG_ID_BEZ,
	MANDANT_ID,
	ARTHIERTYP_ID,
	SPR_ID
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.owg_id,
   v01.owg_bez,
   owg_id_bez,
   v01.mandant_id,
   v01.arthiertyp_id,
   v01.spr_id
FROM
   DBP_MSI_VIEW3_MATERIALIZED.tbl_mv_owg_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.arthiertyp_id = 2;