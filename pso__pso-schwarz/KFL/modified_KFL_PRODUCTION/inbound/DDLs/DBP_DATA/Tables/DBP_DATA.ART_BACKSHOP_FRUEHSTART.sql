--==============================================================
-- Table: art_backshop_fruehstart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_fruehstart
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKSHOP_FRUEHSTART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   fruehstart_menge                    NUMBER(29,3)     COMMENT 'Frühstartmenge des Backartikels (vermutlich  Stückzahl).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKSHOP_FRUEHSTART PRIMARY KEY (mandant_id, art_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Backplan. Vorgabe der Frühstartmenge je Land-Markt-Artikel.';

