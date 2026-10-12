--==============================================================
-- Table: fipo_l_bereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_bereich_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_BEREICH_2 (
   fipo_bereich_id                     NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id',
   fipo_pruef_modul_id                 NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id',
   fipo_bereich_nr                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Nummer eines FIPO-Bereichs aus dem Quellfeld ber_nr',
   fipo_bereich_gruppe_id              NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id bzw. für Bereiche ohne Gruppe_2 im DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_BEREICH PRIMARY KEY (fipo_bereich_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookuptabelle der FIPO-Bereiche';

