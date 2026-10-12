create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_PREISTYP(
	PREISTYP_ID,
	MANDANT_ID,
	PREISTYP_BEZ
) as
   SELECT

   v01.preistyp_id, v01.mandant_id, v01.preistyp_bez

   FROM dbp_view.v_l_preistyp v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;