create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_MITARBEITER_GRUPPE_SPR_ZU_1(
	MANDANT_ID,
	MITARBEITER_GRUPPE_ID,
	MITARBEITER_GRUPPE_BEZ
) as
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id, v01.mitarbeiter_gruppe_bez

   FROM DBP_MSI_VIEW_SHR_MATERIALIZED.TBL_MV_MITARBEITER_GRUPPE_SPR_ZU_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;