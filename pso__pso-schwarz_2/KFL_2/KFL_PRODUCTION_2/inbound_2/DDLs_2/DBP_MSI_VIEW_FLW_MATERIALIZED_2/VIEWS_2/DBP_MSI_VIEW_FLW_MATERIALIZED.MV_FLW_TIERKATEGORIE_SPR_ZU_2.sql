create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_TIERKATEGORIE_SPR_ZU_2(
	MANDANT_ID,
	WERK_ID,
	TIERKATEGORIE_ID,
	SPR_ID,
	TIERKATEGORIE_BEZ
) as
   SELECT
   v01.mandant_id, v01.werk_id, v01.tierkategorie_id, v01.spr_id, v01.tierkategorie_bez

   FROM dbp_view.v_flw_tierkategorie_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;