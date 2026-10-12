create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_PRODUKTGRUPPE_SPR_ZU_2(
	MANDANT_ID,
	PRODUKTGRUPPE_ID,
	PRODUKTGRUPPE_BEZ
) as

   SELECT   v01.mandant_id, v01.produktgruppe_id, v01.produktgruppe_bez
   FROM dbp_view.v_flw_produktgruppe_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;