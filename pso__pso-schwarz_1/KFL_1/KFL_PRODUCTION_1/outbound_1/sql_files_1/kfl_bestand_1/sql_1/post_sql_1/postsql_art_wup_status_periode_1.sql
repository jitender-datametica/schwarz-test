CREATE TEMPORARY TABLE IF NOT EXISTS _mist AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    gjmo,
    gjmo_bis,
    CAST(gjmo_bis * 100 + 1 AS BIGNUMERIC) AS gjmo_bis_dat
FROM dbp_data.art_wup_status_periode_1
WHERE (
    mandant_id, art_id, wup_id) IN (
    SELECT (mandant_id, art_id, wup_id)
    FROM ${TEMP_TABLE}
)
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    gjmo,
    gjmo_bis,
    gjmo_bis_dat;


UPDATE dbp_data.art_wup_status_periode_1 SET
    gjmo = CAST(d.gjmo_ab_ AS INTEGER) FROM (SELECT
    mandant_id,
    art_id,
    wup_id,
    gjmo,
    gjmo_bis,
    gjmo_bis_dat,
    (SUM(gjmo_bis_dat) OVER (
        PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    )) - gjmo_bis_dat AS test_1,
    CASE
        WHEN (SUM(gjmo_bis_dat) OVER (
            PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - gjmo_bis_dat = 0
            THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
        ELSE NULL
    END AS test2,
    CASE
        WHEN (SUM(gjmo_bis_dat) OVER (
            PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - gjmo_bis_dat <> 0
            THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                mandant_id, art_id, wup_id ORDER BY
                gjmo_bis_dat
                IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat
            ) OVER (
                PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1
                PRECEDING AND CURRENT ROW
            )) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat
            ) OVER (
                PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1
                PRECEDING AND CURRENT ROW
            )) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat
            ) OVER (
                PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1
                PRECEDING AND CURRENT ROW
            )) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH))
        ELSE NULL
    END AS test3,
    CASE
        WHEN (SUM(gjmo_bis_dat) OVER (
            PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - gjmo_bis_dat = 0
            THEN CAST(CASE
                WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
                    THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
                ELSE NULL
            END AS STRING)
        ELSE CAST(CASE
            WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat <> 0
                THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                    mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id
                ORDER BY
                    gjmo_bis_dat IS NULL, gjmo_bis_dat
                ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((
                    SUM(gjmo_bis_dat) OVER (
                        PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND
                        CURRENT ROW
                    )
                ) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (
                    PARTITION BY mandant_id, art_id, wup_id
                    ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                )) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH))
            ELSE NULL
        END AS STRING)
    END AS dat_ab,
    SUBSTR(CASE
        WHEN (SUM(gjmo_bis_dat) OVER (
            PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - gjmo_bis_dat = 0
            THEN CAST(CASE
                WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
                    THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
                ELSE NULL
            END AS STRING)
        ELSE CAST(CASE
            WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat <> 0
                THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                    mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id
                ORDER BY
                    gjmo_bis_dat IS NULL, gjmo_bis_dat
                ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((
                    SUM(gjmo_bis_dat) OVER (
                        PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING
                        AND CURRENT ROW
                    )
                ) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (
                    PARTITION BY mandant_id, art_id, wup_id
                    ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                )) - gjmo_bis_dat as STRING)), INTERVAL 1
                MONTH))
            ELSE NULL
        END AS STRING)
    END, 1, 4) || SUBSTR(CASE
        WHEN (SUM(gjmo_bis_dat) OVER (
            PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
        )) - gjmo_bis_dat = 0
            THEN CAST(CASE
                WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
                    THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
                ELSE NULL
            END AS STRING)
        ELSE CAST(CASE
            WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat <> 0
                THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                    mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id
                ORDER BY
                    gjmo_bis_dat IS NULL, gjmo_bis_dat
                ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((
                    SUM(gjmo_bis_dat) OVER (
                        PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING
                        AND CURRENT ROW
                    )
                ) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (
                    PARTITION BY mandant_id, art_id, wup_id
                    ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
                    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                )) - gjmo_bis_dat as STRING)), INTERVAL 1
                MONTH))
            ELSE NULL
        END AS STRING)
    END, 6, 2) AS gjmo_ab_
FROM `_mist`
QUALIFY gjmo <> CAST(SUBSTR(CASE
    WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
        THEN CAST(CASE
            WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
                THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
            ELSE NULL
        END AS STRING)
    ELSE CAST(CASE
        WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat <> 0
            THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                mandant_id, art_id,
                wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (
                PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1
                PRECEDING AND CURRENT ROW
            )) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id
            ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)),
            INTERVAL 1 MONTH))
        ELSE NULL
    END AS STRING)
END, 1, 4) || SUBSTR(CASE
    WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY
        mandant_id, art_id, wup_id ORDER BY
        gjmo_bis_dat IS NULL,
        gjmo_bis_dat
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
        THEN CAST(CASE
            WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat = 0
                THEN DATE(CAST(gjmo * 100 + 1 AS STRING))
            ELSE NULL
        END AS STRING)
    ELSE CAST(CASE
        WHEN (SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat <> 0
            THEN IF(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)) = LAST_DAY(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY
                mandant_id, art_id,
                wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING))), LAST_DAY(DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (
                PARTITION BY mandant_id, art_id, wup_id ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat ROWS BETWEEN 1
                PRECEDING AND CURRENT ROW
            )) - gjmo_bis_dat as STRING)), INTERVAL 1 MONTH)), DATE_ADD(DATE(CAST((SUM(gjmo_bis_dat) OVER (PARTITION BY mandant_id, art_id, wup_id
            ORDER BY gjmo_bis_dat IS NULL, gjmo_bis_dat
            ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - gjmo_bis_dat as STRING)),
            INTERVAL 1 MONTH))
        ELSE NULL
    END AS STRING)
END, 6, 2) AS FLOAT64)) AS d
WHERE
    art_wup_status_periode.mandant_id = d.mandant_id AND art_wup_status_periode.art_id = d.art_id AND
    art_wup_status_periode.wup_id = d.wup_id AND art_wup_status_periode.gjmo_bis = d.gjmo_bis AND art_wup_status_periode.gjmo <> CAST(d.gjmo_ab_ AS FLOAT64);


UPDATE dbp_data.art_wup_status_periode_1 SET
    vk_brutto = a.vk_brutto_ FROM (
    SELECT
        T2.mandant_id AS mandant_id_,
        T2.art_id AS art_id_,
        T2.wup_id AS wup_id_,
        T1.vk_brutto AS vk_brutto_,
        T2.gjmo_bis AS gjmo_bis_
    FROM dbp_data.art_wup_zu_per_1 AS T1_1
    INNER JOIN
        ${TEMP_TABLE}
            AS T2
        ON
            T1.mandant_id
            = T2.mandant_id AND T1.art_id = T2.art_id AND T1.wup_id = T2.wup_id AND PARSE_DATE('%Y%m', CAST(T2.gjmo_bis AS STRING)
            ) BETWEEN T1.dat_von AND T1.dat_bis
) AS a
WHERE
    art_wup_status_periode.mandant_id = a.mandant_id_ AND art_wup_status_periode.art_id = a.art_id_ AND
    art_wup_status_periode.wup_id = a.wup_id_ AND art_wup_status_periode.gjmo_bis = a.gjmo_bis_;
