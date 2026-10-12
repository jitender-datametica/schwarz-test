CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_in_qual_instand (mandant_id, qual_meldung_id, ausfall_fg,
ausfallzeit_sekunden) AS SELECT mandant_id,
 qual_meldung_id,
 ausfall_fg,
 ausfallzeit_sekunden
FROM kfl_production_dbp_view.v_in_qual_instand;