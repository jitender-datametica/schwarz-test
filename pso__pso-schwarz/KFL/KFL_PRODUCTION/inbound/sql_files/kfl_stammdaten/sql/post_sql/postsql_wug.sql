--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.wug (wug_id
                                       ,wg_id
                                       ,arthiertyp_id
                                       ,mandant_id)
SELECT wug_id
      ,wg_id
      ,arthiertyp_id
      ,mandant_id
FROM ${TEMP_TABLE} /*DBP_ETL.wug_temp*/ t1
WHERE NOT EXISTS (SELECT * FROM DBP_DATA.wug t2
                  WHERE t1.wug_id                    = t2.wug_id
                    AND t1.wg_id                     = t2.wg_id
                    AND t1.arthiertyp_id             = t2.arthiertyp_id
                    AND t1.mandant_id                = t2.mandant_id)
;

delete from dbp_data.wug
where wug_id = -9
;
