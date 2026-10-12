/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_KFL_BRAND
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_KFL_BRAND 
(
	 client_id
	,kfl_brand_sid
	,kfl_brand_name
	,brand_type_cd
	,dwh_load_id
	,dwh_created
	,dwh_updated     
)
AS
    SELECT 
	 client_id
	,kfl_brand_sid
	,kfl_brand_name
	,brand_type_cd
	,dwh_load_id
	,dwh_created
	,dwh_updated   

FROM P_LEW_CORE.T_KFL_BRAND ;