--==============================================================
-- Table: flw_l_vw
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_vw
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_VW (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   flw_vw_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_VW PRIMARY KEY (mandant_id, flw_vw_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup Tabelle der Vertriebswege aus tvtw_t';

