/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_rsrctype
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for resource type in SAP EWM forklift
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_forklift_rsrctype (
    rsrc_type COMMENT 'Resource type'
    ,dwh_created COMMENT 'DWH creation timestamp'
    ,dwh_src COMMENT 'DWH source'
) COMMENT = 'Distinct lookup values for resource type (based on t_lu_forklift_rsrctype)'
AS 
SELECT
    rsrc_type
    ,MAX(dwh_created)
    ,MAX(dwh_src)
FROM DATA.t_lu_forklift_rsrctype
GROUP BY rsrc_type
;
