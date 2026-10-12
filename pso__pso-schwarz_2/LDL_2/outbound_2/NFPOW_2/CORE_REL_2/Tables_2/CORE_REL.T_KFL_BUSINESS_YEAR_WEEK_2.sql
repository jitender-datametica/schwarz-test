/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_business_year_week_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_business_year_week_2 (
kfl_bus_year_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year related Kaufland business year week in the Kaufland DWH, if a business year week starts in a certain Kaufland business year and ends in the next Kaufland business year then the business year week is split into 2 Kaufland business year related Kaufland business year weeks            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL'),
kfl_bus_year_week_begin_dt DATE
OPTIONS(description='date of the first day of the Kaufland business year related Kaufland business year week            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL_DAT_VON'),
kfl_bus_year_week_end_dt DATE
OPTIONS(description='date of the last day of the Kaufland business year related Kaufland business year week            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.GJWO_KL_DAT_BIS'),
kfl_bus_year_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year related Kaufland business year week in relation to the current Kaufland business year related Kaufland business year week. If the Kaufland business year related Kaufland business year week is the Kaufland business year related Kaufland business year week, then the offset is 0, if the Kaufland business year related Kaufland business year week is one week after the current Kaufland business year related Kaufland business year week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJWO_KL'),
kfl_completed_bus_year_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year related Kaufland business year week in relation to the latest completed Kaufland business year related Kaufland business year week. If the Kaufland business year related Kaufland business year week is the latest completed Kaufland business year related Kaufland business year week, then the offset is 0, if the Kaufland business year related Kaufland business year week is one week after the latest Kaufland business year related Kaufland business year week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJWO_KL_KOMPLETT'),
kfl_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year related Kaufland business year week in relation to the current business year. If the Kaufland business year related Kaufland business year week is in the current business year, then the offset is 0, if the Kaufland business year related Kaufland business year week is in the year after the current business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJ'),
kfl_completed_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year related Kaufland business year week in relation to the latest completed business year. If the Kaufland business year related Kaufland business year week is in the latest completed business year, then the offset is 0, if the Kaufland business year related Kaufland business year week is in the year after the latest completed business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.woche_gj_kl.AKT_GJ_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_bus_year_week) NOT ENFORCED
)
OPTIONS(description='Kaufland business year related calendar_2 weeks, normal calendar_2 weeks are splitted into two partial weeks if begin and end are in two consecutive business years.             KFL: KFL_PRODUCTION.DBP_DATA.WOCHE_GJ_KL_2');