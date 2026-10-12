create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_PRODGRUPPE_INT_SPR_ZU(
	PRODUKTGRUPPE_INT_ID,
	PRODUKTGRUPPE_BEZ
) as

   SELECT      v01.produktgruppe_id AS produktgruppe_int_id, v01.produktgruppe_bez
   FROM dbp_view.v_flw_produktgruppe_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   WHERE
   v01.mandant_id = 2;