CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS SELECT rpm_feld_id,
 rpm_feld_auspr_id,
 spr_id,
 rpm_tab_id,
 rpm_feld_auspr_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_feld_auspr_spr_zu_1;