CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_immobilie_spr_zu_1 AS SELECT rpm_immobilie_id,
 spr_id,
 dat_von,
 rpm_immobilie_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_immobilie_spr_zu_1;