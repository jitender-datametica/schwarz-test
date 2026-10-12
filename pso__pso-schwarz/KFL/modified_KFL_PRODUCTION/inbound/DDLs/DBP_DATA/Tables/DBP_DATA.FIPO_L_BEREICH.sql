--==============================================================
-- Table: fipo_l_bereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_bereich
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_BEREICH (
   fipo_bereich_id                     INTEGER     NOT NULL COMMENT 'Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id',
   fipo_pruef_modul_id                 INTEGER     NOT NULL DEFAULT -1 COMMENT 'eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id',
   fipo_bereich_nr                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Nummer eines FIPO-Bereichs aus dem Quellfeld ber_nr',
   fipo_bereich_gruppe_id              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID der FIPO-Bereichsgruppe aus dem Quellfeld bgr_id bzw. für Bereiche ohne Gruppe im DWH generiert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_BEREICH PRIMARY KEY (fipo_bereich_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookuptabelle der FIPO-Bereiche';

