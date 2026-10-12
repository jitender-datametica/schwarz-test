CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_SAPEWM_MFS_NIO_ERROR_2(
	CLIENT_ID
	,WH_ID
	,HU_IDENT
	,LOG_SEQ
	,CRTD_ON_DT
	,COM_POINT
    ,HU_STAT
	,HU_STAT_SHORT
	,ERR_CD
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
) AS
SELECT
	client_id
	,wh_id
	,huident AS hu_ident
	,log_seq
    ,TO_DATE(UTC_TIMESTAMP) AS crtd_on_dt
	,cp AS com_point
	,hu_status AS hu_stat
	,hu_status_short AS hu_stat_short
	,CASE
     WHEN client_id <> 23 THEN 
        IFF(
            com_point LIKE ANY ('IB-IP1%', 'DI-IP1%', 'B1-IP1%', 'F1-IP1%', 'B2-IP1%', 'P2-IP1%', 'TI-IP1%')
            AND (hu_stat_short LIKE ANY ('CLOW', 'COBE') OR hu_stat_short = 'CFFR')
            ,NULL
            ,hu_stat_short
        )
     WHEN client_id = 23 THEN 
        IFF(
            com_point LIKE 'TI%'
			AND hu_stat_short IS NOT NULL
            ,hu_stat_short
			,NULL
        )
	 END AS err_cd 
	,dwh_load_id
	,dwh_created
	,dwh_updated
	FROM DATA.T_SAPEWM_NIOHISTORY_2
	WHERE (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (13,60), (18, 4), (23, 18), (25, 96))
;