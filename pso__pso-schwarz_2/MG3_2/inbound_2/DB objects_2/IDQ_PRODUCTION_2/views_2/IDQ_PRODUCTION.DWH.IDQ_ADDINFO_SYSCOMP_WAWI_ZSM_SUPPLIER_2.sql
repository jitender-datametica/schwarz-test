create or replace view IDQ_PRODUCTION.DWH.IDQ_ADDINFO_SYSCOMP_WAWI_ZSM_SUPPLIER_2(
	ID,
	LEADING_IDQ_TEST_OBJECT_ID,
	LEADING_PRIMARY_KEY,
	DEPENDENT_PRIMARY_KEY,
	LEADING_SYSTEM_ID,
	DEPENDENT_SYSTEM_ID,
	BRANCH_ID,
	COUNTRY_ID,
	C216_INT_SUPPNR,
	WAWI_NAME,
	INT_BUY_COUNTRY,
	C0606_REASON_FOR_RELEVANCE,
	ZSM_NAME,
	WARENBEREICHE,
	SUCHNAME,
	SAP_KRED_LINK
) as 
select  
row_number() over (partition by 1 order by 1) AS id, --a.id, -> duplicates because of different countries running in parallel
b.id as leading_idq_test_object_id,
a.leading_primary_key, 
a.dependent_primary_key, 
a.leading_system_id, 
a.dependent_system_id, 
a.branch_id, 
a.country_id, 
a.c216_int_suppnr, 
a.wawi_name, 
a.int_buy_country, 
a.c0606_reason_for_relevance, 
a.zsm_name, 
a.warenbereiche, 
a.suchname,
a.sap_kred_link 
from idq_results.IDQ_ADDINFO_SYSCOMP_WAWI_ZSM_SUPPLIER_2 a
left join (
select id, source_system_primary_key, country_id
from idq_results.idq_test_object_2
where source_system_id IN (
select a.ID from idq_results.ref_source_system_2 a
left join idq_results.ref_source_system_type_2 b on a.source_system_type_id = b.id
where b.id = 2
and a.source_system not like '%WH%')
and test_object_type_id = 2) b 
on b.source_system_primary_key = a.leading_primary_key and b.country_id = a.country_id;