create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_PRODH_LVL_2_SPR_ZU(
	MANDANT_ID,
	SPR_ID,
	PRODH_LVL_2,
	PRODH_LVL_2_BEZ
) as

   SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_2, v01.art_col_bez     AS prodh_lvl_2_bez

   FROM dbp_view.v_flw_art_col_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE flw_art_col_id =2;