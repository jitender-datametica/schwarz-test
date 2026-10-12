create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_TIERGATTUNG_SPR_ZU(
	MANDANT_ID,
	TIERGATTUNG_ID,
	TIERGATTUNG_BEZ
) as

   SELECT
   mandant_id, tiergattung_id, tiergattung_bez


   FROM dbp_view.v_flw_tiergattung_spr_zu   v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;