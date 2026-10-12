/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_calendar_year_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_calendar_year_1 (
cal_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar_1 year            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.KJ            CORE_REL: t_kfl_calendar_year.cal_year'),
kfl_cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 year in relation to the current calendar_1 year. If the calendar_1 year is the current calendar_1 year, then the offset is 0, if the calendar_1 year is one year after the current calendar_1 year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.AKT_KJ            CORE_REL: t_kfl_calendar_year.kfl_cal_year_offset'),
kfl_completed_cal_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 year in relation to the latest completed calendar_1 year. If the calendar_1 year is the latest completed calendar_1 year, then the offset is 0, if the calendar_1 year is one year after the latest completed calendar_1 year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ.AKT_KJ_KOMPLETT            CORE_REL: t_kfl_calendar_year.kfl_completed_cal_year_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_year) NOT ENFORCED
)
OPTIONS(description='Kaufland calender year             KFL: KFL_PRODUCTION.DBP_DATA.JAHR_KJ_1             CORE_REL: T_KFL_CALENDAR_YEAR_1');