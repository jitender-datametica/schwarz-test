create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_WG_ZU_PER_1(
	ART_ID,
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) as
   SELECT
  art_id,
   mandant_id,
   arthiertyp_id,
   wug_id,
   wg_id,
   dat_von,
   dat_bis
   FROM dbp_view.v_art_wg_zu_per_1
   WHERE arthiertyp_id=2
   AND dat_bis = '9999-12-31';