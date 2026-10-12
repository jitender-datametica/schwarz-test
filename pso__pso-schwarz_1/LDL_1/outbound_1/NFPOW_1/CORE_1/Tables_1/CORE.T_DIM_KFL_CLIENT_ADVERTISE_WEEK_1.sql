/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_client_advertise_week_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_client_advertise_week_1 (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant_1) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.MANDANT_ID            CORE_REL: t_kfl_client_day_advertise_week.kfl_client_id'),
kfl_adv_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland advertising week            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.KJWO_WW            CORE_REL: t_kfl_client_day_advertise_week.kfl_adv_week'),
kfl_adv_week_begin_dt DATE
OPTIONS(description='identifier of the calendar_1 date            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT            CORE_REL: t_kfl_client_day_advertise_week.min(cal_dt) by kfl_client_id, kfl_adv_week'),
kfl_adv_week_end_dt DATE
OPTIONS(description='identifier of the calendar_1 date            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.DAT            CORE_REL: t_kfl_client_day_advertise_week.max(cal_dt) by kfl_client_id, kfl_adv_week'),
kfl_adv_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 date in relation to the current  Kaufland advertising week. If the calendar_1 date is in the current  Kaufland advertising week, then the offset is 0, if the calendar_1 date is in the  Kaufland advertising week after the current  Kaufland advertising week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW            CORE_REL: t_kfl_client_day_advertise_week.kfl_adv_week_offset'),
kfl_completed_adv_week_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the calendar_1 date in relation to the latest completed  Kaufland advertising week. If the calendar_1 date is in the latest completed  Kaufland advertising week, then the offset is 0, if the calendar_1 date is in the  Kaufland advertising week after the latest completed  Kaufland advertising week, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.WERBEWOCHE_KL.AKT_KJWO_WW_KOMPLETT            CORE_REL: t_kfl_client_day_advertise_week.kfl_completed_adv_week_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_adv_week) NOT ENFORCED
) OPTIONS(description='Kaufland Werbewochen je Mandant_1');