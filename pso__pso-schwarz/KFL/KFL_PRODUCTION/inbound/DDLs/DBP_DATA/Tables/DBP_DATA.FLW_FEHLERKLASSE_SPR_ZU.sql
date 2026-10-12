--==============================================================
-- Table: flw_fehlerklasse_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_fehlerklasse_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_FEHLERKLASSE_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   fehlerklasse_id                     NUMBER(38,0)     NOT NULL COMMENT 'ID der Fehlerklasse, z.Bsp. 00 aus fehlerklasse',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   fehlerklasse_bez                    VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Fehlerklasse, z.Bsp. 70 Punkte, aus kurztext',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_FEHLERKLASSE_SPR_ZU PRIMARY KEY (mandant_id, fehlerklasse_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fehlerklasse aus tq17t';

