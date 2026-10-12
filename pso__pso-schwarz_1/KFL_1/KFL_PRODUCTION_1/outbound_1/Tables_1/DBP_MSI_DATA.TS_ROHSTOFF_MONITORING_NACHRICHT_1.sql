--==============================================================
-- Table: ts_rohstoff_monitoring_nachricht_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_rohstoff_monitoring_nachricht_1
   generated from Powerdesigner on Montag, 22. September 2025 12:38:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_rohstoff_monitoring_nachricht_1 (
nachricht_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Enthält die ID um welchen Nachrichtentyp es sich handelt.            0 = Trend            1 = Märkte            2 = Preisbeeinflussender Faktoren'),
rohstoff_kategorie_kfl_name STRING(300) NOT NULL
OPTIONS(description='Kaufland interne Kategorische Zuordnung eines Rohstoffs.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
nachricht_titel_txt STRING(1000) NOT NULL OPTIONS(description='Enthält den Titel eines Textblocks im Report.'),
nachricht_inhalt_txt STRING(500000) NOT NULL
OPTIONS(description='Kaufland interne Beschreibung der Kategorie des Rohstoffs.'),
trend_typ_id BIGNUMERIC(38,0)
OPTIONS(description='Gibt den Trend der Rohstoffskategorie an für die Einfärbung im Report (0-2).'),
dat_trend_von DATE OPTIONS(description='Gültigkeitsstart des Trend der Kategorie.'),
prognose_halbjahr_typ_id BIGNUMERIC(38,0) OPTIONS(description='Prognosetyp der Kategorie für das Halbjahr an (0-4).'),
nachricht_link_txt STRING(500000)
OPTIONS(description='Hinterlegt einen Link zu Netzlaufwerken/Sharepoint oder ins Internet.'),
preis_reduzierende_faktoren_txt STRING(500000) OPTIONS(description='Beschreibungen von Preisreduzierende Faktoren.'),
preis_steigernde_faktoren_txt STRING(500000) OPTIONS(description='Beschreibungen von Preissteigernde Faktoren.'),
forecast_txt STRING(500000)
OPTIONS(description='Enthält eine_1 Forecast-Beschreibung z.B. Ausblick für das Jahr ist positiv.'),
dat_gueltig_von DATE NOT NULL OPTIONS(description='Gültigkeitsstart des Eintrags.'),
dat_gueltig_bis DATE NOT NULL OPTIONS(description='Gültigkeitsende des Eintrags.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (nachricht_typ_id, rohstoff_kategorie_kfl_name, spr_id, nachricht_titel_txt, nachricht_inhalt_txt)
NOT ENFORCED
) OPTIONS(description='Informationen wie Trend, Märkte und preisbeeinflussender Faktoren einer Rohstoffskategorie.');