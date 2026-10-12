/*
====================================================================================================
Division:			Lidl
Solution:			Operational Logistics (LOGOP)
DB schema:			data
DB table/view:		t_lu_mfs_conveyor_type_1
====================================================================================================
Change history:		version, date, developer, comment
	1.0		2022-06-02		Fikri Tekin			Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
	Table for FE lookup for conveyor type in SAP EWM MFS Conveyor Usage
----------------------------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lu_mfs_conveyor_type_1 (
lu_id NUMERIC(3) NOT NULL OPTIONS(description='Internal ID'),
ct_id NUMERIC(3,1) NOT NULL OPTIONS(description='Conveyor type ID (PK)'),
ct_desc STRING(100) OPTIONS(description='Conveyor type in English'),
ct_desc_de STRING(100) OPTIONS(description='Conveyor type in German'),
dwh_created DATETIME OPTIONS(description='DWH creation time'),
dwh_src STRING(50) OPTIONS(description='DWH source'),
PRIMARY KEY (ct_id) NOT ENFORCED
) OPTIONS(description='SAP EWM MFS Conveyor Usage - lookup table for conveyor type');