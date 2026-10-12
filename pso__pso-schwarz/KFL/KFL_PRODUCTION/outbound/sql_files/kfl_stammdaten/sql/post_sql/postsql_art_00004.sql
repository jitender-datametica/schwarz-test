--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.art AS art0 SET
    mutter_wb_id = dt.mutter_wb_id FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        CASE
            WHEN A.mutter_wb_id IS NULL AND b.mandant_id IS NOT NULL
                THEN A.art_id
            ELSE A.mutter_wb_id
        END AS mutter_wb_id
    FROM dbp_data.art AS A
    LEFT JOIN (
        SELECT
            mandant_id,
            mutter_wb_id
        FROM dbp_data.art
        WHERE mutter_wb_id IS NOT NULL
        GROUP BY
            mandant_id,
            mutter_wb_id
    ) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.mutter_wb_id
) AS dt
WHERE art0.mandant_id = dt.mandant_id AND art0.art_id = dt.art_id;
