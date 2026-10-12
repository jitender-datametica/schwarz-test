--==============================================================
-- Table: best_blockbestand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_blockbestand
   generated from Powerdesigner on Freitag, 11. März 2022 09:28:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_BLOCKBESTAND (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   best_beleg_id                       INTEGER    NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs',
   best_beleg_pos_id                   INTEGER    NOT NULL COMMENT 'Positionsnummer des Einkaufsbelegs',
   prozess_id                          INTEGER    NOT NULL COMMENT 'Prozessschlüssel',
   wup_id                              INTEGER    COMMENT 'Der "WUP" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Nebenbetrieb. Im bisherigen System die 4 Stelle der Marktnummer',
   art_id                              INTEGER    COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   menge_block                         NUMBER(29,3)    COMMENT 'Gesperrter Bestand',
   menge_block_we                      NUMBER(29,3)    COMMENT 'WE-Sperrbestand in Bestell-ME',
   dat_best_beleg                      DATE            COMMENT 'Datum des Bestellbelegs',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_BLOCKBESTAND PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id, prozess_id) NOT ENFORCED
)  COMMENT = 'Contains block stocks at the order item level from ZEK_BLOCKBEST_PO';
