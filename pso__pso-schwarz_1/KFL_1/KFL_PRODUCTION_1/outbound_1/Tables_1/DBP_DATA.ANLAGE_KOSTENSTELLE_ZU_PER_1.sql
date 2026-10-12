--==============================================================
-- Table: anlage_kostenstelle_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_kostenstelle_zu_per_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlage_kostenstelle_zu_per_1 (
anlage_id STRING(20) NOT NULL OPTIONS(description='ID der Anlagen Hauptnummer aus anln1'),
anlage_sub_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Anlagen Unternummer aus anln2'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode '),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem die Zuordnung gültig ist. Bei aktiven Zuordnungen ist der 31.12.9999 eingetragen'),
kostenstelle_id STRING(10) NOT NULL OPTIONS(description='ID der Kostenstelle, z.Bsp. 9676-400'),
geschaeftsbereich_id STRING(4) NOT NULL
OPTIONS(description='Der Geschaeftsbereich ist eine_1 interne Organisationseinheit, fuer den eine_1 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (anlage_id, anlage_sub_id, mandant_id, buchungskreis_id, dat_von) NOT ENFORCED
) OPTIONS(description='IMS - Historisierte Zuordnung der Kostenstelle zur Anlage_1 aus der SAP-Quelle anlz');