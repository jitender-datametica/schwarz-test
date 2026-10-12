CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ladungstraeger (anz_ladtraeger, anz_ladtraeger_orig
, anz_ladtraeger_defekt, art_id, dat_erstellung, handling_unit_id_ext, lagernummer_id, lief_beleg_id, mandant_id, nb_id
, status_ladtraeger, system_id, tour_id, wup_id, kj_lief_beleg) AS SELECT anz_ladtraeger,
 anz_ladtraeger_orig,
 anz_ladtraeger_defekt,
 art_id,
 dat_erstellung,
 handling_unit_id_ext,
 lagernummer_id,
 lief_beleg_id,
 mandant_id,
 nb_id,
 status_ladtraeger,
 system_id,
 tour_id,
 wup_id,
 kj_lief_beleg
FROM kfl_production_dbp_view.v_ladungstraeger
WHERE EXTRACT(YEAR FROM dat_erstellung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;