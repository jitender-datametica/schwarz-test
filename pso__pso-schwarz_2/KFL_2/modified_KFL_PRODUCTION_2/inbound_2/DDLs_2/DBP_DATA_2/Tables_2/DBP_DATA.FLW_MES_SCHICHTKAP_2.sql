--==============================================================
-- Table: flw_mes_schichtkap_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_schichtkap_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:04:02
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_SCHICHTKAP_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   schicht_id                          VARCHAR(32)     NOT NULL COMMENT 'identifier of the shift in the production line',
   kapatyp_id                          VARCHAR(5)      NOT NULL COMMENT 'capacity of machine type; FLM Fleischwarenmaschine [only this one is used]',
   schichttyp_id                       VARCHAR(2)      NOT NULL COMMENT 'identifier of the shift type in the production line',
   ngrad_angabe                        INTEGER     NOT NULL COMMENT 'capacity in percentage (0-100)',
   kapa_dauer                          NUMBER(29,5)    COMMENT 'duration of capacity  measurement',
   kapa_einh                           VARCHAR(1)      COMMENT 'capacity duration type for example in seconds: S',
   mengen_anz                          INTEGER    COMMENT 'number/quantity producd for duration',
   dat_schicht                         DATE            COMMENT 'date of shift',
   pause_dauer_sec                     NUMBER(29,5)    COMMENT 'break/pause duration in seconds',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_SCHICHTKAP PRIMARY KEY (mandant_id, schicht_id, kapatyp_id, schichttyp_id) NOT ENFORCED
)  COMMENT = 'table cotains data for the availabilty of the capacity of a specific machine type (in meat processing)';
