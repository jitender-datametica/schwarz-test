--==============================================================
-- Table: flw_storno_nachkauf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_storno_nachkauf_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_STORNO_NACHKAUF_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat                                 DATE             NOT NULL COMMENT 'Tagesdatum - immer zum Samstag einer Kalenderwoche werden die Daten eingespielt',
   storno_fg                           INTEGER     NOT NULL COMMENT 'Stornofall, wenn = 1, Nachkauf, wenn = 0',
   menge_kg_wunsch                     NUMBER(29,3)     NOT NULL COMMENT 'Wunschmenge in Kilogramm',
   menge_kg_ist                        NUMBER(29,3)     NOT NULL COMMENT 'Istmenge in Kilogramm',
   menge_bstmg_wunsch                  NUMBER(29,3)     NOT NULL COMMENT 'Wunschmenge in Bestellmengeneinheit',
   menge_bstmg_ist                     NUMBER(29,3)     NOT NULL COMMENT 'Gesamtmenge erfüllt in Bestellmengeneinheit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_STORNO_NACHKAUF PRIMARY KEY (flw_art_id, werk_id, dat, storno_fg, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Storno- und Nachkaufmengen im Fleischwerk. Quelle ist Hyperion';

