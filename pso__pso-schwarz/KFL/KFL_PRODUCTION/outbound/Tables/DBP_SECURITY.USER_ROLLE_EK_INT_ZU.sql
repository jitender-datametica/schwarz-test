--==============================================================
-- Table: user_rolle_ek_int_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_rolle_ek_int_zu
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:19:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.user_rolle_ek_int_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
rolle_id BIGNUMERIC(38,0) OPTIONS(description='ID der Rolle (Zuweisung ob ZEK, WBL (EKL) oder GF)'),
rolle_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichung der Rolle (ZEK, WBL (EKL) oder GF)'),
zek_id STRING(3) OPTIONS(description='falls Rolle = ZEK steht hier die Zentraleinkäufer - ID'),
wbl_id BIGNUMERIC(38,0) OPTIONS(description='falls Rolle = WBL steht hier die Warenbereichsleiter(EKL) ID '),
gf_id BIGNUMERIC(38,0) OPTIONS(description='falls Rolle = GF steht hier dieGeschäftsführer ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK, WBL oder GF) - wird manuell über MSI (TAS) befüllt');