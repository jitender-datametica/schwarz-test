--==============================================================
-- Table: gp_branche_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_branche_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_branche_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
gp_branche_id STRING(4) NOT NULL
OPTIONS(description='Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). Referenz zu der Tabelle l_gp_branche'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.'),
gp_branche_bez STRING(40) OPTIONS(description='Sprachabhaengige Kurzbezeichnung der Banchen der Lieferanten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, gp_branche_id, spr_id) NOT ENFORCED
)
OPTIONS(description='RPW - Sprachabhaengige Bezeichnung der Lieferantenbranchen aus der Tabelle T016T des Quellsystems SAP. Es wird fuer jede DWH Sprache ein Eintrag hinterlegt. Standardbezeichnung ist die deusche Bezeichnung.');