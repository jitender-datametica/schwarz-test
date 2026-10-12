--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* dbp_etl.art_sm_vw_zu_per_temp */ INSERT INTO dbp_data.l_ksm_2 (mandant_id, ksm_id)
(
    SELECT
        mandant_id,
        ksm_id
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        NOT EXISTS (
            SELECT *
            FROM dbp_data.l_ksm_2 AS T2
            WHERE
                T1.mandant_id = mandant_id
                AND T1.ksm_id = ksm_id
        )
        AND ksm_id IS NOT NULL
    GROUP BY
        mandant_id,
        ksm_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* dbp_etl.art_sm_vw_zu_per_temp */ INSERT INTO dbp_data.ksm_spr_zu_2 (mandant_id, ksm_id, spr_id, ksm_bez
)
(
    SELECT
        mandant_id,
        ksm_id,
        22,
        ksm_id AS ksm_id3
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        NOT EXISTS (
            SELECT *
            FROM dbp_data.ksm_spr_zu_2 AS T2
            WHERE
                T1.mandant_id = mandant_id
                AND T1.ksm_id = ksm_id
                AND spr_id = 22
        )
        AND ksm_id IS NOT NULL
    GROUP BY
        mandant_id,
        ksm_id,
        3
);


/* SPEC0265291  UPDATE auf DE Records mit leeren ksm_id    */


UPDATE dbp_data.art_sm_vw_zu_per_2 SET
    ksm_id = SUBSTR(CAST(art_sm_vw_zu_per.sm_id AS STRING), 1, 4)
WHERE mandant_id = 1 AND (ksm_id IS NULL OR TRIM(ksm_id) = '');
