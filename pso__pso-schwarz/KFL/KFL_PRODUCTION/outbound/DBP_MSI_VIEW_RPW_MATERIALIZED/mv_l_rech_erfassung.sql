CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_l_rech_erfassung (
mandant_id INTEGER,
erfassung_id STRING(3) COLLATE 'und:ci',
system_id INTEGER,
edi_fg STRING(6)
);