CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.wbl_gf_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wbl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenbereichsleiter ID'),
gf_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftsführer ID, numerisch'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Zuordnungstabelle WBL_1 (EKL - Einkaufsleiter) zu GF_1 (Geschäftsführer) - wird manuell über MSI (TAS) befüllt');