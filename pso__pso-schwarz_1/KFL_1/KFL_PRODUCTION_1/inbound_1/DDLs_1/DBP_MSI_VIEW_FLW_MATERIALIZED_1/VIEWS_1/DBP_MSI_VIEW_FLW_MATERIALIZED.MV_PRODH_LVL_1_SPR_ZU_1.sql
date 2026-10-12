create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_PRODH_LVL_1_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	PRODH_LVL_1,
	PRODH_LVL_1_BEZ
) as 
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_1,  prodh_lvl_1_bez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_PRODH_LVL_1_SPR_ZU_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;