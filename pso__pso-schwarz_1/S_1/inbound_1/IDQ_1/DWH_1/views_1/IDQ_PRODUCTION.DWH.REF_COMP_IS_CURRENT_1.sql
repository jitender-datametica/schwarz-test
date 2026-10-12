create or replace view IDQ_PRODUCTION.DWH.REF_COMP_IS_CURRENT_1(
	REF_COMP_IS_CURRENT_ID,
	DESCRIPTION,
	DESCRIPTION_DE,
	DESCRIPTION_EN
) as
  SELECT
       --REMOVED ID									as SYS_COMP_IS_CURRENT_ID,
	   ID									as REF_COMP_IS_CURRENT_ID		--new column - tbd discussed
      ,DESC_DE							as DESCRIPTION				--qualified column name needed?
	  ,DESC_DE							as DESCRIPTION_DE			--qualified column name needed?
      ,DESC_EN							as DESCRIPTION_EN			--qualified column name needed?
  FROM idq_results.REF_INDICATOR_1
;