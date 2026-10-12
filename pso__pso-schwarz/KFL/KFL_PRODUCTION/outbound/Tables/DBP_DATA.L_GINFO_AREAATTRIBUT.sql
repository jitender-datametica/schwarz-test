CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ginfo_areaattribut (
flaeche_attribut_id BIGNUMERIC(38,0) NOT NULL,
flaeche_attribut_bez STRING(60) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);