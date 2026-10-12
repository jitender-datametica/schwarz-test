CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_abschlussgrund_1 (abschlussgrund_id, td_update, td_insert) AS
SELECT abschlussgrund_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_abschlussgrund_1;