create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_BEWART_SPR_ZU_1(
	SPR_ID,
	BEWART_ID,
	BEWART_BEZ,
	MANDANT_ID
) as
   SELECT
  v01.spr_id, v01.bewart_id, v01.bewart_bez, v01.mandant_id

   FROM dbp_view.v_bewart_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id in (1,2);