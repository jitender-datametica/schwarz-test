--==============================================================
-- Table: ersteller_rpw_gruppe_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ersteller_rpw_gruppe_zu_per_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ersteller_rpw_gruppe_zu_per_2 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
ersteller_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger Schluessel fuer einen RPW User/Verursacher.'),
gruppe_id STRING(20) NOT NULL
OPTIONS(description='Schluessel fuer eine_2 Gruppe_2 von RPW Usern. Zusammen mit einer Abteilung kann die Gruppe_2  eindeutig identifiziert werden.  '),
abteilung_id STRING(20) NOT NULL OPTIONS(description='Eindeutiger Schluessel zur Indentifikaltion einer RPW Abteilung.'),
dat_von DATE NOT NULL OPTIONS(description='Gueltigkeitsbeginn der Zuordnung User zu Abteilung/Gruppe_2;'),
dat_bis DATE OPTIONS(description='Gueltigkeitsende der Zuordnung User zu Abteilung/Gruppe_2;'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, ersteller_id, gruppe_id, abteilung_id, dat_von) NOT ENFORCED
) OPTIONS(description='RPW - Zeitabhaengige Zuordnung der RPW User/Verursacher zu einer Gruppe_2/Abteilung.');