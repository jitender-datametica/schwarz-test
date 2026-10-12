UPDATE dbp_data.best_belegfluss_bnk_2 SET
    gp_id = t2.gp_id_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        best_beleg_id AS best_beleg_id_,
        CASE
            WHEN mandant_id = 1 AND (gp_id > 99999 AND gp_id < 1000000)
                THEN gp_id * 10
            ELSE gp_id
        END AS gp_id_
    FROM dbp_data.besch_best_2 AS BB
    WHERE (
        mandant_id, best_beleg_id) IN (
        SELECT (mandant_id, best_beleg_id)
        FROM ${TEMP_TABLE}
        WHERE gp_id = -1
        GROUP BY mandant_id,
        best_beleg_id
    )
    GROUP BY
        mandant_id_,
        best_beleg_id_,
        gp_id_
) AS t2
WHERE
    best_belegfluss_bnk.gp_id = -1 AND best_belegfluss_bnk.mandant_id = t2.mandant_id_ AND best_belegfluss_bnk.best_beleg_id
    = t2.best_beleg_id_;
