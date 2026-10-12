create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_LAGERNUMMER_SPR_ZU_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	LAGERNUMMER_BEZ,
	SPR_ID
) as
   SELECT
   v01.mandant_id, v01.lagernummer_id, v01.lagernummer_bez, v01.spr_id

   FROM dbp_view.v_flw_lagernummer_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;