create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_LAGER_BEWART_SPR_ZU(
	LAGER_BEWART_ID,
	LAGER_BEWART_BEZ,
	MANDANT_ID
) as
   SELECT
  lager_bewart_id, lager_bewart_bez, mandant_id

   FROM dbp_view.v_lager_bewart_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id in (1,2);