--==============================================================
-- Table: flw_mes_schicht
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_schicht
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:22:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_SCHICHT (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   schicht_id                          VARCHAR(32)     NOT NULL COMMENT 'identifier of the shift in the production line',
   schichttyp_id                       VARCHAR(2)      NOT NULL COMMENT 'identifier of the shift type in the production line',
   datzeit_schicht_anfang              TIMESTAMP_LTZ   NOT NULL COMMENT 'timestamp when shift starts',
   datzeit_schicht_ende                TIMESTAMP_LTZ   NOT NULL COMMENT 'timestamp when the shift ends',
   zeit_schicht_beginn                 TIME(0)         NOT NULL COMMENT 'time of the day when the shift starts',
   zeit_schicht_ende                   TIME(0)         NOT NULL COMMENT 'time of the day when the shift ends',
   flw_werk_id                         INTEGER    NOT NULL COMMENT 'plant where the meat is processed',
   flw_arbeitsplatz_id                 VARCHAR(8)      COMMENT 'identifier of the working place in production line',
   dat_schicht                         DATE            COMMENT 'date of shift',
   schicht_dauer                       NUMBER(29,5)    COMMENT 'shift duration',
   schicht_dauer_einh                  VARCHAR(1)      COMMENT 'measument unit of shift duration ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_SCHICHT PRIMARY KEY (mandant_id, schicht_id, schichttyp_id, datzeit_schicht_anfang, datzeit_schicht_ende) NOT ENFORCED
)  COMMENT = 'table contains the shifts in production line for employees';
