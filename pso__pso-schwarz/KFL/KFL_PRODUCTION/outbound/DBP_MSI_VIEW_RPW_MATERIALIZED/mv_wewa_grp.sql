CREATE OR REPLACE TABLE dbp_msi_view_rpw_materialized.mv_wewa_grp (
wewa_gruppe_id INTEGER,
vorgangsart_id STRING(2) COLLATE 'und:ci',
open_fg INTEGER,
gemeldet_fg INTEGER,
teilgebucht_fg INTEGER,
wewa_grp_bez STRING(40) COLLATE 'und:ci'
);