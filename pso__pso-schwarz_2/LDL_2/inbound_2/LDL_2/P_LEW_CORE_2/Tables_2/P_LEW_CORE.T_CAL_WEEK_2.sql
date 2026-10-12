/* --------------------------------------------------------------------------------
   DDL for table: t_cal_week_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAL_WEEK_2 (
   cy_week                             NUMBER(38,0)     NOT NULL COMMENT 'YYYYKW; WAWI: x_data.t_cal_week.cy_week',
   cy_week_prev_1w                     NUMBER(38,0)     NOT NULL COMMENT 'WAWI: x_data.t_cal_week.prev_week',
   cy_week_prev_1y                     NUMBER(38,0)     COMMENT 'WAWI: x_data.t_cal_week.prev_cy_week',
   cy_week_prev_2y                     NUMBER(38,0)     COMMENT 'WAWI: x_data.t_cal_week.preprev_cy_week',
   cy_week_seq                         NUMBER(38,0)     NOT NULL COMMENT '(taglich berechnet); WAWI: x_data.t_cal_week.cy_week_sequence',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CAL_WEEK PRIMARY KEY (cy_week) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CWEE: Wochen;
             WAWI: x_data.t_cal_week_2';

