/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_SUPPLIER_1
#----------------------------------------------------------------------------
# History:
#  1.0  13.06.2023    Aparna Rayanki           Initial Version
#  1.1  23.06.2023    Aparna Rayanki           Removed vat_nr and active_fg columns
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_NFPO_SUPPLIER_1 
(
     NFPO_SUP_SID
    ,NFPO_SUP_NR
    ,NFPO_SUP_NAME
    ,NFPO_GTIN_OWNERSHIP_CD
    ,NFPO_GTIN_OWNERSHIP_DESCR
    ,NFPO_COUNTRY_SID
    ,NFPO_COUNTRY_CD
    ,NFPO_COUNTRY_NAME
    ,STREET_NAME
    ,CITY_NAME
    ,ZIP
    ,EKS_SUP_NR
	,DWH_CREATED_TMSP
	,DWH_UPDATED_TMSP
	,DWH_SRC_TMSP
)
AS SELECT
     main.NFPO_SUP_SID
    ,main.NFPO_SUP_NR
    ,main.NFPO_SUP_NAME
    ,main.NFPO_GTIN_OWNERSHIP_CD
    ,main.NFPO_GTIN_OWNERSHIP_DESCR
    ,main.NFPO_COUNTRY_SID
    ,main.NFPO_COUNTRY_CD
    ,main.NFPO_COUNTRY_NAME
    ,main.STREET_NAME
    ,main.CITY_NAME
    ,main.ZIP
    ,main.EKS_SUP_NR
	,main.DWH_CREATED_TMSP
	,main.DWH_UPDATED_TMSP
	,main.DWH_SRC_TMSP
FROM CORE.T_DIM_NFPO_SUPPLIER_1 main
;