--==============================================================
-- Table: art_backprogramm_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backprogramm_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKPROGRAMM_ZU_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   back_programm_id                    INTEGER     NOT NULL COMMENT 'ID des Backprogramms aus bake_program. Numerischer Wert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKPROGRAMM_ZU PRIMARY KEY (art_id, mandant_id, back_programm_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Diese Tabelle ordnet den Artikeln die Backprogramme zu. Quelle ist die SAP-Klassenbibliothek';

