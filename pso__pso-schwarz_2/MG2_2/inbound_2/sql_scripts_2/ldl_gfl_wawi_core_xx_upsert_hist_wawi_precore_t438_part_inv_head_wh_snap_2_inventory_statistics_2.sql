INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INV_KEY_TYPE_CD
       ,INV_NATURAL_KEY
       ,inv_stat_type_cd
       ,inv_stat_val
       ,curr_cd
       ,SOURCE_SYSTEM
       ,EXTRACTION_DT
       ,DWH_MAPPING_TMSP
       ,TF_ERROR_FG
       ,DELETED_FG
       ,RECORD_ID
       ,FILENAME
       ,DWH_NODE_CD
       ,DWH_LOAD_ID
)
SELECT  
       'PART' AS INV_KEY_TYPE_CD,
        CTRCODE || '|' || WH_NR || '|' || C438_INV_ID  AS INV_NATURAL_KEY,
        stat.inv_stat_type_cd,
        CASE WHEN stat.inv_stat_type_cd = 'TURNOVER' THEN SRC.c438_turnover
             WHEN stat.inv_stat_type_cd = 'DIFF' THEN SRC.c438_diffvalue
        END AS stat_val,
        org.curr_cd,
        'WAWI_WH' AS SOURCE_SYSTEM,
        EXTRACTION_TMSP AS EXTRACTION_DT,
        CURRENT_TIMESTAMP() AS DWH_MAPPING_TMSP,
        0 AS TF_ERROR_FG,
        0 AS DELETED_FG,
        0 AS RECORD_ID,
        't_${SRC_INPUT_TABLE}' AS FILENAME,
        'WAWI_WH' AS DWH_NODE_CD,
        '${LOAD_ID}' as DWH_LOAD_ID 
FROM etl_process.t_${SRC_INPUT_TABLE}  SRC 
INNER JOIN ${TEMP_DB}.WAWI_CONTROL_TABLE_2 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.t438_part_inv_head_wh_2')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
INNER JOIN meta.t_party_key_2 pk ON party_key_type_cd='COUNTRY_2' AND party_nat_key_nr=SRC.ctrcode AND  pk.dwh_valid_fg
LEFT OUTER JOIN core_rel.t_internal_organization_2 org ON int_org_sid=pk.party_sid  AND  org.dwh_valid_fg
CROSS JOIN
(
    SELECT *
    FROM (Values 
        ('TURNOVER'),
        ('DIFF')
    ) AS stat (inv_stat_type_cd)
) AS stat  
;
