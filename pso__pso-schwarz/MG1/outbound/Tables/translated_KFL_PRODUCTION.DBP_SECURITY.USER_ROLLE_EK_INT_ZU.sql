CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_SECURITY.USER_ROLLE_EK_INT_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
USER_ID STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
ROLLE_ID INTEGER OPTIONS(description='ID der Rolle (Zuweisung ob ZEK, WBL (EKL) oder GF)'),
ROLLE_BEZ STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichung der Rolle (ZEK, WBL (EKL) oder GF)'),
ZEK_ID STRING(3) OPTIONS(description='falls Rolle = ZEK steht hier die Zentraleinkäufer - ID'),
WBL_ID INTEGER OPTIONS(description='falls Rolle = WBL steht hier die Warenbereichsleiter(EKL) ID '),
GF_ID INTEGER OPTIONS(description='falls Rolle = GF steht hier dieGeschäftsführer ID'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER - Zuordnungstabelle UserID (LDAP) zu Rolle und entsprechender ID der Rolle (ZEK, WBL oder GF) - wird manuell über MSI (TAS) befüllt');