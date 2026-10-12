CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_SECURITY.USER_ZEK_ZU_1 (
USER_ID STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
ZEK_ID STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ZEK_ID, MANDANT_ID) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - alle Zentraleinkäufer, auf deren Artikel_1 / Warengruppen ein User Anzeigeberechtigung hat');