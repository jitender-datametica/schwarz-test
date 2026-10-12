create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_CAL_CUM_MONTH_TO_PARTIAL_WEEK(
	PART_WEEK COMMENT 'The partial week for which the month-to-partial-year interval is defined',
	INCL_PART_WEEK COMMENT 'The partial that needs to be included in the month-to-partial-week interval.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This table relates a partial week to all partial weeks that form its month-to-partial-week interval.'
 as SELECT
main.part_week AS part_week
,main.incl_part_week AS incl_part_week
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_MONTH_TO_PARTIAL_WEEK main;