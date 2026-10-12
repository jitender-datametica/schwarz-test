--==============================================================
-- Table: flw_route_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_route_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ROUTE_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk aus Feld WERK',
   route_id                            VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'Route aus Feld ROUTE',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   route_bez                           VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Route aus Feld BEZ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ROUTE_SPR_ZU PRIMARY KEY (mandant_id, werk_id, route_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Route - SAP FLW (P21) - ZFW_ROUTET';

