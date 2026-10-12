/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_wharea
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for warehouse area
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_forklift_wharea (
    WH_AREA COMMENT 'Warehouse area',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_SRC COMMENT 'DWH source'
) COMMENT='Distinct lookup values for warehouse area'
 AS 
SELECT
    wh_area
    ,MAX(dwh_created)
    ,MAX(dwh_src)
FROM "DATA".t_ref_queue 
GROUP BY wh_area;
