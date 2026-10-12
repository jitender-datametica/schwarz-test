/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_calendar_date
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_calendar_date (
cal_dt DATE NOT NULL
OPTIONS(description='identifier of the calendar date            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT            CORE_REL: t_kfl_calendar_date.cal_dt'),
cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJWO            CORE_REL: t_kfl_calendar_date.cal_week'),
cal_week_begin_dt DATE
OPTIONS(description='date of the first day (Monday) of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_VON            CORE_REL: t_kfl_calendar_week.cal_week_begin_dt'),
cal_week_end_dt DATE
OPTIONS(description='date of the last day (Sunday) of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.woche.WO_DAT_BIS            CORE_REL: t_kfl_calendar_week.cal_week_end_dt'),
kfl_prev_1y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related calendar week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VJ            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_cal_week'),
kfl_prev_2y_cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.KJWO_VVJ            CORE_REL: t_kfl_calendar_week.kfl_prev_2y_cal_week'),
kfl_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland business year week in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO            CORE_REL: t_kfl_calendar_week.kfl_bus_week'),
kfl_prev_1y_bus_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the related Kaufland business week in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.woche.GJWO_VJ            CORE_REL: t_kfl_calendar_week.kfl_prev_1y_bus_week'),
kfl_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar week in relation to the current calendar week. If the calendar week is the current calendar week, then the offset is 0, if the calendar week is one week after the current calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO            CORE_REL: t_kfl_calendar_week.kfl_cal_week_offset'),
kfl_completed_cal_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar week in relation to the latest completed calendar week. If the calendar week is the latest completed calendar week, then the offset is 0, if the calendar week is one week after the latest completed calendar week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche.AKT_WO_KOMPLETT            CORE_REL: t_kfl_calendar_week.kfl_completed_cal_week_offset'),
cal_month BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar month            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJMO            CORE_REL: t_kfl_calendar_date.cal_month'),
month_of_cal_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the month within the calendar year            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MO_KJ            CORE_REL: t_kfl_calendar_month.month_of_cal_year'),
prev_1y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related calendar month in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJMO_VJ            CORE_REL: t_kfl_calendar_month.prev_1y_cal_month'),
prev_2y_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related calendar month in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJMO_VVJ            CORE_REL: t_kfl_calendar_month.prev_2y_cal_month'),
kfl_cal_month_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar month. If the calendar month is the current calendar month, then the offset is 0, if the calendar month is one month after the current calendar month, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_MO            CORE_REL: t_kfl_calendar_month.kfl_cal_month_offset'),
kfl_completed_cal_month_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar month. If the calendar month is the latest completed calendar month, then the offset is 0, if the calendar month is one month after the latest completed calendar month, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_MO_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_month_offset'),
cal_year BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJ            CORE_REL: t_kfl_calendar_month.cal_year'),
kfl_cal_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar year. If the calendar month is in the current calendar year, then the offset is 0, if the calendar month is in the calendar year after the current calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJ            CORE_REL: t_kfl_calendar_month.kfl_cal_year_offset'),
kfl_completed_cal_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar year. If the calendar month is in the latest completed calendar year, then the offset is 0, if the calendar month is in the calendar year after the latest completed calendar year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJ_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_year_offset'),
kfl_bus_year BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJ            CORE_REL: t_kfl_calendar_month.kfl_bus_year'),
kfl_bus_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current Kaufland business year. If the calendar month is in the current Kaufland business year, then the offset is 0, if the calendar month is in the Kaufland business year after the current Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJ            CORE_REL: t_kfl_calendar_month.kfl_bus_year_offset'),
kfl_completed_bus_year_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed Kaufland business year. If the calendar month is in the latest completed Kaufland business year, then the offset is 0, if the calendar month is in the Kaufland business year after the latest completed Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJ_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_bus_year_offset'),
kfl_cal_year_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar year related calendar week in the Kaufland DWH, if a calendar week starts in a certain calendar year and ends in the next calendar year then the calendar week is split into 2 calendar year related Kaufland calendar weeks            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJWO_KL            CORE_REL: t_kfl_calendar_date.kfl_cal_year_week'),
kfl_bus_year_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar year related Kaufland business year week in the Kaufland DWH, if a business year week starts in a certain calendar year and ends in the next calendar year then the business year week is split into 2 calendar year related Kaufland business year weeks            KFL: KFL_PRODUCTION.DBP_DATA.TAG.GJWO_KL            CORE_REL: t_kfl_calendar_date.kfl_bus_year_week'),
kfl_prod_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland production week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.PJWO            CORE_REL: t_kfl_calendar_date.kfl_prod_week'),
day_of_week BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.WTAG_ID            CORE_REL: t_kfl_calendar_date.day_of_week'),
day_of_cal_year BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the calendar year            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJTAG_ID            CORE_REL: t_kfl_calendar_date.day_of_cal_year'),
day_of_bus_year BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the Kaufland business year            KFL: KFL_PRODUCTION.DBP_DATA.TAG.GJTAG_ID            CORE_REL: t_kfl_calendar_date.day_of_bus_year'),
kfl_prev_1y_cal_dt DATE
OPTIONS(description='identifier of the related calendar date in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT_VJ            CORE_REL: t_kfl_calendar_date.kfl_prev_1y_cal_dt'),
kfl_prev_2y_cal_dt DATE
OPTIONS(description='identifier of the related calendar date in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT_VVJ            CORE_REL: t_kfl_calendar_date.kfl_prev_2y_cal_dt'),
kfl_cal_dt_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the current calendar date. If the calendar date is the current calendar date, then the offset is 0, if the calendar date is the day after the calendar date then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_TAG            CORE_REL: t_kfl_calendar_date.kfl_cal_dt_offset'),
kfl_bus_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related business year month            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJMO            CORE_REL: t_kfl_calendar_month.kfl_bus_month'),
kfl_month_of_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The sequence number of the month within the Kaufland business year            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.MO_GJ            CORE_REL: t_kfl_calendar_month.kfl_month_of_bus_year'),
kfl_prev_1y_bus_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the related business year month in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJMO_VJ            CORE_REL: t_kfl_calendar_month.kfl_prev_1y_bus_month'),
cal_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the calendar year quarter            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.KJQU            CORE_REL: t_kfl_calendar_month.cal_year_qtr'),
kfl_cal_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current calendar year quarter. If the calendar month is in the current calendar year quarter, then the offset is 0, if the calendar month is in the calendar year quarter after the current calendar year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJQU            CORE_REL: t_kfl_calendar_month.kfl_cal_year_qtr_offset'),
kfl_completed_cal_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed calendar year quarter. If the calendar month is in the latest completed calendar year quarter, then the offset is 0, if the calendar month is in the calendar year quarter after the latest completed calendar year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_KJQU_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_cal_year_qtr_offset'),
kfl_bus_year_qtr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year quarter in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJQU            CORE_REL: t_kfl_calendar_month.kfl_bus_year_qtr'),
kfl_bus_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the current Kaufland business year quarter. If the calendar month is in the current Kaufland business year quarter, then the offset is 0, if the calendar month is in the Kaufland business year quarter after the current Kaufland business year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJQU            CORE_REL: t_kfl_calendar_month.kfl_bus_year_qtr_offset'),
kfl_completed_bus_year_qtr_offset BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='offset of the calendar month in relation to the latest completed Kaufland business year quarter. If the calendar month is in the latest completed Kaufland business year quarter, then the offset is 0, if the calendar month is in the Kaufland business year quarter after the latest completed Kaufland business year quarter, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.AKT_GJQU_KOMPLETT            CORE_REL: t_kfl_calendar_month.kfl_completed_bus_year_qtr_offset'),
kfl_bus_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business half year the calendar month is in            KFL: KFL_PRODUCTION.DBP_DATA.MONAT.GJHJ            CORE_REL: t_kfl_calendar_month.kfl_bus_half_year'),
kfl_bus_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the current Kaufland business half year. If the calendar date is in the current Kaufland business half year, then the offset is 0, if the calendar date is in the Kaufland business half year after the current Kaufland business half year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_GJHJ            CORE_REL: t_kfl_calendar_date.kfl_bus_half_year_offset'),
kfl_completed_bus_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the latest completed Kaufland business half year. If the calendar date is in the latest completed Kaufland business half year, then the offset is 0, if the calendar dateis in the Kaufland business half year after the latest completed Kaufland business half year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_GJHJ_KOMPLETT            CORE_REL: t_kfl_calendar_date.kfl_completed_bus_half_year_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
)
OPTIONS(description='Kaufland calendar date             KFL: KFL_PRODUCTION.DBP_DATA.TAG             CORE_REL: T_KFL_CALENDAR_DATE');