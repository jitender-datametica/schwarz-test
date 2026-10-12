create or replace view IDQ_PRODUCTION.DWH.REF_COMP_FIELD_DEFINITION_2(
	REF_COMP_FIELD_DEFINITION_ID,
	REF_COMP_DEFINITION_ID,
	LEADING_FIELD_ID,
	DEPENDENT_FIELD_ID,
	REF_CRITICALITY_ID,
	REF_FIELD_COMP_TYPE_ID,
	FUNCTIONAL_FIELD_NAME,
	FUNCTIONAL_FIELD_NAME_DE,
	FUNCTIONAL_FIELD_NAME_EN
) as

  SELECT 
       ID												AS REF_COMP_FIELD_DEFINITION_ID
      ,COMP_DEFINITION_ID								AS REF_COMP_DEFINITION_ID
      ,LEADING_FIELD_ID
      ,DEPENDENT_FIELD_ID
      --REMOVED, CRITICALITY_ID
	  ,CRITICALITY_ID									AS REF_CRITICALITY_ID --new column to stick naming conventions - tbd with KD
      ,FIELD_COMP_TYPE_ID	                            AS REF_FIELD_COMP_TYPE_ID
      ,FUNCTIONAL_FIELD_NAME							-- should these NAME-columns be renamed to a qualified name, too?
      ,FUNCTIONAL_FIELD_NAME_DE						-- should these NAME-columns be renamed to a qualified name, too?
      ,FUNCTIONAL_FIELD_NAME_EN						-- should these NAME-columns be renamed to a qualified name, too?
  FROM idq_results.REF_COMP_FIELD_DEFINITION_2
;