create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_VW_SPR_ZU_1(
	MANDANT_ID,
	IN_VW_ID,
	SPR_ID,
	VW_BEZ
) as
   SELECT
   v01.mandant_id, v01.flw_vw_id AS in_vw_id, v01.spr_id, v01.vw_bez

   FROM dbp_view.v_flw_vw_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;