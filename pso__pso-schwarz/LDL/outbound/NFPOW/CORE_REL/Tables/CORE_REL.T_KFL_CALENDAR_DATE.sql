/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_calendar_date
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_calendar_date (
cal_dt DATE NOT NULL
OPTIONS(description='identifier of the calendar date            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT'),
cal_month BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar month            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJMO'),
cal_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJWO'),
kfl_cal_year_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar year related calendar week in the Kaufland DWH, if a calendar week starts in a certain calendar year and ends in the next calendar year then the calendar week is split into 2 calendar year related Kaufland calendar weeks            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJWO_KL'),
kfl_bus_year_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the calendar year related Kaufland business year week in the Kaufland DWH, if a business year week starts in a certain calendar year and ends in the next calendar year then the business year week is split into 2 calendar year related Kaufland business year weeks            KFL: KFL_PRODUCTION.DBP_DATA.TAG.GJWO_KL'),
kfl_prod_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland production week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.PJWO'),
day_of_week BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the calendar week            KFL: KFL_PRODUCTION.DBP_DATA.TAG.WTAG_ID'),
day_of_cal_year BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the calendar year            KFL: KFL_PRODUCTION.DBP_DATA.TAG.KJTAG_ID'),
day_of_bus_year BIGNUMERIC(38,0)
OPTIONS(description='The sequence number of the day within the Kaufland business year            KFL: KFL_PRODUCTION.DBP_DATA.TAG.GJTAG_ID'),
kfl_prev_1y_cal_dt DATE
OPTIONS(description='identifier of the related calendar date in the previous year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT_VJ'),
kfl_prev_2y_cal_dt DATE
OPTIONS(description='identifier of the related calendar date in the year before last year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.TAG.DAT_VVJ'),
kfl_cal_dt_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the current calendar date. If the calendar date is the current calendar date, then the offset is 0, if the calendar date is the day after the calendar date then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_TAG'),
kfl_bus_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the current Kaufland business half year. If the calendar date is in the current Kaufland business half year, then the offset is 0, if the calendar date is in the Kaufland business half year after the current Kaufland business half year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_GJHJ'),
kfl_completed_bus_half_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the latest completed Kaufland business half year. If the calendar date is in the latest completed Kaufland business half year, then the offset is 0, if the calendar dateis in the Kaufland business half year after the latest completed Kaufland business half year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.TAG.AKT_GJHJ_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt) NOT ENFORCED
) OPTIONS(description='Kaufland calendar date             KFL: KFL_PRODUCTION.DBP_DATA.TAG');