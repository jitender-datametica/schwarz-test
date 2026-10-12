CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_SECURITY.GRUPPE_ZEK_ZU (
GRUPPE_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer Usergruppe'),
ZEK_ID STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ALLE_ZEK_FG INTEGER OPTIONS(description='User dieser Gruppe werden allen zeks zugeordnet.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (GRUPPE_ID, ZEK_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description='AIS KMO - Securitytabelle zur Pflege von Usergruppen');