--==============================================================
-- Table: flw_l_route
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_route
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_ROUTE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk aus Feld WERK',
   route_id                            VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'Route aus Feld ROUTE',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_ROUTE PRIMARY KEY (mandant_id, werk_id, route_id) NOT ENFORCED
)  COMMENT = 'FLW - Ergänzende Informationen zur Route - SAP FLW (P21) - ZFW_ROUTE';

