CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.wbl_gf_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wbl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenbereichsleiter ID'),
gf_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftsführer ID, numerisch'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Zuordnungstabelle WBL (EKL - Einkaufsleiter) zu GF (Geschäftsführer) - wird manuell über MSI (TAS) befüllt');