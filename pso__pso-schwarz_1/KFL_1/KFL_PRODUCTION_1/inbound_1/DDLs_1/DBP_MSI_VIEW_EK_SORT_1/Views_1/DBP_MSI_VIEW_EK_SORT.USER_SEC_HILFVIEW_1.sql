CREATE OR REPLACE view DBP_MSI_VIEW_EK_SORT.USER_SEC_HILFVIEW_1
as
select distinct
mandant_id
,zek_id
,user_id
from dbp_security.user_zek_zu_1
where user_id='ikul2811';