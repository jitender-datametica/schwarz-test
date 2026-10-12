--==============================================================
-- Table: flw_transport_plombe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_plombe
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRANSPORT_PLOMBE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   tour_id                             INTEGER     NOT NULL COMMENT 'LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM',
   plombe_id                           NUMBER(29,0)     NOT NULL COMMENT 'Plombennummer aus Feld PLO_NR',
   dat_plombe_aenderung                DATE             NOT NULL COMMENT 'Zeitstempel Änderung Plombennummer aus Feld CREADAT',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRANSPORT_PLOMBE PRIMARY KEY (mandant_id, tour_id, plombe_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung von Plomben zum LKW - SAP FLW (P21) - ZFW_TR_PLO';

