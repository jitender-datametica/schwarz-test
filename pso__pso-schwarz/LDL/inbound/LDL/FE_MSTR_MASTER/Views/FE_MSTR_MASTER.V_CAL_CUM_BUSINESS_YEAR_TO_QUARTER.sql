CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_CAL_CUM_BUSINESS_YEAR_TO_QUARTER (
bus_year_qtr COMMENT 'The business year quarter for which the business-year-to-quarter interval is defined.'
,incl_bus_year_qtr COMMENT 'The business year quarter that needs to be included in the business-year-to-quarter interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a business year quarter to all business year quarters that form the business-year-to-quarter interval of this quarter. E.g. for Q3/2021 this is Q1/2021, Q2/2021 and Q3/2021.' AS SELECT
main.bus_year_qtr AS bus_year_qtr
,main.incl_bus_year_qtr AS incl_bus_year_qtr
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_QUARTER main;