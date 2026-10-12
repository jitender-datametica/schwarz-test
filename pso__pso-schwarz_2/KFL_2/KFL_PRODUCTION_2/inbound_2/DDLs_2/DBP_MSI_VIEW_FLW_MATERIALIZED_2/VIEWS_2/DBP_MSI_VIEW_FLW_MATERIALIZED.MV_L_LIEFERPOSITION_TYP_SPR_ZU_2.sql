create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_LIEFERPOSITION_TYP_SPR_ZU_2(
	LIEF_POS_TYP_ID,
	MANDANT_ID,
	SPR_ID,
	LIEF_POS_TYP_BEZ
) as
   SELECT
   v01.lief_pos_typ_id, v01.mandant_id, v01.spr_id, v01.lief_pos_typ_bez

   FROM dbp_view.v_flw_lieferpos_typ_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;