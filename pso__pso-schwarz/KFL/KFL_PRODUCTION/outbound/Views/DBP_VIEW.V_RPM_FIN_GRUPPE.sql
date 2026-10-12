CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rpm_fin_gruppe AS SELECT fin_gruppe_hierarchie_id,
 fin_kat_hierarchie_id,
 fin_gruppe_id,
 fin_kategorie_id,
 fin_gruppe_version_id,
 fin_gruppe_version_dat,
 td_update,
 td_insert
FROM kfl_production_dbp_data.rpm_fin_gruppe;