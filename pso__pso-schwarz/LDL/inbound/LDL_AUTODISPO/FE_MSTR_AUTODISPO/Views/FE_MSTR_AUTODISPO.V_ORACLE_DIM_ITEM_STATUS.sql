CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_DIM_ITEM_STATUS(
	COUNTRY
	,DIS_WH
	,DIS_ITEM_NR
	,DIS_PACKAGECAPACITY
	,DIS_STATUS
	,DIS_STATUS_DATE
	,ACTIVE_FG
	,MOD_DATE
	,SOURCE_EXTRACTION_TMSP
) AS   
    /* Version:   1.3
    ** Author:    Dominik Pfarr
    ** Date:      2024-06-27
    ** Changes:   adding active_flag, only active items; non-hist version using valid dates
    */
SELECT COUNTRY
	,DIS_WH
	,DIS_ITEM_NR
	,DIS_PACKAGECAPACITY
	,DIS_STATUS
	,DIS_STATUS_DATE
    ,ACTIVE_FG
	,MOD_DATE
	,SOURCE_EXTRACTION_TMSP
	
    FROM CORE.T_ORACLE_V_DIM_ITEM_STATUS
    WHERE active_fg = 1
    AND CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;