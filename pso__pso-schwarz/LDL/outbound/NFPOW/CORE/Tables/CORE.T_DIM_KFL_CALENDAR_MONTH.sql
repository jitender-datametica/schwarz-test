/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_calendar_month
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_calendar_month (
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar month            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJMO            CORE_REL: t_kfl_calendar_month.cal_month'),
cal_month_begin_dt DATE NOT NULL
OPTIONS(description='date of the first day of the calendar month            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MIN_DAT            CORE_REL: t_kfl_calendar_month.cal_month_begin_dt'),
cal_month_end_dt DATE NOT NULL
OPTIONS(description='date of the last day of the calendar month            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MAX_DAT            CORE_REL: t_kfl_calendar_month.cal_month_end_dt'),
kfl_bus_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related business year month            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJMO            CORE_REL: t_kfl_calendar_month.kfl_bus_month'),
cal_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar year quarter            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJQU            CORE_REL: t_kfl_calendar_month.cal_year_qtr'),
kfl_bus_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year quarter in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJQU            CORE_REL: t_kfl_calendar_month.kfl_bus_year_qtr'),
kfl_bus_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business half year the calendar month is in            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJHJ            CORE_REL: t_kfl_calendar_month.kfl_bus_half_year'),
cal_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJ            CORE_REL: t_kfl_calendar_month.cal_year'),
kfl_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJ            CORE_REL: t_kfl_calendar_month.kfl_bus_year'),
month_of_cal_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the month within the calendar year            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MO_KJ            CORE_REL: t_kfl_calendar_month.month_of_cal_year'),
kfl_month_of_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the month within the Kaufland business year            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MO_GJ            CORE_REL: t_kfl_calendar_month.kfl_month_of_bus_year'),
prev_1y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related calendar month in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJMO_VJ            CORE_REL: t_kfl_calendar_month.prev_1y_cal_month'),
prev_2y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related calendar month in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJMO_VVJ            CORE_REL: t_kfl_calendar_month.prev_2y_cal_month'),
kfl_prev_1y_bus_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related business year month in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJMO_VJ            CORE_REL: t_kfl_calendar_month.kfl_prev_1y_bus_month'),
kfl_cal_month_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar month. If the calendar month is the current calendar month, then the offset is 0, if the calendar month is one month after the current calendar month, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_MO            CORE_REL: t_kfl_calendar_month.kfl_cal_month_offset'),
kfl_completed_cal_month_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar month. If the calendar month is the latest completed calendar month, then the offset is 0, if the calendar month is one month after the latest completed calendar month, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_MO_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_month_offset'),
kfl_cal_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar year quarter. If the calendar month is in the current calendar year quarter, then the offset is 0, if the calendar month is in the calendar year quarter after the current calendar year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJQU            CORE_REL: t_kfl_calendar_month.kfl_cal_year_qtr_offset'),
kfl_completed_cal_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar year quarter. If the calendar month is in the latest completed calendar year quarter, then the offset is 0, if the calendar month is in the calendar year quarter after the latest completed calendar year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJQU_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_year_qtr_offset'),
kfl_bus_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current Kaufland business year quarter. If the calendar month is in the current Kaufland business year quarter, then the offset is 0, if the calendar month is in the Kaufland business year quarter after the current Kaufland business year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJQU            CORE_REL: t_kfl_calendar_month.kfl_bus_year_qtr_offset'),
kfl_completed_bus_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed Kaufland business year quarter. If the calendar month is in the latest completed Kaufland business year quarter, then the offset is 0, if the calendar month is in the Kaufland business year quarter after the latest completed Kaufland business year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJQU_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_bus_year_qtr_offset'),
kfl_cal_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar year. If the calendar month is in the current calendar year, then the offset is 0, if the calendar month is in the calendar year after the current calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJ            CORE_REL: t_kfl_calendar_month.kfl_cal_year_offset'),
kfl_completed_cal_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar year. If the calendar month is in the latest completed calendar year, then the offset is 0, if the calendar month is in the calendar year after the latest completed calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJ_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_year_offset'),
kfl_bus_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current Kaufland business year. If the calendar month is in the current Kaufland business year, then the offset is 0, if the calendar month is in the Kaufland business year after the current Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJ            CORE_REL: t_kfl_calendar_month.kfl_bus_year_offset'),
kfl_completed_bus_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed Kaufland business year. If the calendar month is in the latest completed Kaufland business year, then the offset is 0, if the calendar month is in the Kaufland business year after the latest completed Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJ_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_bus_year_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_month) NOT ENFORCED
)
OPTIONS(description='Kaufland calendar month             KFL: KFL_PRODUCTION.DBP_DATA.MONAT             CORE_REL: T_KFL_CALENDAR_MONTH');