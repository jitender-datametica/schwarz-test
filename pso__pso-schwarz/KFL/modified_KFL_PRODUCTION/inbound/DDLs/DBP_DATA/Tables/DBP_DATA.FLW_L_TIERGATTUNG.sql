--==============================================================
-- Table: flw_l_tiergattung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_tiergattung
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_TIERGATTUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   tiergattung_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_TIERGATTUNG PRIMARY KEY (mandant_id, tiergattung_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup Tabelle der Tiergattung aus spmeat_tmtgt';

