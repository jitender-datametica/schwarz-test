--==============================================================
-- Table: buchungskreis_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buchungskreis_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.buchungskreis_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
buchungskreis_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='In diesem Feld sind die Kurztexte für die Buchungskreise in Abhängigkeit von der Sprache hinterlegt.'),
strasse STRING(60) COLLATE 'und:ci' OPTIONS(description='Strasse der Firma aus der Quelle adrc.street'),
plz STRING(10) COLLATE 'und:ci' OPTIONS(description='Postleitzahl aus adrc.postcode1'),
ort STRING(80) COLLATE 'und:ci' OPTIONS(description='Ort aus adrc.city1/city2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, buchungskreis_id, spr_id, system_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die spachabhängigen Kurztexte der Buchungskreise aus der SAP Tabelle T001_1 enthalten - MULTISET.');