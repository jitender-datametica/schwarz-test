--==============================================================
-- Table: inventur_det_kmo_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_det_kmo_1
   generated from Powerdesigner on Freitag, 17. März 2023 10:53:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_det_kmo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
zeitpunkt_inv DATETIME NOT NULL OPTIONS(description='Datum und Zeit_1 der Inventur_1'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_inv NUMERIC(18,3) NOT NULL OPTIONS(description='Invertierte Menge'),
bestand_wert NUMERIC(18,3) NOT NULL OPTIONS(description='Bewerteter, frei verwendbarer Bestand'),
wert_eingabe STRING(1) COLLATE 'und:ci' OPTIONS(description='Neue Eingabewerte'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, zeitpunkt_inv) NOT ENFORCED
) OPTIONS(description='VIS - Daten aller Bestandskorrekturen und -zaehlungen für KMO');