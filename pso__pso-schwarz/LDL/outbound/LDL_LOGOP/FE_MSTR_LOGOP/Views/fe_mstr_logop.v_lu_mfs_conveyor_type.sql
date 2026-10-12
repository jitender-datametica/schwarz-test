/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			fe_mstr_logop
DB table/view:		v_lu_mfs_conveyor_type
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-06-01		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	FE lookup view for conveyor type in SAP EWM MFS Conveyor Usage
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_mfs_conveyor_type (ct_id
OPTIONS(description='Conveyor type ID (PK)'), ct_desc OPTIONS(description='Conveyor type in English'), ct_desc_de
OPTIONS(description='Conveyor type in German'), dwh_created OPTIONS(description='DWH creation time'), dwh_src
OPTIONS(description='DWH source'))
OPTIONS(DESCRIPTION = `SAP EWM MFS CONVEYOR USAGE - LOOKUP VIEW FOR CONVEYOR TYPE (BASED ON T_LU_MFS_CONVEYOR_TYPE)`) AS
SELECT ct_id0 AS ct_id,
 ct_desc,
 ct_desc_de,
 dwh_created,
 dwh_src
FROM (SELECT CASE
    WHEN ct_id = 1
    THEN 1
    WHEN ct_id = 2
    THEN 2
    WHEN ct_id = 3
    THEN 3
    WHEN ct_id = 3.1
    THEN 31
    WHEN ct_id = 3.2
    THEN 32
    WHEN ct_id = 4
    THEN 4
    WHEN ct_id = 4.1
    THEN 41
    WHEN ct_id = 4.2
    THEN 42
    WHEN ct_id = 4.3
    THEN 43
    WHEN ct_id = 4.4
    THEN 44
    WHEN ct_id = 4.5
    THEN 45
    WHEN ct_id = 4.6
    THEN 46
    WHEN ct_id = 5
    THEN 5
    WHEN ct_id = 6
    THEN 6
    WHEN ct_id = 7
    THEN 7
    WHEN ct_id = 8
    THEN 8
    WHEN ct_id = 9
    THEN 9
    WHEN ct_id = 10
    THEN 10
    WHEN ct_id = 11
    THEN 11
    WHEN ct_id = 12
    THEN 12
    WHEN ct_id = 13
    THEN 13
    WHEN ct_id = 14
    THEN 14
    WHEN ct_id = 15
    THEN 15
    WHEN ct_id = 15.1
    THEN 151
    ELSE NULL
    END AS ct_id0,
   ct_desc,
   ct_desc_de,
   dwh_created,
   dwh_src,
   ct_id
  FROM ldl_logop_data.t_lu_mfs_conveyor_type
  ORDER BY ct_id NULLS LAST) AS t0;