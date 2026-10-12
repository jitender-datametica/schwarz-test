/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.v_brand_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_BRAND_2 
(
	client_id
	,brand_sid
	,src_brand_cd
	,brand_name
	,brand_type_cd
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
	client_id
	,brand_sid
	,src_brand_cd
	,brand_name
	,brand_type_cd
	,dwh_load_id
	,dwh_created
	,dwh_updated     

FROM P_LEW_CORE_AC.V_BRAND_2 ;