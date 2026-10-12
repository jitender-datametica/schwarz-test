/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          data
DB table/view:      T_SAPEWM_GPL_FILTER_1
====================================================================================================
*/

/*
----------------------------------------------------------------------------------------------------
    Table T_SAPEWM_GPL_FILTER_1
----------------------------------------------------------------------------------------------------
*/
CREATE TABLE DATA.T_SAPEWM_GPL_FILTER_1 (
	DEST_STRG_TYPE VARCHAR(4) COMMENT 'Destination Storage Type',
	QUEUE VARCHAR(10) COMMENT 'Warehouse queue',
	AREA_COMB VARCHAR(15) COMMENT 'Area Comb'
);