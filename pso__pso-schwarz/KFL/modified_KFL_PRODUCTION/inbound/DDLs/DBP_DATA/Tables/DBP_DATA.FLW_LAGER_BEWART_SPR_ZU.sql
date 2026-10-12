--==============================================================
-- Table: flw_lager_bewart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lager_bewart_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGER_BEWART_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Lager Bewegungsart aus bwart',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 ist deutsch',
   lager_bewart_bez                    VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Lager-Bewegungsart',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGER_BEWART_SPR_ZU PRIMARY KEY (mandant_id, lager_bewart_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Lager-Bewegungsarten aus t156t';

