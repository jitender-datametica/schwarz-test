CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_fin_kategorie AS SELECT fin_kat_hierarchie_id,
 fin_kategorie_id,
 rpm_hierarchie_id,
 fin_kat_version_id,
 fin_kat_version_dat
FROM kfl_production_dbp_data.rpm_fin_kategorie;