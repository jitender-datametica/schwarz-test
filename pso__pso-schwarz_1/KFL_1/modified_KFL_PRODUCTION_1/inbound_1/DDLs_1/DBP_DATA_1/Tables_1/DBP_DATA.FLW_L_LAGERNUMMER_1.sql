--==============================================================
-- Table: flw_l_lagernummer_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_lagernummer_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_LAGERNUMMER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID der Mandanten im DWH; Deutschland entspricht Mandant_ID = 1',
   lagernummer_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer aus lgnum',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_LAGERNUMMER PRIMARY KEY (mandant_id, lagernummer_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Lagernummern aus t300t';

