create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_PRODH_LVL_3_SPR_ZU(
	MANDANT_ID,
	SPR_ID,
	PRODH_LVL_3,
	PRODH_LVL_3_BEZ
) as 
SELECT
   v01.mandant_id, v01.spr_id, prodh_lvl_3, prodh_lvl_3_bez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_PRODH_LVL_3_SPR_ZU v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;