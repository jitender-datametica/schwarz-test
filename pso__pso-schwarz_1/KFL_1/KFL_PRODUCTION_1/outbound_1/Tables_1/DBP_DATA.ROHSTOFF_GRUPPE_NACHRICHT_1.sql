--==============================================================
-- Table: rohstoff_gruppe_nachricht_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe_nachricht_1
   generated from Powerdesigner on Mittwoch, 22. Oktober 2025 17:54:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohstoff_gruppe_nachricht_1 (
rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'),
rohstoff_gruppe_name STRING(100) NOT NULL OPTIONS(description='Name der Gruppe_1 eines Rohstoffs nach Gruppierungstyp.'),
nachricht_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Enthält die ID um welchen Nachrichtentyp es sich handelt.            0 = Trend            1 = Märkte            2 = Preisbeeinflussender Faktoren'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
nachricht_titel_txt STRING(1000) NOT NULL OPTIONS(description='Enthält den Titel einesTextblocks im Report.'),
nachricht_inhalt_txt STRING(500000) NOT NULL
OPTIONS(description='Kaufland interne Beschreibung der Rohstoffgruppe des Rohstoffs.'),
trend_typ_id BIGNUMERIC(38,0)
OPTIONS(description='Gibt den Trend der Rohstoffsgruppe an für die Einfärbung im Report (0-2).            0 =  Aufwaertstrend            1 =  Abwaertstrend            2 =  Seitwaertstrend'),
dat_trend_von DATE OPTIONS(description='Gültigkeitsstart des Trend der Rohstoffsgruppe.'),
prognose_halbjahr_typ_id BIGNUMERIC(38,0)
OPTIONS(description='Prognosetyp der Rohstoffsgruppe für das Halbjahr an (0-4).            0  =  >+20%            1  =  +5 -20%            2  =  bis + -5%            3  = -5 -20 %            4  = > -20%'),
nachricht_link_txt STRING(500000)
OPTIONS(description='Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'),
preis_reduzierende_faktoren_txt STRING(500000) OPTIONS(description='Beschreibungen von Preisreduzierende Faktoren.'),
preis_steigernde_faktoren_txt STRING(500000) OPTIONS(description='Beschreibungen von Preissteigernde Faktoren.'),
forecast_txt STRING(500000)
OPTIONS(description='Enthält eine_1 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'),
dat_gueltig_von DATE NOT NULL OPTIONS(description='Gültigkeitsstart des Eintrags.'),
dat_gueltig_bis DATE NOT NULL OPTIONS(description='Gültigkeitsende des Eintrags'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name, nachricht_typ_id, spr_id, nachricht_titel_txt,
 nachricht_inhalt_txt) NOT ENFORCED
) OPTIONS(description='Nachrichten (Trend, Markt und Prognose) über Rohstoffskategorie.');