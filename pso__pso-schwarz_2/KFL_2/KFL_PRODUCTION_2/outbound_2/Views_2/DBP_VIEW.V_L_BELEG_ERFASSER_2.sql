CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_beleg_erfasser_2 AS SELECT beleg_erfasser_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_beleg_erfasser_2;