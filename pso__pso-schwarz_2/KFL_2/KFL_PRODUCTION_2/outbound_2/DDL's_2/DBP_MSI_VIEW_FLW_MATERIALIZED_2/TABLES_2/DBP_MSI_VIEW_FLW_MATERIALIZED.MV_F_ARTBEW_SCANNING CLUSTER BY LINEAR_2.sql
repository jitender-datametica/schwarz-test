DROP TABLE IF EXISTS kfl_production_dbp_msi_view_flw_materialized.mv_f_artbew_scanning_2;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_f_artbew_scanning_2 (
in_kunde_id INTEGER,
mandant_id INTEGER,
bewart_id INTEGER,
gp_id INTEGER,
art_id INTEGER,
dat DATE,
in_art_id INTEGER,
in_art_nr STRING(20) COLLATE 'und:ci',
gtin_kasse INTEGER,
vorgang_scanned INTEGER,
vorgang_keyed INTEGER,
vorgang_scanned_einzeln INTEGER,
vorgang_keyed_einzeln INTEGER,
anzahl_bon INTEGER,
anzahl_registriert INTEGER
) CLUSTER BY mandant_id, dat;