--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    verpart_id0 AS verpart_id
FROM (
    SELECT
        mandant_id,
        TRIM(verpart_id) AS verpart_id0,
        verpart_id
    FROM dbp_data.artkz_verpart_2
    ORDER BY
        mandant_id NULLS LAST,
        verpart_id NULLS LAST
) AS t0;
