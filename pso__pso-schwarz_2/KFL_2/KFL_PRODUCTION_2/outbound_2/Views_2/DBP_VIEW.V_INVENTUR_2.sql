CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_2 AS SELECT mandant_id,
 inv_beleg_id,
 gj,
 zaehl_status_id,
 diff_ausb_status_id,
 dat_letzt_zaehl,
 dat_plan_zaehl,
 td_update,
 td_insert
FROM kfl_production_dbp_data.inventur_2;