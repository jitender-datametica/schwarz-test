create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_BUSINESS_YEAR_TO_HALF_YEAR(
	BUS_HALF_YEAR COMMENT 'The business half year for which the business-year-to-half-year interval is defined.',
	INCL_BUS_HALF_YEAR COMMENT 'The business half year that needs to be included in the business-year-to-half-year interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a business half year to all business half years that form the business-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.'
 as SELECT
main.bus_half_year AS bus_half_year
,main.incl_bus_half_year AS incl_bus_half_year
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_HALF_YEAR main;