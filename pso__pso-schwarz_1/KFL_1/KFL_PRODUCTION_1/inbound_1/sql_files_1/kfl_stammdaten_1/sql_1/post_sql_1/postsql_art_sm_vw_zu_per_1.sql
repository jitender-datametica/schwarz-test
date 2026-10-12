--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_ksm_1
(    mandant_id
    ,ksm_id
)
SELECT
     mandant_id
    ,ksm_id
FROM ${TEMP_TABLE}/*dbp_etl.art_sm_vw_zu_per_temp*/ t1_1
WHERE NOT EXISTS (SELECT * FROM DBP_DATA.l_ksm_1 t2
WHERE
     t1.mandant_id                = t2.mandant_id
   AND t1.ksm_id                    = t2.ksm_id
)
and ksm_id is not null
GROUP BY 1,2;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.ksm_spr_zu_1
(    mandant_id
    ,ksm_id
    ,spr_id 
    ,ksm_bez
)
SELECT
     mandant_id
    ,ksm_id
    ,22
    ,ksm_id
FROM ${TEMP_TABLE}/*dbp_etl.art_sm_vw_zu_per_temp*/ t1_1
WHERE NOT EXISTS (SELECT * FROM DBP_DATA.ksm_spr_zu_1 t2
WHERE
     t1.mandant_id                = t2.mandant_id
   AND t1.ksm_id                  = t2.ksm_id
   AND t2.spr_id                  = 22
)
and ksm_id is not null
GROUP BY 1,2,3,4;

/* SPEC0265291  UPDATE auf DE Records mit leeren ksm_id    */
UPDATE dbp_data.art_sm_vw_zu_per_1
   SET ksm_id = sm_id
 WHERE mandant_id = 1
   AND (ksm_id IS NULL or TRIM(ksm_id) ='')
;


