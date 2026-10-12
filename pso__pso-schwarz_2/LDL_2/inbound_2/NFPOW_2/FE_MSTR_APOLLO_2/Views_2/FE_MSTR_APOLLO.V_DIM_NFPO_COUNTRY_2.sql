/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_COUNTRY_2
#----------------------------------------------------------------------------
# History:
#  1.0  13.06.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_NFPO_COUNTRY_2 
(
     NFPO_COUNTRY_SID 
	,NFPO_COUNTRY_CD 
	,NFPO_COUNTRY_NAME 
	,DWH_CREATED_TMSP 
	,DWH_UPDATED_TMSP 
	,DWH_SRC_TMSP 
)
AS SELECT
     main.NFPO_COUNTRY_SID 
	,main.NFPO_COUNTRY_CD 
	,main.NFPO_COUNTRY_NAME 
	,main.DWH_CREATED_TMSP 
	,main.DWH_UPDATED_TMSP 
	,main.DWH_SRC_TMSP 
FROM CORE.T_DIM_NFPO_COUNTRY_2 main
;