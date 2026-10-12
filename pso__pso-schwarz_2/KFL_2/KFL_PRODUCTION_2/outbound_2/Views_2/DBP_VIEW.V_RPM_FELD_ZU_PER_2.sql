CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_feld_zu_per_2 AS SELECT rpm_hierarchie_id,
 rpm_feld_id,
 rpm_tab_id,
 dat_von,
 dat_bis,
 rpm_gewichtung,
 rpm_feld_auspr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_feld_zu_per_2;