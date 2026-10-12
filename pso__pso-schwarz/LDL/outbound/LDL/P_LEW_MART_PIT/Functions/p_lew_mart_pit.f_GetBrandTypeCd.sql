/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for function f_GetBrandTypeCd
#-------------------------------------------------------------------------------
# Description: Get the brand type from buying list type
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-27 Mike Davis   Initial version
#                               Now Returns 'N/A' for invalid buying list type.
#                               Converted case statement to nested Iff()set
#                               because case caused trouble in DBeaver.
#                               Added tests.
#  1.1 2022-02-02 Andreas Kurz	Reowrked and reformated so that this is working on the 
#								Script Framework
#  1.2 2023-03-03 Andreas Kurz  Changed Outputtext from Marke to M
#-------------------------------------------------------------------------------
*/

/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE        LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA          P_LEW_MART_PIT;
*/
/*
---------------------------------------------------------------------
Function    :   f_GetBrandTypeCd(INTEGER)
Input       :   p_BUYING_LIST_TYPE_ID INTEGER
Return      :   BRAND_TYPE_CD VARCHAR -->
                  'Marke': from a specific set of buying list types
                  'EM': not a Marke (or cannot be determined) [Default] (should we have 'N/A' for buying list type of Null or -1?)
Convert     :   None
TYPE		:	SQL-Function - single scalar
Description :   Simply get a derived brand type from the buying list type according to the logic below.
Examples    :   SELECT P_LEW_MART_PIT.f_GetBrandTypeCd(-1);     --> N/A
                SELECT P_LEW_MART_PIT.f_GetBrandTypeCd(Null);   --> N/A
                SELECT P_LEW_MART_PIT.f_GetBrandTypeCd(7);      --> Marke
                SELECT P_LEW_MART_PIT.f_GetBrandTypeCd(8);      --> EM
                SELECT P_LEW_MART_PIT.f_GetBrandTypeCd(11);     --> Marke
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getbrandtypecd(p_BUYING_LIST_TYPE_ID INT64)
RETURNS STRING
AS (
    IF(
        p_BUYING_LIST_TYPE_ID = -1 OR p_BUYING_LIST_TYPE_ID IS NULL,
        'N/A',
        IF(
            p_BUYING_LIST_TYPE_ID IN (1,3,5,7,9,11),
            'M',
            'EM'
        )
    )
); -- End of f_GetBrandTypeCd


/* 
---------------------------------------------------------------------
999. Testing / DQ
---------------------------------------------------------------------
*/

/*
SELECT f_GetBrandTypeCd(-1)
;

SELECT f_GetBrandTypeCd(Null)
;

SELECT f_GetBrandTypeCd(7)
;

SELECT f_GetBrandTypeCd(8)
;

SELECT f_GetBrandTypeCd(11)
;




SELECT '>>> ${EXEC_PIT_TIMESTAMP} | EOF [f_GetBrandTypeCd]' AS ""
;
*/

/* --- EOF - END OF FILE --- */