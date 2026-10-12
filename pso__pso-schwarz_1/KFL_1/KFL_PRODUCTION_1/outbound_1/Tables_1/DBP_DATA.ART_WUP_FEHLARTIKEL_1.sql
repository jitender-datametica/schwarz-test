--==============================================================
-- Table: art_wup_fehlartikel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_fehlartikel_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_fehlartikel_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_letzter_we DATE NOT NULL OPTIONS(description='Datum des letzten Wareneingangs'),
dat_letzter_umsatz DATE OPTIONS(description='Datum letzter Umsatz'),
fehlartikel_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichen, ob Fehlartikel. Ausprägungen: Fehlartikel ja, Fehlartikel nein, nicht relevant'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id) NOT ENFORCED
) OPTIONS(description='VIS - abgeleitete Tabelle zur Ermittlung der Fehlartikel, innerhalb des DWH versorgt');