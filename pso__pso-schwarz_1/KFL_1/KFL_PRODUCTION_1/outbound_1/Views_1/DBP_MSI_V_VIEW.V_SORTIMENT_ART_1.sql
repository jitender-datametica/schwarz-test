CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_sortiment_art_1 AS SELECT mandant_id,
 art_id,
 gtin_id,
 status_1,
 kjwo_update,
 td_update,
 td_insert
FROM kfl_production_dbp_msi_data.sortiment_art_1;