--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.art 
SET
     mutter_wb_id   = NULL
FROM
(SELECT
     art_id                    as _art_id
    ,mandant_id                as _mandant_id  
FROM DBP_DATA.art
WHERE mandant_id=1 and (mandant_id, art_id) not in
(Select mandant_id, art_id FROM ${TEMP_TABLE} /*dbp_etl.art_temp*/)
) t1
 WHERE  art_id       = _art_id
   AND mandant_id   = _mandant_id
;

