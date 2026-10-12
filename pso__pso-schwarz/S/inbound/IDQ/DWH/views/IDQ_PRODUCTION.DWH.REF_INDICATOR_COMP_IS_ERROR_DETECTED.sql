create or replace view IDQ_PRODUCTION.DWH.REF_INDICATOR_COMP_IS_ERROR_DETECTED(
	IS_ERROR_DETECTED,
	DESCRIPTION,
	DESCRIPTION_DE,
	DESCRIPTION_EN
) as
  SELECT
       ID                                 as IS_ERROR_DETECTED        --new column - tbd discussed
      ,DESC_DE                            as DESCRIPTION                --qualified column name needed?
      ,DESC_DE                            as DESCRIPTION_DE            --qualified column name needed?
      ,DESC_EN                            as DESCRIPTION_EN            --qualified column name needed?
  FROM idq_results.REF_INDICATOR
;