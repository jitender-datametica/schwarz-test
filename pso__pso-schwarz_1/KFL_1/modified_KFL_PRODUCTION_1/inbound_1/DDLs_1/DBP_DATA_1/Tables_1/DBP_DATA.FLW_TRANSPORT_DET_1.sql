--==============================================================
-- Table: flw_transport_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRANSPORT_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   tour_id                             INTEGER     NOT NULL COMMENT 'LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM',
   komm_bereich_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kommissionierbereich aus Feld KBEREICH',
   kunde_grp_id                        VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Warenempfängergruppe aus Feld WEMPFGRP',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   lkw_postyp_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Positionstyp aus Feld LKW_POSTYP',
   anz_stellplatz_ist                  NUMBER(29,2)      NOT NULL COMMENT 'Erfasste Stellplätze aus Feld ERF_SP',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRANSPORT_DET PRIMARY KEY (tour_id, komm_bereich_id, kunde_grp_id, flw_kunde_id, lkw_postyp_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Transport - SAP FLW (P21) - ZFW_TR_POSTYP';

