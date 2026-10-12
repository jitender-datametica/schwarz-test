--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_leistung
WHERE art_id IN (
    SELECT art_id
    FROM dbp_data.sortiment_leistung
    WHERE
        art_id IS NOT NULL
        AND mandant_id = 1
        AND kjmo IN (
            SELECT MIN(B.kjmo) AS kjmo
            FROM (
                SELECT MAX(kjwo) AS kjwo
                FROM dbp_data.art_nielsen_fakten_kjwo
                WHERE mandant_id = 1
            ) AS a
            INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
        )
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
    GROUP BY art_id
    HAVING COUNT(*) > 1) AND kjmo IN (
    SELECT MIN(B0.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B0 ON a.kjwo = B0.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
) AND gtin IS NOT NULL;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_leistung
WHERE matching_id IN (
    SELECT matching_id
    FROM dbp_data.sortiment_leistung
    WHERE
        kjmo IN (
            SELECT MIN(B.kjmo) AS kjmo
            FROM (
                SELECT MAX(kjwo) AS kjwo
                FROM dbp_data.art_nielsen_fakten_kjwo
                WHERE mandant_id = 1
            ) AS a
            INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
        )
        AND mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
    GROUP BY matching_id
    HAVING COUNT(*) > 1) AND kjmo IN (
    SELECT MIN(B0.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B0 ON a.kjwo = B0.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
) AND gtin IS NOT NULL;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_leistung
WHERE art_id IN (
    SELECT art_id
    FROM dbp_data.sortiment_leistung
    WHERE
        art_id IS NOT NULL
        AND mandant_id = 1
        AND kjmo IN (
            SELECT MIN(B.kjmo) AS kjmo
            FROM (
                SELECT MAX(kjwo) AS kjwo
                FROM dbp_data.art_nielsen_fakten_kjwo
                WHERE mandant_id = 1
            ) AS a
            INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
        )
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
    GROUP BY art_id
    HAVING COUNT(*) > 1) AND kjmo IN (
    SELECT MIN(B0.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B0 ON a.kjwo = B0.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.sortiment_leistung
WHERE matching_id IN (
    SELECT matching_id
    FROM dbp_data.sortiment_leistung
    WHERE
        kjmo IN (
            SELECT MIN(B.kjmo) AS kjmo
            FROM (
                SELECT MAX(kjwo) AS kjwo
                FROM dbp_data.art_nielsen_fakten_kjwo
                WHERE mandant_id = 1
            ) AS a
            INNER JOIN dbp_data.tag AS B ON a.kjwo = B.kjwo
        )
        AND mandant_id = 1
        AND kjwo_update IN (
            SELECT MAX(kjwo_update) AS kjwo_update
            FROM dbp_data.art_kl_preislage_zu_per
            WHERE mandant_id = 1
        )
    GROUP BY matching_id
    HAVING COUNT(*) > 1) AND kjmo IN (
    SELECT MIN(B0.kjmo) AS kjmo
    FROM (
        SELECT MAX(kjwo) AS kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
    ) AS a
    INNER JOIN dbp_data.tag AS B0 ON a.kjwo = B0.kjwo
)
AND mandant_id = 1
AND kjwo_update IN (
    SELECT MAX(kjwo_update) AS kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = 1
);
