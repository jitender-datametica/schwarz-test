create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_BUSINESS_HALF_YEAR_TO_QUARTER_1(
	BUS_YEAR_QTR COMMENT 'The business year quarter for which the business-half-year-to-quarter interval is defined.',
	INCL_BUS_YEAR_QTR COMMENT 'The business year quarter that needs to be included in the business-half-year-to-quarter interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a business year quarter to all business year quarters that form the business-half-year-to-quarter interval of this quarter. E.g. for Q2/2021 this is Q1/2021 and Q2/2021.'
 as SELECT
main.bus_year_qtr AS bus_year_qtr
,main.incl_bus_year_qtr AS incl_bus_year_qtr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_BUSINESS_HALF_YEAR_TO_QUARTER_1 main;