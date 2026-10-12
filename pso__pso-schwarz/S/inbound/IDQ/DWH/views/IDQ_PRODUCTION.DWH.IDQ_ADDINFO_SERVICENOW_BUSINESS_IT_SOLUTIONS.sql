create or replace view IDQ_PRODUCTION.DWH.IDQ_ADDINFO_SERVICENOW_BUSINESS_IT_SOLUTIONS(
	ID,
	IDQ_TEST_OBJECT_ID,
	REF_BRANCH_ID,
	SOURCE_SYSTEM_PRIMARY_KEY,
	REF_SOURCE_SYSTEM_ID,
	REF_COUNTRY_ID,
	NAME,
	STATUS,
	SOLUTION_EXPERT,
	SOLUTION_EXPERT_DEPUTY,
	SOLUTION_OWNER,
	SOLUTION_OWNER_DEPUTY,
	VERWENDET_VON_MANDANT_UND_REGION,
	BESCHREIBUNG,
	BUSINESS_SOLUTION_GROUP,
	ORG_LEVEL_1,
	ORG_LEVEL_2,
	KATERIE,
	IS_RELEVANT
) as
select    bs.ID,
          ito.ID AS IDQ_TEST_OBJECT_ID,
          bs.BRANCH_ID AS REF_BRANCH_ID,
		  --ito.BRANCH_ID AS TEST_BRANCH,
          bs.SOURCE_SYSTEM_PRIMARY_KEY,
          bs.SOURCE_SYSTEM_ID AS REF_SOURCE_SYSTEM_ID,
          bs.COUNTRY_ID AS REF_COUNTRY_ID,
          bs.Name,
          Status,
          Solution_Expert,
          Solution_Expert_Deputy,
          Solution_Owner,
          Solution_Owner_Deputy,
          Verwendet_von_Mandant_und_Region,
          Beschreibung,
          Business_Solution_Group,
          Org_Level_1,
          Org_Level_2,
          Katerie,
          bs.IS_RELEVANT

FROM idq_results.IDQ_ADDINFO_SERVICENOW_BUSINESS_SOLUTION as bs
	join idq_results.IDQ_TEST_OBJECT as ito
	on bs.SOURCE_SYSTEM_PRIMARY_KEY = ito.SOURCE_SYSTEM_PRIMARY_KEY
		and bs.SOURCE_SYSTEM_ID = ito.SOURCE_SYSTEM_ID
		and bs.COUNTRY_ID = ito.COUNTRY_ID
		--and bs.BRANCH_ID = ito.BRANCH_ID
		and ito.TEST_OBJECT_TYPE_ID > 17

UNION ALL

select    iso.ID,
          ito.ID AS IDQ_TEST_OBJECT_ID,
          iso.BRANCH_ID AS REF_BRANCH_ID,
		  --ito.BRANCH_ID AS TEST_BRANCH,
          iso.SOURCE_SYSTEM_PRIMARY_KEY,
          iso.SOURCE_SYSTEM_ID AS REF_SOURCE_SYSTEM_ID,
          iso.COUNTRY_ID AS REF_COUNTRY_ID,
          iso.Name,
          Status,
          Solution_Expert,
          Solution_Expert_Deputy,
          Solution_Owner,
          Solution_Owner_Deputy,
          Verwendet_von_Mandant_und_Region,
          Beschreibung,
          Business_Solution_Group,
          Org_Level_1,
          Org_Level_2,
          Katerie,
          iso.IS_RELEVANT
 FROM idq_results.IDQ_ADDINFO_SERVICENOW_IT_SOLUTION iso join idq_results.IDQ_TEST_OBJECT ito
on iso.SOURCE_SYSTEM_PRIMARY_KEY = ito.SOURCE_SYSTEM_PRIMARY_KEY
and iso.SOURCE_SYSTEM_ID = ito.SOURCE_SYSTEM_ID
and iso.COUNTRY_ID = ito.COUNTRY_ID
and ito.TEST_OBJECT_TYPE_ID > 17
;