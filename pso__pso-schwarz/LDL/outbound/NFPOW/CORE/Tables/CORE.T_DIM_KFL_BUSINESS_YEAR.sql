/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_business_year
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_business_year (
kfl_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.GJ            CORE_REL: t_kfl_business_year.kfl_bus_year'),
kfl_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year in the Kaufland DWH in relation to the current Kaufland business year. If the Kaufland business year is the current Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the current Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ            CORE_REL: t_kfl_business_year.kfl_bus_year_offset'),
kfl_completed_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year in the Kaufland DWH in relation to the latest completed Kaufland business year. If the Kaufland business year is the latest completed Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the latest completed Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ_KOMPLETT            CORE_REL: t_kfl_business_year.kfl_completed_bus_year_offset'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_bus_year) NOT ENFORCED
)
OPTIONS(description='Kaufland business year             KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ             CORE_REL: T_KFL_BUSINESS_YEAR');