create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_IN_LAGER_BEWART_SPR_ZU(
	LAGER_BEWART_ID,
	MANDANT_ID,
	LAGER_BEWART_BEZ
) as
   SELECT
   v01.lager_bewart_id, v01.mandant_id, v01.lager_bewart_bez

   FROM dbp_view.v_flw_lager_bewart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;