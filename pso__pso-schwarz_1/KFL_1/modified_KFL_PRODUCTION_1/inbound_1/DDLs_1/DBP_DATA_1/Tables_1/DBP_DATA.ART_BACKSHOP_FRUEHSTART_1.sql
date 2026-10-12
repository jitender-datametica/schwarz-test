--==============================================================
-- Table: art_backshop_fruehstart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_fruehstart_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKSHOP_FRUEHSTART_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   fruehstart_menge                    NUMBER(29,3)     COMMENT 'Frühstartmenge des Backartikels (vermutlich  Stückzahl).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKSHOP_FRUEHSTART PRIMARY KEY (mandant_id, art_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Backplan. Vorgabe der Frühstartmenge je Land_1-Markt-Artikel.';

