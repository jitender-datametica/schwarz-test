/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_advertise_period
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_advertise_period (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.MANDANT_ID            CORE_REL: t_kfl_advertise_period.kfl_client_id'),
kfl_adv_period_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the advertising period type in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.WERBE_TYP_ID            CORE_REL: t_kfl_advertise_period.kfl_adv_period_type_id'),
cal_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='calendar week            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.KJWO            CORE_REL: t_kfl_advertise_period.cal_week'),
kfl_adjust_adv_period_fg BOOL
OPTIONS(description='indicator whether the length of the advertising period is different to the standard length of this advertising period type            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.ABW_ZEITR_FG            CORE_REL: t_kfl_advertise_period.kfl_adjust_adv_period_fg'),
kfl_adv_period_begin_dt DATE
OPTIONS(description='first calendar date of the advertising period in the calendar week            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.DAT_VON            CORE_REL: t_kfl_advertise_period.kfl_adv_period_begin_dt'),
kfl_adv_period_end_dt DATE
OPTIONS(description='last calendar date of the advertising period started in the calendar week            KFL: KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE.DAT_BIS            CORE_REL: t_kfl_advertise_period.kfl_adv_period_end_dt'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id, kfl_adv_period_type_id, cal_week) NOT ENFORCED
)
OPTIONS(description='Kaufland advertise period             KFL_PRODUCTION.DBP_MSI_VIEW_VIS.MV_WERBE_WOCHE             CORE_REL: T_KFL_ADVERTISE_PERIOD');