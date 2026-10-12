CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_nielsen_wug_zu AS SELECT mandant_id,
 art_nielsen_id,
 arthiertyp_id,
 wg_id,
 wug_id
FROM kfl_production_dbp_data.art_nielsen_wug_zu;