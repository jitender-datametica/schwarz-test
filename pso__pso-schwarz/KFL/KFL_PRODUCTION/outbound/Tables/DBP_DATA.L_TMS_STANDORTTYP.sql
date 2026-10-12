--==============================================================
-- Table: l_tms_standorttyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_standorttyp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_standorttyp (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_standorttyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Standorttyps. Aus plini.entry'),
tms_standorttyp_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_standort_typ im Quellsystem. Aus plini.ini_id'),
tms_standorttyp_bez STRING(300) NOT NULL
OPTIONS(description='Bezeichnung zum Standorttyp (z. B. Frühmarkt, Lieferant, EWM Lager, usw)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_standorttyp_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Klassifizierung von Standorten für verschiedene Standorttypen (z. B. Frühmarkt, Lieferant, EWM Lager, usw). Aus der Quelle plini (WANKO)');