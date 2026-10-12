CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_risikoklasse_2 (geku_risikoklasse_id, td_update, td_insert) AS
SELECT geku_risikoklasse_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_risikoklasse_2;