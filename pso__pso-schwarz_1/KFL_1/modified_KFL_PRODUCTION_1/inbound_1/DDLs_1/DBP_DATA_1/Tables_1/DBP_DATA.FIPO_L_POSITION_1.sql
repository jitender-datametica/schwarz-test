--==============================================================
-- Table: fipo_l_position_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_position_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_POSITION_1 (
   fipo_pos_id                         INTEGER     NOT NULL COMMENT 'Eindeutige ID einer FIPO-Position aus dem Quellfeld pos_id',
   fipo_pos_kbez                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Kurzbezeichnung der FIPO_Position aus dem Quellfeld pos_kuerzel, z.Bsp. HL_1, VKL_1',
   fipo_pos_nr                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Nummer einer Position',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_POSITION PRIMARY KEY (fipo_pos_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookup Tabelle der FIPO-Positionen aus der Quelltabelle positionen';

