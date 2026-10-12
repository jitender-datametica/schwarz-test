--==============================================================
-- Table: l_tms_tourtyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_tourtyp_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_tourtyp_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_tourtyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Tourtyps. Aus plini.entry'),
tms_tourtyp_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_tourtyp_1 im Quellsystem. Aus plini.ini_id'),
tms_tourtyp_bez STRING(300) NOT NULL
OPTIONS(description='Bezeichnung zum Tourtyp. z. B. 105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_tourtyp_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Klassifizierung von Touren für verschiedene Tourtypen (z.B. "01 - Zutour - keine Abrechnung", "02 - Abholung Lieferant", usw). Es dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. Aus der Quelle plini (WANKO)');