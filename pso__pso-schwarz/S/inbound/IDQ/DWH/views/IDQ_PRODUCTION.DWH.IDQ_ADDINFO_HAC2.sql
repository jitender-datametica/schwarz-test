create or replace view IDQ_PRODUCTION.DWH.IDQ_ADDINFO_HAC2(
	IDQ_ADDINFO_HAC2_ID,
	IDQ_TEST_OBJECT_ID,
	REF_BRANCH_ID,
	SOURCE_SYSTEM_PRIMARY_KEY,
	REF_SOURCE_SYSTEM_ID,
	REF_COUNTRY_ID,
	IS_RELEVANT,
	IS_COUNTRY_SYSTEM,
	NAME,
	VIRTUAL_HOSTNAME,
	PHYSICAL_HOSTNAME,
	URL
) as
SELECT ID							AS IDQ_ADDINFO_HAC2_ID
      ,TEST_OBJECT_ID 			AS IDQ_TEST_OBJECT_ID
      ,BRANCH_ID					AS REF_BRANCH_ID
      ,SOURCE_SYSTEM_PRIMARY_KEY	--NO other name required as it is no FOREIGN KEY
      ,SOURCE_SYSTEM_ID			AS REF_SOURCE_SYSTEM_ID
      ,COUNTRY_ID					AS REF_COUNTRY_ID
      ,IS_RELEVANT
	  ,IS_COUNTRY_SYSTEM
      ,NAME
      ,VIRTUAL_HOSTNAME
	  ,PHYSICAL_HOSTNAME
      --,URL --- modified by KD at 20220118
	  , '<a href="' + URL + '" target="_blank"><img src="' + 'https://confluence.schwarz/download/thumbnails/61351724/Info-Icon.png?version=1&modificationDate=1605254618000&api=v2" width="24" height="24">'
                          + '</img></a>' AS URL --- modified by KD at 20220118
  FROM idq_results.IDQ_ADDINFO_HAC2;