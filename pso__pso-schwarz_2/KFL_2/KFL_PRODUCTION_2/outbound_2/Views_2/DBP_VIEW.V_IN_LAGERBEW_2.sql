CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_lagerbew_2 AS SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 dat_buch,
 dat_erfasst,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_lagerbew_2;