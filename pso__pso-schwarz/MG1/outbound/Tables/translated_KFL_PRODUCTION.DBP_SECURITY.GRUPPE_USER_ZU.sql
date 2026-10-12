CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_SECURITY.GRUPPE_USER_ZU (
GRUPPE_ID INTEGER NOT NULL OPTIONS(description='Eindeutige ID einer Usergruppe'),
USER_ID STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
DAT_GUELTIG_BIS DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Gültigkeitsende der Zuordnung des Users zur ZEK Grupppe.(immer bis inkl. des Datums, d.h. bei einem dat_gueltig_bis vom 20.04.2025 wird der User bis und inkl. dem 20.04.2025 der Gruppe zugeteilt).'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (GRUPPE_ID) NOT ENFORCED
) OPTIONS(description='AIS KMO - Securitytabelle zur Pflege von Usergruppen');