CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerort_1 (mandant_id, lagerort_id, wup_id, nb_id, lagernummer_id) AS
SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 lagernummer_id
FROM kfl_production_dbp_data.l_lagerort_1;