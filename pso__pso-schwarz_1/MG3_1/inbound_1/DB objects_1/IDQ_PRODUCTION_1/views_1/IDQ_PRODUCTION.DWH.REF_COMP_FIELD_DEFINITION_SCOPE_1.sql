create or replace view IDQ_PRODUCTION.DWH.REF_COMP_FIELD_DEFINITION_SCOPE_1(
	REF_COMP_FIELD_DEFINITION_SCOPE_ID,
	REF_COMP_DEFINITION_SCOPE_ID,
	REF_COMP_FIELD_DEFINITION_ID,
	REF_CRITICALITY_ID,
	REF_FIELD_COMP_TYPE_ID,
	REF_STATUS_ID,
	REF_COMP_DEFINITION_ID,
	LEADING_COMP_SCOPE_ID,
	DEPENDENT_COMP_SCOPE_ID,
	LEADING_FIELD_ID,
	DEPENDENT_FIELD_ID,
	LEADING_REF_SOURCE_SYSTEM_TYPE_ID,
	LEADING_REF_SOURCE_SYSTEM_ID,
	LEADING_REF_COUNTRY_ID,
	LEADING_REF_BRANCH_ID,
	LEADING_REF_TEST_OBJECT_TYPE_ID,
	DEPENDENT_REF_SOURCE_SYSTEM_TYPE_ID,
	DEPENDENT_REF_SOURCE_SYSTEM_ID,
	DEPENDENT_REF_COUNTRY_ID,
	DEPENDENT_REF_BRANCH_ID,
	DEPENDENT_REF_TEST_OBJECT_TYPE_ID
) as

  SELECT 
       CFDS.ID											AS REF_COMP_FIELD_DEFINITION_SCOPE_ID
      ,CFDS.COMP_DEFINITION_SCOPE_ID						AS REF_COMP_DEFINITION_SCOPE_ID
      ,CFDS.COMP_FIELD_DEFINITION_ID						AS REF_COMP_FIELD_DEFINITION_ID
      ,CFDS.CRITICALITY_ID								AS REF_CRITICALITY_ID
      ,CFDS.FIELD_COMP_TYPE_ID							AS REF_FIELD_COMP_TYPE_ID
      ,CFDS.STATUS_ID										AS REF_STATUS_ID

	  ,CDS.COMP_DEFINITION_ID								AS REF_COMP_DEFINITION_ID
	  ,CDS.LEADING_COMP_SCOPE_ID
	  ,CDS.DEPENDENT_COMP_SCOPE_ID

	  ,cfd.LEADING_FIELD_ID
	  ,cfd.DEPENDENT_FIELD_ID
	  --,cfd.FUNCTIONAL_FIELD_NAME
	  --,cfd.FUNCTIONAL_FIELD_NAME_DE
	  --,cfd.FUNCTIONAL_FIELD_NAME_EN

      ,LS.SOURCE_SYSTEM_TYPE_ID						AS LEADING_REF_SOURCE_SYSTEM_TYPE_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,LS.SOURCE_SYSTEM_ID							AS LEADING_REF_SOURCE_SYSTEM_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,LS.COUNTRY_ID									AS LEADING_REF_COUNTRY_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,LS.BRANCH_ID									AS LEADING_REF_BRANCH_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,LS.TEST_OBJECT_TYPE_ID						AS LEADING_REF_TEST_OBJECT_TYPE_ID ----- Added columns to simplify metrics as headers creation (KD)  
	 
      ,DS.SOURCE_SYSTEM_TYPE_ID						AS DEPENDENT_REF_SOURCE_SYSTEM_TYPE_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,DS.SOURCE_SYSTEM_ID  						AS DEPENDENT_REF_SOURCE_SYSTEM_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,DS.COUNTRY_ID									AS DEPENDENT_REF_COUNTRY_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,DS.BRANCH_ID									AS DEPENDENT_REF_BRANCH_ID ----- Added columns to simplify metrics as headers creation (KD)  
      ,DS.TEST_OBJECT_TYPE_ID							AS DEPENDENT_REF_TEST_OBJECT_TYPE_ID ----- Added columns to simplify metrics as headers creation (KD)  

      
  FROM idq_results.REF_COMP_DEFINITION_SCOPE_1 CDS
 -- join idq_results.REF_COMP_DEFINITION_SCOPE_1 CDS
 -- on cds.ID=cfds.COMP_DEFINITION_SCOPE_ID

  --join idq_results.REF_COMP_FIELD_DEFINITION_1 CFD
  --on cfd.ID=cfds.COMP_FIELD_DEFINITION_ID
    join idq_results.ref_comp_scope_1 LS
  on CDS.LEADING_COMP_SCOPE_ID=LS.ID
  
  join idq_results.ref_comp_scope_1 DS
  on CDS.DEPENDENT_COMP_SCOPE_ID=DS.ID

  left outer join idq_results.REF_COMP_FIELD_DEFINITION_SCOPE_1 CFDS
  
  on cds.ID=cfds.COMP_DEFINITION_SCOPE_ID

  left outer join idq_results.REF_COMP_FIELD_DEFINITION_1 CFD
  on cfd.ID=cfds.COMP_FIELD_DEFINITION_ID
;