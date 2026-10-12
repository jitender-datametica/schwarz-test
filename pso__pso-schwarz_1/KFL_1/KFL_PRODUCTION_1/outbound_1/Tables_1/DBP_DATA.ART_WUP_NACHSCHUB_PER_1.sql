--==============================================================
-- Table: art_wup_nachschub_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_nachschub_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_nachschub_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Datum gültig ab -  im Format JJJJ-MM_1-TT'),
dat_bis DATE OPTIONS(description='Datum gültig bis - m Format JJJJ-MM_1-TT'),
menge_bestand_soll_max NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Maximaler Sollbestand (PRWOG)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
) OPTIONS(description='LIS - Nachschub: Mengen pro Kunde/Artikel_1 (tagesaktuell) - SAP RET - Tabelle WRPL');