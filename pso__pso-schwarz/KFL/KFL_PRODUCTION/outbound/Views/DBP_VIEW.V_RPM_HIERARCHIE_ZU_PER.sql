CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_hierarchie_zu_per AS SELECT rpm_hierarchie_id,
 dat_von,
 dat_bis,
 rpm_bereich_id,
 rpm_ebene_id,
 rpm_hierarchie_mutter_id
FROM kfl_production_dbp_data.rpm_hierarchie_zu_per;