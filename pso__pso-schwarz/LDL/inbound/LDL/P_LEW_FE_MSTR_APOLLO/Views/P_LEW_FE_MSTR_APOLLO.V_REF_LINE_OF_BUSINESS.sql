/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_REF_LINE_OF_BUSINESS
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_REF_LINE_OF_BUSINESS
(
     LOB_CD
    ,LOB_NAME
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
)
AS
   SELECT
     LOB_CD
	,LOB_NAME
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
FROM P_LEW_CORE.T_REF_LINE_OF_BUSINESS;