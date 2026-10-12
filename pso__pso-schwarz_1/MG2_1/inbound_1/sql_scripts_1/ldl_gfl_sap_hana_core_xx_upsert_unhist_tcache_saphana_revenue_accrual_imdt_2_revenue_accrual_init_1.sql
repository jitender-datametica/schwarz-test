INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INT_ORG_SID ,
        INT_ORG_TYPE_CD ,
        COUNTRY_ORG_SID ,
        COUNTRY_ORG_CD ,
        REAL_ESTATE_SID ,
        ACCRUAL_DT ,
        BUS_DT ,
        CURR_ACCRUAL_FG ,
        RECEIPT_CNT ,
        TURNOVER_NET_VAL ,
        CURR_CD ,
        SOURCE_SYSTEM,
        EXTRACTION_DT,
        DWH_MAPPING_TMSP,
        TF_ERROR_FG,
        DELETED_FG,
        RECORD_ID,
        FILENAME,
        DWH_NODE_CD,
        DWH_LOAD_ID
)
SELECT
        SRC.INT_ORG_SID ,
        SRC.INT_ORG_TYPE_CD ,
        SRC.COUNTRY_ORG_SID ,
        COALESCE(ORG.COUNTRY_ORG_CD,'-1'),
        SRC.REAL_ESTATE_SID ,
        SRC.ACCRUAL_DT ,
        SRC.BUS_DT ,
        'FALSE',
        SRC.RECEIPT_CNT ,
        SRC.TURNOVER_NET_VAL ,
        SRC.CURR_CD, 
        'SAP_HANA',
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP              AS  DWH_MAPPING_TMSP,
        0                              AS  TF_ERROR_FG,
        0                              AS  DELETED_FG,
        0                              AS  RECORD_ID,
        't_${SRC_INPUT_TABLE}'         AS  FILENAME,
        'SAP_HANA'                     AS  DWH_NODE_CD,
       '${LOAD_ID}' as DWH_LOAD_ID 
FROM
(
    SELECT
        INT_ORG_SID
      , INT_ORG_TYPE_CD
      , REAL_ESTATE_SID
      , BUS_DT
      , Max(ACCRUAL_DT)         AS ACCRUAL_DT
      , Max(COUNTRY_ORG_SID)    AS COUNTRY_ORG_SID 
      , Max(CURR_CD)            AS CURR_CD
      , Sum(RECEIPT_CNT)        AS RECEIPT_CNT
      , Sum(TURNOVER_NET_VAL)   AS TURNOVER_NET_VAL
    FROM ${TEMP_DB}.t_${SRC_INPUT_TABLE}
    WHERE OBJECT_TYPE IN ('20', '90')
    AND BUS_DT
        BETWEEN ADD_MONTHS(CURRENT_DATE, -600) AND CURRENT_DATE - DAY(CURRENT_DATE) -- 50 Years
    GROUP BY
        INT_ORG_SID
      , INT_ORG_TYPE_CD
      , REAL_ESTATE_SID
      , BUS_DT
) SRC
LEFT OUTER JOIN ${TARGET_DB}.T_INTERNAL_ORGANIZATION_1 ORG
ON  SRC.COUNTRY_ORG_SID = ORG.INT_ORG_SID
AND ORG.DWH_VALID_FG
;
