create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_PRODH_LVL_6_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	PRODH_LVL_6,
	PRODH_LVL_6_BEZ
) as

   SELECT
   v01.mandant_id, v01.spr_id, v01.art_col_auspr  AS prodh_lvl_6, v01.art_col_bez     AS prodh_lvl_6_bez

   FROM dbp_view.v_flw_art_col_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE flw_art_col_id =6;