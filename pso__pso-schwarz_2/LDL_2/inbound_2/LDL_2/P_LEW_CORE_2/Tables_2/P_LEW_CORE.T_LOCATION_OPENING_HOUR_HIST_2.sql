CREATE TABLE P_LEW_CORE.T_LOCATION_OPENING_HOUR_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Unique identifier of the DWH client / slice.',
   store_loc_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION_2 (eindeutig ueber alle Laender / Mandanten hinweg).',
   cal_dt                              DATE             NOT NULL COMMENT 'WAWI: x_data.t_cal_calendarday.dat_calendar',
   opening_tm                          TIME(0)          COMMENT 'The time when the stores opens. E.g. 08:00; Time is in local time.',
   closing_tm                          TIME(0)          COMMENT 'The time when the stores closes. E.g. 20:00; Time is in local time. In case the store is closed during lunch time, this is the final closing time in the evening.',
   break_start_tm                      TIME(0)          COMMENT 'In case the store is closed for lunch break / siesta - this is the begin time of the break.',
   break_end_tm                        TIME(0)          COMMENT 'In case the store is closed for lunch break / siesta - this is the end time of the break.',
   store_open_fg                       NUMBER(38,0)     COMMENT 'Indicator that store was open on this date',
   store_operating_type_cd             VARCHAR(100)     COMMENT 'A code for an operating types for a store  ( regular opening , public holiday , permanent closure)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_LOCATION_OPENING_HOUR_HIST PRIMARY KEY (store_loc_sid, cal_dt) NOT ENFORCED 
)  COMMENT = 'Contains history of opening hours for the shop';
