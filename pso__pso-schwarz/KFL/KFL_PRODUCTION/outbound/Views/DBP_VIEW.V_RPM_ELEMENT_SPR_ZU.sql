CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_element_spr_zu AS SELECT rpm_element_id,
 spr_id,
 dat_von,
 rpm_element_bez,
 rpm_element_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_element_spr_zu;