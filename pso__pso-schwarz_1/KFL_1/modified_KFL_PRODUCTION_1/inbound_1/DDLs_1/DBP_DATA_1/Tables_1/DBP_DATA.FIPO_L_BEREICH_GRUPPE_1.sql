--==============================================================
-- Table: fipo_l_bereich_gruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_bereich_gruppe_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_BEREICH_GRUPPE_1 (
   fipo_bereich_gruppe_id              INTEGER     NOT NULL COMMENT 'Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id bzw. für Bereiche ohne Gruppe_1 im DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_BEREICH_GRUPPE PRIMARY KEY (fipo_bereich_gruppe_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookuptabelle der FIPO-Bereichsgruppen';

