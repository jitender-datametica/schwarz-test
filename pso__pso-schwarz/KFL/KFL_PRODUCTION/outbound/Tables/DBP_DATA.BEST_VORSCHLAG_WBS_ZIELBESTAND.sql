--==============================================================
-- Table: best_vorschlag_wbs_zielbestand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_vorschlag_wbs_zielbestand
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_vorschlag_wbs_zielbestand (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
dat_bedarf_von DATE NOT NULL OPTIONS(description='Datum Beginn Bedarfsperiode'),
dat_bedarf_bis DATE NOT NULL OPTIONS(description='Datum Ende Bedarfsperiode'),
dat_letzte_nachversorgung DATE NOT NULL OPTIONS(description='Datum für den letzten Nachversorgungtag'),
zielendbestand_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Zielendbestand für Austrittszeitpunkt in der WBS-Periode'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, art_id, nb_id) NOT ENFORCED
)
OPTIONS(description='Tabelle zur Speicherung der Zielendbestände. Der Zielendbestand ist die erwartete Menge nach dem Ende der Werbenachversorgung.');