--==============================================================
-- Table: flw_mes_ist_summenge_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_ist_summenge_1
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:21:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_IST_SUMMENGE_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_werk_id                         INTEGER    NOT NULL COMMENT 'plant where the meat is processed',
   flw_arbeitsplatz_id                 VARCHAR(8)      NOT NULL COMMENT 'identifier of the working place in production line',
   schicht_id                          VARCHAR(32)     NOT NULL COMMENT 'identifier of the shift in the production line',
   mes_prodmengetyp_id                 INTEGER    NOT NULL COMMENT 'type of the step of processing meat',
   dat_prod                            DATE            NOT NULL COMMENT 'date of production',
   ist_menge                           INTEGER    COMMENT 'Number of  goods produced',
   ist_einh                           VARCHAR(2)      COMMENT 'measurement unit_1 for produced goods (ex ST = Stück)',
   datzeit_aenderung                   TIMESTAMP_NTZ   COMMENT 'Records update time in plant''s timezone ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_IST_SUMMENGE PRIMARY KEY (mandant_id, flw_werk_id, flw_arbeitsplatz_id, schicht_id, mes_prodmengetyp_id, dat_prod) NOT ENFORCED
)  COMMENT = 'table describes the production process within a shift on a location_1 ( working place in procuction line)';
