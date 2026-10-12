create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_QUAL_INSTAND(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	AUSFALL_FG,
	AUSFALLZEIT_SEKUNDEN
) as
   SELECT
   mandant_id, qual_meldung_id, ausfall_fg, ausfallzeit_sekunden
   FROM dbp_view.v_in_qual_instand;