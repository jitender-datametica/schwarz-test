create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_SCHNITT_SPR_ZU_2(
	MANDANT_ID,
	SCHNITT_ID,
	SPR_ID,
	SEK_SCHL_TYP_ID,
	SEK_SCHL_ID,
	SCHNITT_BEZ
) as
   SELECT
   v01.mandant_id, v01.schnitt_id, v01.spr_id, v01.sek_schl_typ_id, v01.sek_schl_id, v01.schnitt_bez

   FROM dbp_view.v_flw_schnitt_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.sek_schl_typ_id in ('M', 'P');