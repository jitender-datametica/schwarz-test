INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        INV_SID,
        INV_STAT_TYPE_CD,
        INV_STAT_VAL,
        CURR_CD,
        INV_STAT_CNT,
        INV_STAT_QTY,
        INV_STAT_PCT,
        INV_STAT_MEAS,
        UOM_CD,
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
select 
        inv_sid,
        stat.inv_stat_type_cd,
        CASE 
         WHEN stat.inv_stat_type_cd = 'TURNOVER_NET' THEN c182_turnoverval_net
         WHEN stat.inv_stat_type_cd = 'DIFF_NET' THEN c182_diffval_net
         WHEN stat.inv_stat_type_cd = 'INVENTORY_NET' THEN c182_inventoryval_net
        END AS stat_val,
        io.curr_cd,
        null as inv_stat_cnt,
        null as inv_stat_qty,
        null as inv_stat_pct,
        null as inv_stat_meas,
        null as uom_cd,
        'WAWI_WH' as source_system,
        current_date as extraction_dt,
        current_timestamp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI_WH' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
from etl.t_wawi_full_inventory inv
CROSS JOIN
(
    SELECT *
    FROM (Values 
        ('TURNOVER_NET'),
        ('DIFF_NET'),
        ('INVENTORY_NET')
    ) AS stat (inv_stat_type_cd)
) AS stat
LEFT OUTER JOIN CORE_REL.T_INTERNAL_ORGANIZATION IO
        ON  COUNTRY_ORG_SID = IO.INT_ORG_SID
        AND inv.extraction_tmsp BETWEEN IO.DWH_VALID_FROM_TMSP AND IO.DWH_VALID_TO_TMSP
;

