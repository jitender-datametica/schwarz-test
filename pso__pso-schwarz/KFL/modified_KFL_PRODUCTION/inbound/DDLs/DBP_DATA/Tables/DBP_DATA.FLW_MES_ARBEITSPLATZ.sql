--==============================================================
-- Table: flw_mes_arbeitsplatz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:22:05
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_ARBEITSPLATZ (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   flw_arbeitsplatz_id                 VARCHAR(8)      NOT NULL COMMENT 'identifier of the working place in production line',
   flw_arbeitsplatztyp_id              VARCHAR(10)     NOT NULL COMMENT 'identifier of the type of the working place in production line',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_ARBEITSPLATZ PRIMARY KEY (mandant_id, flw_arbeitsplatz_id) NOT ENFORCED
)  COMMENT = 'Table contains data for workingplace in production line';
