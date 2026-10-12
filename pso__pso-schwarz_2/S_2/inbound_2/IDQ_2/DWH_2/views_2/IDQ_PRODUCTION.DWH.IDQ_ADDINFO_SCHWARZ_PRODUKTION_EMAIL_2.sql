create or replace view IDQ_PRODUCTION.DWH.IDQ_ADDINFO_SCHWARZ_PRODUKTION_EMAIL_2(
	ID,
	TEST_OBJECT_ID,
	BRANCH_ID,
	SOURCE_SYSTEM_PRIMARY_KEY,
	SOURCE_SYSTEM_ID,
	COUNTRY_ID,
	IS_RELEVANT,
	MAKTX,
	MATKL,
	MSTAE,
	WERKS,
	CONTENT_HASH_CODE,
	WERK_SPLIT,
	REF_MAIL_SP_WERK_ID,
	REF_MAIL_SP_WG_ID,
	REF_MAIL_SP_MATART_ID
) as
(
select
a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
mwerk.id as REF_MAIL_SP_werk_id,
mwg.id as REF_MAIL_SP_wg_id,
mmtart.id as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
idq_results.ref_mail_sp_werk_2 mwerk,
idq_results.ref_mail_sp_wg_2 mwg,
idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
and werk_split = mwerk.werk
and a.matkl = mwg.wg
and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
mwerk.id as REF_MAIL_SP_werk_id,
mwg.id as REF_MAIL_SP_wg_id,
1 as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
idq_results.ref_mail_sp_werk_2 mwerk,
idq_results.ref_mail_sp_wg_2 mwg,
--idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
and werk_split = mwerk.werk
and a.matkl = mwg.wg
--and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
mwerk.id as REF_MAIL_SP_werk_id,
1 as REF_MAIL_SP_wg_id,
mmtart.id as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
idq_results.ref_mail_sp_werk_2 mwerk,
--idq_results.ref_mail_sp_wg_2 mwg,
idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
and werk_split = mwerk.werk
--and a.matkl = mwg.wg
and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
mwerk.id as REF_MAIL_SP_werk_id,
1 as REF_MAIL_SP_wg_id,
1 as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
idq_results.ref_mail_sp_werk_2 mwerk,
--idq_results.ref_mail_sp_wg_2 mwg,
--idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
and werk_split = mwerk.werk
--and a.matkl = mwg.wg
--and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
1 as REF_MAIL_SP_werk_id,
mwg.id as REF_MAIL_SP_wg_id,
mmtart.id as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
--idq_results.ref_mail_sp_werk_2 mwerk,
idq_results.ref_mail_sp_wg_2 mwg,
idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
--and werk_split = mwerk.werk
and a.matkl = mwg.wg
and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
1 as REF_MAIL_SP_werk_id,
mwg.id as REF_MAIL_SP_wg_id,
1 as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
--idq_results.ref_mail_sp_werk_2 mwerk,
idq_results.ref_mail_sp_wg_2 mwg,
--idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
--and werk_split = mwerk.werk
and a.matkl = mwg.wg
--and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
1 as REF_MAIL_SP_werk_id,
1 as REF_MAIL_SP_wg_id,
mmtart.id as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
--idq_results.ref_mail_sp_werk_2 mwerk,
--idq_results.ref_mail_sp_wg_2 mwg,
idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
--and werk_split = mwerk.werk
--and a.matkl = mwg.wg
and a.mtart = mmtart.matart

union

select a.id,
a.test_object_id,
a.branch_id,
a.source_system_primary_key,
a.source_system_id,
a.country_id,
a.is_relevant,
a.maktx,
a.matkl,
a.mstae,
a.werks,
a.content_hash_code,
value as werk_split,
1 as REF_MAIL_SP_werk_id,
1 as REF_MAIL_SP_wg_id,
1 as REF_MAIL_SP_matart_id
from idq_results.idq_addinfo_schwarz_produktion_article_2 a,
lateral split_to_table(a.werks,'|'),
idq_results.check_error_info_current_2 e,
--idq_results.ref_mail_sp_werk_2 mwerk,
--idq_results.ref_mail_sp_wg_2 mwg,
idq_results.ref_mail_sp_matart_2 mmtart
where a.test_object_id=e.test_object_id
--and werk_split = mwerk.werk
--and a.matkl = mwg.wg
--and a.mtart = mmtart.matart
)
;