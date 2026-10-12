CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_qual_instand_2 AS SELECT mandant_id,
 qual_meldung_id,
 ausfall_fg,
 ausfallzeit_sekunden,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_qual_instand_2;