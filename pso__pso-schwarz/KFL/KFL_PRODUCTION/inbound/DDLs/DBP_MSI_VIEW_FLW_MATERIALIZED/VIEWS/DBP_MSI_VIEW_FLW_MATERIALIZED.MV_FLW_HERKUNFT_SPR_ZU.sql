create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_HERKUNFT_SPR_ZU(
	MANDANT_ID,
	HERKUNFT_ID,
	SPR_ID,
	HERKUNFT_BEZ
) as
   SELECT
   v01.mandant_id, v01.herkunft_id, v01.spr_id, v01.herkunft_bez

   FROM dbp_view.v_flw_herkunft_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;