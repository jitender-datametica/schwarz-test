create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_PRODH_LVL_5_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	PRODH_LVL_5,
	PRODH_LVL_5_BEZ
) as
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_5, prodh_lvl_5_bez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.tbl_MV_PRODH_LVL_5_SPR_ZU_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;