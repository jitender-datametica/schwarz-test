create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_FAKTURAART_SPR_ZU(
	FAKTURAART_ID,
	MANDANT_ID,
	SPR_ID,
	FAKTURAART_BEZ
) as
   SELECT
   v01.fakturaart_id, v01.mandant_id, v01.spr_id, v01.fakturaart_bez

   FROM dbp_view.v_flw_fakturaart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;