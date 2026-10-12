/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_COUNTRY_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_COUNTRY_1
(
country_sid
 ,src_country_lidl_cd
 ,src_lang_id
 ,country_name
 ,country_grp_sid
 ,lang_sid
 ,lang_cd
 ,dwh_load_id
 ,dwh_created
 ,dwh_updated
 )
AS
SELECT
country_sid
,src_country_lidl_cd
,src_lang_id
,country_name
,country_grp_sid
,lang_sid
,lang_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_CORE_AC.V_COUNTRY_1;