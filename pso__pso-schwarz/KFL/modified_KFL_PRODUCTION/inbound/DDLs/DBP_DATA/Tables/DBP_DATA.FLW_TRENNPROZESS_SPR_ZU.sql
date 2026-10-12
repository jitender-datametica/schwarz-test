--==============================================================
-- Table: flw_trennprozess_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_trennprozess_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRENNPROZESS_SPR_ZU (
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   trennprozess_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   trennprozess_bez                    VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Trennprozesses aus txt40, z.Bsp. "Zerlegung"',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRENNPROZESS_SPR_ZU PRIMARY KEY (werk_id, trennprozess_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Trennprozess Bezeichnungen aus spmeat_tttrprt';

