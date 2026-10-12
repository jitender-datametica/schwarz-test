--==============================================================
-- Table: lbs_gruppe_user_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_user_zu_2
   generated from Powerdesigner on Donnerstag, 3. Juli 2025 23:59:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_gruppe_user_zu_2 (
lbs_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der LBS-Einkäufergruppe. Gruppe_2 bündelt eine_2 oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich'),
user_id STRING(30) NOT NULL OPTIONS(description='LDAP des User, für welchen die ZEK_2 Zugehörigkeit gepflegt wird.'),
dat_gueltig_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Das Feld zeigt an, bis zu welchem Tag_2 die Zugehörigkeit eines Users zur Einkäufer-Securitygruppe gültig ist. Per default ist eine_2 Gruppenzugehörigkeit immer bis Unendlich\'9999-12-31\' gültig, es sei denn das KFL Security Team pflegt explizit ein anderes Datum über den Transaktionsbericht.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lbs_gruppe_id, user_id) NOT ENFORCED
)
OPTIONS(description='Securitytabelle, KFL EK Fachbereich pflegt die Zugehörigkeit eines Users (LDAP) zu einer oder mehreren LBS Einkäufergruppen.');