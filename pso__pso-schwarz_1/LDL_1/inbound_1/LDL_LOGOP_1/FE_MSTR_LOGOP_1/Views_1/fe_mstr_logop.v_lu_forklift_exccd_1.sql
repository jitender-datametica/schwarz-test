/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_exccd_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for exception code in SAP EWM forklift
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_forklift_exccd_1 (
    exc_cd COMMENT 'Exception code'
    ,exc_desc COMMENT 'Exception description'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Distinct lookup values for exception code (based on t_lu_forklift_exccd_1)'
AS 
SELECT
    exc_cd
    ,exc_desc
    ,MAX(dwh_created)
    ,MAX(dwh_src)
FROM DATA.t_lu_forklift_exccd_1
GROUP BY exc_cd, exc_desc
;
