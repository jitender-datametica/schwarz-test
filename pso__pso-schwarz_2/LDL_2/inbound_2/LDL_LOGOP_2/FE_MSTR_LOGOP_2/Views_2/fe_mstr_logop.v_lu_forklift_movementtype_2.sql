/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lu_forklift_movementtype_2
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2021-12-01      Fikri Tekin             Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    FE lookup view for movement type
----------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW fe_mstr_logop.v_lu_forklift_movementtype_2 (
    MOVEMENT_TYPE COMMENT 'Movement type',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_SRC COMMENT 'DWH source'
) COMMENT='Distinct lookup values for movement type (based on mv_ref_queue_2)'
 AS 
SELECT
    movement_type
    ,MAX(dwh_created)
    ,MAX(dwh_src)
FROM "DATA".t_ref_queue_2 
GROUP BY movement_type;
