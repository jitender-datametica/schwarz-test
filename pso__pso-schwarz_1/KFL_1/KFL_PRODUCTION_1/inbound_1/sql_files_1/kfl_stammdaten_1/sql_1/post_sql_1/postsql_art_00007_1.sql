--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.art_1 
SET
     mutter_vk_id   = NULL

FROM
(SELECT
     art_id                    as _art_id
    ,mandant_id                as _mandant_id
    
FROM DBP_DATA.art_1

WHERE (mandant_id, art_id) NOT IN (SELECT mandant_id, art_id FROM ${TEMP_TABLE} /*DBP_ETL.art_temp*/)
AND dat_bis > CURRENT_DATE
) t1_1
 WHERE  art_id       = _art_id
   AND mandant_id   = _mandant_id
;

