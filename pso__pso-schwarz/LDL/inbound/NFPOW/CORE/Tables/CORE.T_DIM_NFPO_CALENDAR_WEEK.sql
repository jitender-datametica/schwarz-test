/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_calendar_week
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:42:25
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_CALENDAR_WEEK DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_week                            NUMBER(38,0)     NOT NULL,
   nfpo_cal_week_name                  VARCHAR(100)     NOT NULL,
   cal_week_begin_dt                   DATE             NOT NULL,
   cal_year                            NUMBER(38,0)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_CALENDAR_WEEK PRIMARY KEY (cal_week) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';
