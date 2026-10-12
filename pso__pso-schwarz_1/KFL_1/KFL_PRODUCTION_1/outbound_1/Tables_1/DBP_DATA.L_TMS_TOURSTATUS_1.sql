--==============================================================
-- Table: l_tms_tourstatus_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_tourstatus_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_tourstatus_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_tourstatus_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Tourstatus. Aus plini.entry'),
tms_tourstatus_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_tour_status im Quellsystem. Aus plini.ini_id. Aus plini.ini_id'),
tms_tourstatus_bez STRING(300) NOT NULL OPTIONS(description='Bezeichnung zum Tourstatus. (Verladen, Abgerechnet,…)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_tourstatus_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Kennzeichnung des Status_1 von Touren mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Tourstadien (z. B. an Abrechnung übertragen, abgerechnet, usw). Aus der Quelle plini (WANKO)');