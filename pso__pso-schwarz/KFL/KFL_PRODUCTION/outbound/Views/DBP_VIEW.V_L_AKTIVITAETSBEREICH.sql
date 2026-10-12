CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_aktivitaetsbereich AS SELECT mandant_id,
 lagernummer_id,
 aktivitaetsbereich_id,
 protokolleintraege_fg,
 joined_area_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_aktivitaetsbereich;