CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_nielsen_art_wg_zu_1 AS SELECT mandant_id,
 art_nielsen_id,
 art_id,
 kjwo,
 wg_id,
 wug_id,
 wg_quelle_bez,
 wg_quelle_hierarchie_lvl_id
FROM kfl_production_dbp_data.art_nielsen_art_wg_zu_1;