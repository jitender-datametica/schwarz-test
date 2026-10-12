/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_calendar_date
   generated from Powerdesigner on Dienstag, 12. Dezember 2023 14:02:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_CALENDAR_DATE DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_dt                              DATE             NOT NULL COMMENT 'Calendar day.',
   cal_week                            NUMBER(38,0)     NOT NULL COMMENT 'Calendar week.',
   nfpo_cal_week_name                  VARCHAR(100)     NOT NULL COMMENT 'Name of the calendar week',
   cal_week_begin_dt                   DATE             NOT NULL COMMENT 'Datum des Montags der Kalenderwoche',
   cal_month                           NUMBER(38,0)     NOT NULL,
   cal_year                            NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahr',
   bus_year                            NUMBER(38,0)     NOT NULL,
   day_of_week                         NUMBER(38,0)     NOT NULL,
   day_of_month                        NUMBER(38,0)     NOT NULL,
   day_of_cal_year                     NUMBER(38,0)     NOT NULL,
   ldl_cal_dt_offset                   NUMBER(38,0),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_CALENDAR_DATE PRIMARY KEY (cal_dt) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';