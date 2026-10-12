DELETE FROM ${TEMP_TABLE}
WHERE wug_id = -1;


DELETE FROM dbp_data.wug_spr_zu_1
WHERE (
    wg_id, wug_id, spr_id, mandant_id, arthiertyp_id) IN (
    SELECT (wg_id, wug_id, spr_id, mandant_id, arthiertyp_id)
    FROM ${TEMP_TABLE}
    WHERE wug_bez <> 'system generated'
);


/* DBP_ETL.wug_spr_zu_temp_1 */ INSERT INTO dbp_data.wug_spr_zu_1 (
    arthiertyp_id, mandant_id,
    wg_id, spr_id, wug_id, wug_bez
)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE}
WHERE (wg_id, wug_id, spr_id, mandant_id, arthiertyp_id) NOT IN (SELECT (
    wg_id, wug_id, spr_id, mandant_id,
    arthiertyp_id
)
FROM dbp_data.wug_spr_zu_1));


DELETE FROM ${TEMP_TABLE}
WHERE wug_id = -1;


DELETE FROM dbp_data.wug_spr_zu_1
WHERE (
    wg_id, wug_id, spr_id, mandant_id, arthiertyp_id) IN (
    SELECT (wg_id, wug_id, spr_id, mandant_id, arthiertyp_id)
    FROM ${TEMP_TABLE}
    WHERE wug_bez <> 'system generated'
);


INSERT INTO dbp_data.wug_spr_zu_1 (arthiertyp_id, mandant_id, wg_id, spr_id, wug_id, wug_bez)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE}
WHERE (wg_id, wug_id, spr_id, mandant_id, arthiertyp_id) NOT IN (SELECT (
    wg_id, wug_id, spr_id, mandant_id,
    arthiertyp_id
)
FROM dbp_data.wug_spr_zu_1));


DELETE FROM dbp_data.wug_spr_zu_1
WHERE wug_id = -9;


UPDATE dbp_data.wug_spr_zu_1 SET
    wug_bez = s.ro_wug_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.wg_id,
        A.wug_id,
        A.arthiertyp_id,
        A.spr_id,
        B.wug_bez AS ro_wug_bez
    FROM dbp_data.wug_spr_zu_1 AS A
    INNER JOIN dbp_data.wug_spr_zu_1 AS B
        ON
            A.wg_id = B.wg_id AND A.wug_id = B.wug_id AND A.arthiertyp_id =
            B.arthiertyp_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.wug_bez <> B.wug_bez
    GROUP BY
        A.wg_id,
        A.wug_id,
        A.arthiertyp_id,
        A.spr_id,
        ro_wug_bez
) AS s
WHERE
    wug_spr_zu.mandant_id = 4 AND wug_spr_zu.wg_id = s.wg_id AND wug_spr_zu.wug_id = s.wug_id AND wug_spr_zu.arthiertyp_id
    = s.arthiertyp_id AND wug_spr_zu.spr_id = s.spr_id AND wug_spr_zu.wug_bez <> s.ro_wug_bez;
