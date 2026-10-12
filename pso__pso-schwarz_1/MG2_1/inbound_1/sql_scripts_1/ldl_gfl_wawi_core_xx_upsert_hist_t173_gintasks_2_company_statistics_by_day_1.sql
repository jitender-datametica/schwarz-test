INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
      INT_COMPANY_NATURAL_KEY
    , INT_COMPANY_KEY_TYPE_CD
    , STAT_TYPE_CD 
    , STAT_DT
    , BUS_DT
    , CURR_STAT_FG
    , STAT_VAL 
    , CURR_CD
    , STAT_CNT
    , STAT_QTY
    , STAT_MEAS
    , UOM_CD

-------------------------
    ,source_system
    ,extraction_dt
    ,dwh_mapping_tmsp
    ,tf_error_fg
    ,deleted_fg
    ,record_id
    ,filename
    ,dwh_node_cd
    ,dwh_load_id
)
SELECT	
  GT.ctrcode ||'|'|| CAST( CAST(GT.wh_nr AS BIGINT) AS STRING) AS INT_COMPANY_NATURAL_KEY,
 'COMPANY' AS INT_COMPANY_KEY_TYPE_CD,
  138 AS STAT_TYPE_CD,
  CURRENT_TIMESTAMP AS STAT_DT,
  CAST(GT.C173_CREATE_DATE AS DATE) AS BUS_DT,
  1 AS CURR_STAT_FG,
  NULL AS STAT_VAL,
  NULL AS CURR_CD,
  NULL AS STAT_CNT,
  SUM(C173_PAL_DD_GOODS * 0.5) + SUM(C173_PAL_EU_GOODS) AS STAT_QTY,
  NULL AS STAT_MEAS,
  NULL AS UOM_CD,
  ---------------------
  'WAWI' source_system,
  MAX(GT.extraction_tmsp) extraction_dt,
  MAX(GT.extraction_tmsp) dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id 
FROM   
(
  SELECT ctrcode, wh_nr, C173_CREATE_DATE, C173_PAL_DD_GOODS, C173_PAL_EU_GOODS, C173_TASKSTATUS, C173_GATETYPEID, extraction_tmsp  FROM
  ETL.T173_GINTASKS_1 GT 
  QUALIFY Row_Number() OVER (PARTITION BY LEFT( CTRCODE, 2), C173_TASKID  ORDER BY EXTRACTION_TMSP DESC) = 1 
) GT
WHERE GT.C173_TASKSTATUS = 99
  AND GT.C173_GATETYPEID IS NOT NULL
GROUP BY 1,2,3,4,5,6,7,8,9,11,12,13  
