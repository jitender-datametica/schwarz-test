CREATE OR REPLACE TEMPORARY TABLE _track01 AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    a.art_id,
    B.mutter_wb_id,
    B.mutter_vk_id,
    c.mutter_ek_id,
    a.status
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        art_id,
        MAX(status) AS status
    FROM dbp_etl.art_matching_nielsen_per
    WHERE art_id <> -1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS a
LEFT JOIN dbp_data.art AS B ON a.mandant_id = B.mandant_id AND a.art_id = B.art_id
LEFT JOIN (
    SELECT
        mandant_id,
        art_id,
        mutter_ek_id
    FROM dbp_data.art_gp_zu_per
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND mandant_id = 1
) AS c ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id
WHERE a.art_id IS NOT NULL;


DELETE FROM `_track01`
WHERE (
    mandant_id, art_matching_id) IN (
    SELECT (mandant_id, matching_id)
    FROM dbp_data.sortiment_leistung
    WHERE
        art_id > 0
        AND mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
        AND LENGTH(kl_art_id) - LENGTH(TRANSLATE(kl_art_id, ',', '')) + 1 = 1
) AND status IN ('G', 'T'
) AND (
    mandant_id,
    art_matching_id, art_id) NOT IN (
    SELECT (mandant_id, matching_id, art_id)
    FROM dbp_data.sortiment_leistung
    WHERE
        art_id > 0
        AND mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS a1290333724
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
        AND LENGTH(kl_art_id) - LENGTH(TRANSLATE(kl_art_id, ',', '')) + 1 = 1
);


CREATE OR REPLACE TEMPORARY TABLE _track02 AS
SELECT
    mandant_id,
    art_matching_id,
    SUM(CASE
        WHEN mutter_wb_id IS NOT NULL AND mutter_wb_id <> art_id
            THEN 1
        ELSE 0
    END) AS anz_kind_wb,
    SUM(CASE
        WHEN mutter_vk_id IS NOT NULL AND mutter_vk_id <> art_id
            THEN 1
        ELSE 0
    END) AS anz_kind_vk,
    SUM(CASE
        WHEN mutter_ek_id IS NOT NULL AND mutter_ek_id <> art_id
            THEN 1
        ELSE 0
    END) AS anz_kind_ek,
    COUNT(*) AS anzahl_artikel,
    SUM(CASE
        WHEN mutter_wb_id = art_id
            THEN 1
        ELSE 0
    END) AS anz_mutter_wb,
    SUM(CASE
        WHEN mutter_vk_id = art_id
            THEN 1
        ELSE 0
    END) AS anz_mutter_vk,
    SUM(CASE
        WHEN mutter_ek_id = art_id
            THEN 1
        ELSE 0
    END) AS anz_mutter_ek,
    SUM(CASE
        WHEN mutter_wb_id IS NULL
            THEN 1
        ELSE 0
    END) AS anz_waise_wb,
    SUM(CASE
        WHEN mutter_vk_id IS NULL
            THEN 1
        ELSE 0
    END) AS anz_waise_vk,
    SUM(CASE
        WHEN mutter_ek_id IS NULL
            THEN 1
        ELSE 0
    END) AS anz_waise_ek
FROM `_track01`
GROUP BY
    mandant_id,
    art_matching_id;


