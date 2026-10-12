--==============================================================
-- Table: gruppe_user_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gruppe_user_zu_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:01:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.gruppe_user_zu_2 (
gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer Usergruppe'),
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
dat_gueltig_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Gültigkeitsende der Zuordnung des Users zur ZEK_2 Grupppe.(immer bis inkl. des Datums, d.h. bei einem dat_gueltig_bis vom 20.04.2025 wird der User bis und inkl. dem 20.04.2025 der Gruppe_2 zugeteilt).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gruppe_id) NOT ENFORCED
) OPTIONS(description='AIS KMO - Securitytabelle zur Pflege von Usergruppen');