/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ADVERTISE_THEME
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ADVERTISE_THEME  
(
	 client_id
    ,mdm_ad_theme_sid
	,src_proj_doc_ref
	,ad_theme_name
	,ad_theme_cd
	,ad_theme_id
	,busyear_ad_theme
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
	 client_id
    ,mdm_ad_theme_sid
	,src_proj_doc_ref
	,ad_theme_name
	,ad_theme_cd
	,ad_theme_id
	,busyear_ad_theme
	,dwh_load_id
	,dwh_created
	,dwh_updated 

FROM P_LEW_CORE_AC.V_MDM_ADVERTISE_THEME  ;