UPDATE dbp_data.sortiment_leistung SET
    muki_wb_kz = b.muki_wb_kz,
    muki_vk_kz = b.muki_vk_kz,
    muki_ek_kz = b.muki_ek_kz FROM (
    SELECT
        mandant_id,
        art_matching_id,
        CASE
            WHEN anz_kind_wb = 0 AND anz_mutter_wb = 0 AND anz_waise_wb > 0
                THEN 'W'
            WHEN anz_kind_wb = 0 AND anz_mutter_wb > 0 AND anz_waise_wb = 0
                THEN 'M'
            WHEN anz_kind_wb > 0 AND anz_mutter_wb = 0 AND anz_waise_wb = 0
                THEN 'K'
            WHEN anz_kind_wb > 0 AND anz_mutter_wb > 0 AND anz_waise_wb = 0
                THEN 'M/K'
            WHEN anz_kind_wb > 0 AND anz_mutter_wb = 0 AND anz_waise_wb > 0
                THEN 'K/W'
            WHEN anz_kind_wb = 0 AND anz_mutter_wb > 0 AND anz_waise_wb > 0
                THEN 'M/W'
            WHEN anz_kind_wb > 0 AND anz_mutter_wb > 0 AND anz_waise_wb > 0
                THEN 'M/K/W'
            ELSE NULL
        END AS muki_wb_kz,
        CASE
            WHEN anz_kind_vk = 0 AND anz_mutter_vk = 0 AND anz_waise_vk > 0
                THEN 'W'
            WHEN anz_kind_vk = 0 AND anz_mutter_vk > 0 AND anz_waise_vk = 0
                THEN 'M'
            WHEN anz_kind_vk > 0 AND anz_mutter_vk = 0 AND anz_waise_vk = 0
                THEN 'K'
            WHEN anz_kind_vk > 0 AND anz_mutter_vk > 0 AND anz_waise_vk = 0
                THEN 'M/K'
            WHEN anz_kind_vk > 0 AND anz_mutter_vk = 0 AND anz_waise_vk > 0
                THEN 'K/W'
            WHEN anz_kind_vk = 0 AND anz_mutter_vk > 0 AND anz_waise_vk > 0
                THEN 'M/W'
            WHEN anz_kind_vk > 0 AND anz_mutter_vk > 0 AND anz_waise_vk > 0
                THEN 'M/K/W'
            ELSE NULL
        END AS muki_vk_kz,
        CASE
            WHEN anz_kind_ek = 0 AND anz_mutter_ek = 0 AND anz_waise_ek > 0
                THEN 'W'
            WHEN anz_kind_ek = 0 AND anz_mutter_ek > 0 AND anz_waise_ek = 0
                THEN 'M'
            WHEN anz_kind_ek > 0 AND anz_mutter_ek = 0 AND anz_waise_ek = 0
                THEN 'K'
            WHEN anz_kind_ek > 0 AND anz_mutter_ek > 0 AND anz_waise_ek = 0
                THEN 'M/K'
            WHEN anz_kind_ek > 0 AND anz_mutter_ek = 0 AND anz_waise_ek > 0
                THEN 'K/W'
            WHEN anz_kind_ek = 0 AND anz_mutter_ek > 0 AND anz_waise_ek > 0
                THEN 'M/W'
            WHEN anz_kind_ek > 0 AND anz_mutter_ek > 0 AND anz_waise_ek > 0
                THEN 'M/K/W'
            ELSE NULL
        END AS muki_ek_kz
    FROM `_track02`
    GROUP BY
        mandant_id,
        art_matching_id,
        muki_wb_kz,
        muki_vk_kz,
        muki_ek_kz
) AS b
WHERE
    sortiment_leistung.mandant_id = b.mandant_id AND sortiment_leistung.matching_id = b.art_matching_id AND
    sortiment_leistung.kjwo_update IN (
        SELECT MAX(kjwo_update) AS a1290333724
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = 1
    ) AND sortiment_leistung.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _track03 AS
SELECT
    mandant_id,
    art_matching_id,
    CASE
        WHEN mutter_wb_id = art_id
            THEN mutter_wb_id
        ELSE NULL
    END AS mutter_wb_id,
    CASE
        WHEN mutter_vk_id = art_id
            THEN mutter_vk_id
        ELSE NULL
    END AS mutter_vk_id,
    CASE
        WHEN mutter_ek_id = art_id
            THEN mutter_ek_id
        ELSE NULL
    END AS mutter_ek_id
FROM `_track01`
WHERE
    mutter_wb_id IS NOT NULL
    OR mutter_vk_id IS NOT NULL
    OR mutter_ek_id IS NOT NULL
GROUP BY
    mandant_id,
    art_matching_id,
    mutter_wb_id,
    mutter_vk_id,
    mutter_ek_id;


DELETE FROM `_track03`
WHERE mutter_wb_id IS NULL AND mutter_vk_id IS NULL AND mutter_ek_id IS NULL;

--pe_review below 3 updates statement


UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_wb_kl_art_id_verkettung = b.mutter_wb_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(mutter_wb_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY mutter_wb_id), ','), ' ', '') AS mutter_wb_id
    FROM `_track03`
    WHERE mutter_wb_id IS NOT NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.matching_id = b.art_matching_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;

UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_vk_kl_art_id_verkettung = b.mutter_vk_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(mutter_vk_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY mutter_vk_id), ','), ' ', '') AS mutter_vk_id
    FROM `_track03`
    WHERE mutter_vk_id IS NOT NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.matching_id = b.art_matching_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;

UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_ek_kl_art_id_verkettung = b.mutter_ek_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(mutter_ek_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY mutter_ek_id), ','), ' ', '') AS mutter_ek_id
    FROM `_track03`
    WHERE mutter_ek_id IS NOT NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.matching_id = b.art_matching_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _upd_wb AS
SELECT *
FROM dbp_data.art
WHERE
    mutter_wb_id IS NOT NULL
    AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _upd_vk AS
SELECT *
FROM dbp_data.art
WHERE
    mutter_vk_id IS NOT NULL
    AND mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _upd_ek AS
SELECT *
FROM dbp_data.art_gp_zu_per
WHERE
    mutter_ek_id IS NOT NULL
    AND mandant_id = 1
    AND dat_bis = PARSE_DATE('%F', '9999-12-31');

--pe_review below 3 updates statement

UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_wb_kl_art_id_verkettung = b.mutter_wb_id
FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        SUBSTR(REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(u.mutter_wb_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY u.mutter_wb_id), ','), ' ', ''), 1, 300) AS mutter_wb_id
    FROM `dbp_data.sortiment_leistung` AS a
    JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `dbp_etl.art_matching_nielsen_per`
        GROUP BY 1, 2, 3
    ) AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.matching_id = x.art_matching_id
    JOIN `._upd_wb` AS u
        ON
            a.mandant_id = u.mandant_id
            AND x.art_id = u.art_id
    WHERE
        a.mandant_id = 1
        AND a.kjwo_update IN (
            SELECT MAX(kjwo_update)
            FROM `dbp_data.art_kl_preislage_zu_per`
            WHERE mandant_id = 1
        )
        AND a.muki_wb_kl_art_id_verkettung IS NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.art_id = b.art_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;


UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_vk_kl_art_id_verkettung = b.mutter_vk_id
FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        SUBSTR(
            REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(u.mutter_vk_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY u.mutter_vk_id), ','), ' ', ''), 1, 300
        ) AS mutter_vk_id
    FROM `dbp_data.sortiment_leistung` AS a
    JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `dbp_etl.art_matching_nielsen_per`
        GROUP BY 1, 2, 3
    ) AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.matching_id = x.art_matching_id
    JOIN `_upd_vk` AS u
        ON
            a.mandant_id = u.mandant_id
            AND x.art_id = u.art_id
    WHERE
        a.mandant_id = 1
        AND a.kjwo_update IN (
            SELECT MAX(kjwo_update)
            FROM `dbp_data.art_kl_preislage_zu_per`
            WHERE mandant_id = 1
        )
        AND a.muki_vk_kl_art_id_verkettung IS NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.art_id = b.art_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;


UPDATE `dbp_data.sortiment_leistung` AS sl
SET sl.muki_ek_kl_art_id_verkettung = b.mutter_ek_id
FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        SUBSTR(
            REPLACE(TRIM(STRING_AGG(LPAD(CAST(CAST(LPAD(CAST(FLOOR(u.mutter_ek_id / 100) AS STRING), 8, '0') AS INT64) AS STRING), 8, '0'), ',' ORDER BY u.mutter_ek_id), ','), ' ', ''), 1, 300
        ) AS mutter_ek_id
    FROM `dbp_data.sortiment_leistung` AS a
    JOIN (
        SELECT
            mandant_id,
            art_matching_id,
            art_id
        FROM `dbp_etl.art_matching_nielsen_per`
        GROUP BY 1, 2, 3
    ) AS x
        ON
            a.mandant_id = x.mandant_id
            AND a.matching_id = x.art_matching_id
    JOIN `_upd_ek` AS u
        ON
            a.mandant_id = u.mandant_id
            AND x.art_id = u.art_id
    WHERE
        a.mandant_id = 1
        AND a.kjwo_update IN (
            SELECT MAX(kjwo_update)
            FROM `dbp_data.art_kl_preislage_zu_per`
            WHERE mandant_id = 1
        )
        AND a.muki_ek_kl_art_id_verkettung IS NULL
    GROUP BY 1, 2
) AS b
WHERE
    sl.mandant_id = b.mandant_id
    AND sl.art_id = b.art_id
    AND sl.kjwo_update IN (
        SELECT MAX(kjwo_update)
        FROM `dbp_data.art_kl_preislage_zu_per`
        WHERE mandant_id = 1
    )
    AND sl.mandant_id = 1;
