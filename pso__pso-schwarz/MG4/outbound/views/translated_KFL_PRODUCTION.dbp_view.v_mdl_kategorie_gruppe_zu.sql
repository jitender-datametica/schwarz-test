CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mdl_kategorie_gruppe_zu (kategorie_id, kategorie_gruppe_id) AS SELECT
 kategorie_id,
 kategorie_gruppe_id
FROM kfl_production_dbp_data.mdl_kategorie_gruppe_zu;