--==============================================================
-- Table: l_tms_beschraenkung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_beschraenkung
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_beschraenkung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_beschraenkung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Beschränkung (Nummer der Beschränkung). Aus plbes.besnr'),
tms_beschraenkung_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_beschraenkung im Quellsystem. Aus plbes.bes_id'),
tms_beschraenkung_bez STRING(50) NOT NULL OPTIONS(description='Bezeichnung zur Beschränkung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_beschraenkung_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Verwaltung von Einschränkungen für Touren und Geschäftspartnern, z. B. nur Früh- und/oder Spätanlieferung. Aus der Quelle plbes (WANKO)');