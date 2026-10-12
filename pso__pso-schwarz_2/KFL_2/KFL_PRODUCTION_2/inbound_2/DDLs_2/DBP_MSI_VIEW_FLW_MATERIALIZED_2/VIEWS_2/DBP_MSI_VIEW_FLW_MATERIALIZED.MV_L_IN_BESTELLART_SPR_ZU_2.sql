create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_BESTELLART_SPR_ZU_2(
	MANDANT_ID,
	BESTELLART_ID,
	BESTELL_TYP_ID,
	BESTELLART_BEZ,
	SPR_ID
) as
   SELECT
   v01.mandant_id, v01.bestellart_id, v01.bestell_typ_id, v01.bestellart_bez, v01.spr_id

   FROM dbp_view.v_flw_bestellart_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id in (1,2);