--==============================================================
-- Table: anlage_klasse_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_klasse_zu_per
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlage_klasse_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
anlage_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Anlagen Hauptnummer aus anln1'),
anlage_sub_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Anlagen Unternummer aus anln2'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem die Zuordnung gültig ist'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gültig ist. Bei aktiven Zuordnungen ist der 31.12.9999 eingetragen'),
anlage_klasse_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Anlageklasse aus der Quelle anlkl. Als Char-Feld mit führenden Nullen gespeichert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (anlage_sub_id, buchungskreis_id, dat_von, mandant_id) NOT ENFORCED
) OPTIONS(description='IMS - im DWH historisierte Zuordnung zwischen anlage und anlage_klasse');