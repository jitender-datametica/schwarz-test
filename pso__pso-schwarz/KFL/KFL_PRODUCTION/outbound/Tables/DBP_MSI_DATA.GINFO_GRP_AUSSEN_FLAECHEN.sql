CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ginfo_grp_aussen_flaechen (
grp_1_id BIGNUMERIC(38,0) NOT NULL,
grp_2_id BIGNUMERIC(38,0) NOT NULL,
grp_3_id BIGNUMERIC(38,0) NOT NULL,
grp_4_id BIGNUMERIC(38,0) NOT NULL,
kaufland_typ_id STRING(20) COLLATE 'und:ci' NOT NULL,
flaeche_attribut_id BIGNUMERIC(38,0),
quelle_beauftragung BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);