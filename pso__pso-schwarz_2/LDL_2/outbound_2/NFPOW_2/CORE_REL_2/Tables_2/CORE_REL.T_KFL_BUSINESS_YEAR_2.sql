/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_business_year_2
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_business_year_2 (
kfl_bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Kaufland business year in the Kaufland DWH            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.GJ'),
kfl_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year in the Kaufland DWH in relation to the current Kaufland business year. If the Kaufland business year is the current Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the current Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ'),
kfl_completed_bus_year_offset BIGNUMERIC(38,0)
OPTIONS(description='offset of the Kaufland business year in the Kaufland DWH in relation to the latest completed Kaufland business year. If the Kaufland business year is the latest completed Kaufland business year, then the offset is 0, if the Kaufland business year is one year after the latest completed Kaufland business year, then the offset is 1            KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ.AKT_GJ_KOMPLETT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_bus_year) NOT ENFORCED
) OPTIONS(description='Kaufland business year             KFL: KFL_PRODUCTION.DBP_DATA.JAHR_GJ_2');