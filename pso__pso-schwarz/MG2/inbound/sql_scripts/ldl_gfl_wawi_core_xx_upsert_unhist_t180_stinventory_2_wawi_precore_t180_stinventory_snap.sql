
INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
        ctrcode,
        wh_nr,
        c180_id,
        c180_whnr,
        c180_storenr,
        c180_inventorygrp,
        c180_status,
        c180_inventorydate,
        c180_importdate,
        c180_postingdate,
        c180_inventoryval,
        c180_inv_flag,
        c180_inventoryval_net,
        c180_idvalue,
        scn,
        extraction_tmsp,

        source_system,
        extraction_dt,
        dwh_mapping_tmsp,
        tf_error_fg,
        deleted_fg,
        record_id,
        filename,
        dwh_node_cd,
        dwh_load_id
)
SELECT
        case 
            when ctrcode = 'CS' then 'ES'
            when ctrcode = 'NIE' then 'NI'
            else ctrcode
        end as ctrcode_converted,
        wh_nr,
        c180_id,
        c180_whnr,
        c180_storenr,
        c180_inventorygrp,
        c180_status,
        c180_inventorydate,
        c180_importdate,
        c180_postingdate,
        c180_inventoryval,
        c180_inv_flag,
        c180_inventoryval_net,
        c180_idvalue,
        scn,
        extraction_tmsp,

        'wawi' as source_system,
        current_date as extraction_dt,
        current_timestamp as dwh_mapping_tmsp,
        0 as tf_error_fg,
        0 as deleted_fg,
        0 as record_id,
        't_${SRC_INPUT_TABLE}' as filename,
        'WAWI' as dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} SRC
INNER JOIN ETL.WAWI_CONTROL_TABLE CTRL
         ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
        AND Ctrl.source_status = 'A'
        AND Src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY row_number() OVER (PARTITION BY ctrcode_converted,wh_nr,c180_id ORDER BY src.extraction_tmsp DESC ) = 1
;
