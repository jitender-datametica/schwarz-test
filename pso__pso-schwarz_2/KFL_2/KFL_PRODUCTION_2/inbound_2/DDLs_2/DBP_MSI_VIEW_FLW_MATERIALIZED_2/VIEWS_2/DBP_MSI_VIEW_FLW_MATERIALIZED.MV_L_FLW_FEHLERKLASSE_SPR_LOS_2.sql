create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_FEHLERKLASSE_SPR_LOS_2(
	MANDANT_ID,
	FEHLERKLASSE_ID,
	SPR_ID,
	FEHLERKLASSE_BEZ
) as
   SELECT
   --  v01.system_id
   v01.mandant_id, v01.fehlerklasse_id, v01.spr_id, v01.fehlerklasse_bez

   FROM dbp_view.v_flw_fehlerklasse_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;