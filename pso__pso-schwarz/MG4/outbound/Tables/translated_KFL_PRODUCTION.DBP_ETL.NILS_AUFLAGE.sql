CREATE OR REPLACE TABLE kfl_production_dbp_etl.nils_auflage (
landkz STRING(10) COLLATE 'und:ci',
markt_id STRING(20) COLLATE 'und:ci',
markt_bez STRING(100) COLLATE 'und:ci',
kundenzeitung_id STRING(20) COLLATE 'und:ci',
kundenzeitung_bez STRING(100) COLLATE 'und:ci',
verteilgebiet_id STRING(20) COLLATE 'und:ci',
verteilgebiet_bez STRING(100) COLLATE 'und:ci',
anz_verteilgebiet STRING(20) COLLATE 'und:ci',
anz_marktauslage STRING(20) COLLATE 'und:ci',
mandant_id INTEGER,
wup_id INTEGER,
geku_profitcenter STRING(20),
geku_gl_vorname STRING(255),
geku_gl_nachname STRING(255),
geku_gl_ldapuser STRING(20),
td_insert TIMESTAMP,
td_update TIMESTAMP
);