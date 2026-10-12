--==============================================================
-- Table: best_blockbestand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_blockbestand
   generated from Powerdesigner on Freitag, 11. März 2022 09:28:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_blockbestand (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Einkaufsbelegs'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer des Einkaufsbelegs'),
prozess_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prozessschlüssel'),
wup_id BIGNUMERIC(38,0)
OPTIONS(description='Der "WUP" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Nebenbetrieb. Im bisherigen System die 4 Stelle der Marktnummer'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
menge_block NUMERIC(13,3) OPTIONS(description='Gesperrter Bestand'),
menge_block_we NUMERIC(13,3) OPTIONS(description='WE-Sperrbestand in Bestell-ME'),
dat_best_beleg DATE OPTIONS(description='Datum des Bestellbelegs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, prozess_id) NOT ENFORCED
) OPTIONS(description='Contains block stocks at the order item level from ZEK_BLOCKBEST_PO');