--==============================================================
-- Table: ereignisquelle_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignisquelle_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNISQUELLE_SPR_ZU_2 (
   spr_id                              INTEGER     NOT NULL COMMENT 'Nummer der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   ereignisquelle_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID der Rolle des Bearbeiters',
   ereignisquelle_bez                  VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Rolle des Erzeugers des Satzes, z.Bsp card_activator',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNISQUELLE_SPR_ZU PRIMARY KEY (spr_id, mandant_id, ereignisquelle_id) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnung der Ereignisquelle';

