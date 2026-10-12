--==============================================================
-- Table: flw_lagernummer_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagernummer_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGERNUMMER_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID der Mandanten im DWH; Deutschland entspricht Mandant_ID = 1',
   lagernummer_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer aus lgnum',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   lagernummer_bez                     VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Lagernummer aus lnumt',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGERNUMMER_SPR_ZU PRIMARY KEY (mandant_id, lagernummer_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Lagernummern aus t300t';

