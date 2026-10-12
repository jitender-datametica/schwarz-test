CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_geku_gebietsleiter (
gebietsleiter_uid INTEGER,
vertriebsbuero_uid INTEGER,
gebietsleiter_bez STRING(60) COLLATE 'und:ci',
gebietsleiter_ldap STRING(10) COLLATE 'und:ci'
);