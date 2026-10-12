--==============================================================
-- Table: user_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_zek_zu
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:18:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.user_zek_zu (
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (zek_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - alle Zentraleinkäufer, auf deren Artikel / Warengruppen ein User Anzeigeberechtigung hat');