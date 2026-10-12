--==============================================================
-- Table: user_rolle_ek_int_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_rolle_ek_int_zu_2
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:19:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.user_rolle_ek_int_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
rolle_id BIGNUMERIC(38,0) OPTIONS(description='ID der Rolle (Zuweisung ob ZEK_2, WBL_2 (EKL) oder GF_2)'),
rolle_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichung der Rolle (ZEK_2, WBL_2 (EKL) oder GF_2)'),
zek_id STRING(3) OPTIONS(description='falls Rolle = ZEK_2 steht hier die Zentraleinkäufer - ID'),
wbl_id BIGNUMERIC(38,0) OPTIONS(description='falls Rolle = WBL_2 steht hier die Warenbereichsleiter(EKL) ID '),
gf_id BIGNUMERIC(38,0) OPTIONS(description='falls Rolle = GF_2 steht hier dieGeschäftsführer ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK_2, WBL_2 oder GF_2) - wird manuell über MSI (TAS) befüllt');