/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_day_advertise_week
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_client_day_advertise_week (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.MANDANT_ID'),
cal_dt DATE NOT NULL
OPTIONS(description='identifier of the calendar date            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT'),
kfl_adv_week BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW'),
kfl_adv_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the current  Kaufland advertising week. If the calendar date is in the current  Kaufland advertising week, then the offset is 0, if the calendar date is in the  Kaufland advertising week after the current  Kaufland advertising week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW'),
kfl_completed_adv_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar date in relation to the latest completed  Kaufland advertising week. If the calendar date is in the latest completed  Kaufland advertising week, then the offset is 0, if the calendar date is in the  Kaufland advertising week after the latest completed  Kaufland advertising week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (cal_dt, kfl_client_id) NOT ENFORCED
)
OPTIONS(description='Kaufland assignment of advertising week to calendar date per Kaufland.             KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL');