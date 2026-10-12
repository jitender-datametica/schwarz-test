--==============================================================
-- Table: l_tms_auftragsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_auftragsart
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_auftragsart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftragsart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Auftragsart. Aus plini.entry'),
tms_auftragsart_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_auftragsart im Quellsystem. Aus plini.ini_id'),
tms_auftragsart_bez STRING(300) NOT NULL OPTIONS(description='Bezeichnung zur Auftragsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftragsart_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Klassifizierung von TMS Aufträgen mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Auftragsarten. Aus der Quelle plini (WANKO)');