--==============================================================
-- Table: l_platzierungswg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_platzierungswg
   generated from Powerdesigner on Montag, 19. Mai 2025 14:23:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_PLATZIERUNGSWG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   platzierungswg_id                   INTEGER     NOT NULL COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.',
   platzierungswg_nr                   VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Platzierungswarengruppe - nicht-numerischer Schlüssel aus dem Quellsystem.',
   primaere_platzierungswg_nr          VARCHAR(10)      COMMENT 'Nummer der primären Platzierungswarengruppe. Die primäre Platzierungswarengruppe gruppiert mehrere Platzierungswarengruppen für eine gemeinsame Betrachtung des Mengengerüsts.',
   mgg_gruppe_id                       INTEGER     COMMENT 'ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.',
   sok_kategorie_id                    INTEGER     COMMENT 'ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.',
   primaere_relevant_fg                INTEGER     COMMENT 'Der Abweichungsgrad MGG Mengengerüst wird nur für definierte Bereiche ermittelt. Relevant_fg = 1 bedeutet, dass diese primäre Platzierungswarengruppe dafür benötigt wird. Wird manuell gepflegt (VIS SOK).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_PLATZIERUNGSWG PRIMARY KEY (mandant_id, platzierungswg_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - WPL - WaSA Platzierungswarengruppen.';
