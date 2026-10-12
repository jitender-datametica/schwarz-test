/* dbp_etl.artikelart_spr_zu_temp */ INSERT INTO dbp_data.artikelart_spr_zu (
    mandant_id, artikelart_id,
    spr_id, artikelart_bez
)
(SELECT
    mandant_id,
    artikelart_id,
    22 AS spr_id,
    artikelart_bez
FROM ${TEMP_TABLE} AS T1
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.artikelart_spr_zu AS T2
    WHERE
        T1.artikelart_id = artikelart_id
        AND T1.mandant_id = mandant_id
        AND T1.spr_id = spr_id
));


/* dbp_etl.artikelart_spr_zu_temp */ INSERT INTO dbp_data.artikelart_spr_zu (
    mandant_id, artikelart_id,
    spr_id, artikelart_bez
)
(SELECT
    mandant_id,
    artikelart_id,
    22 AS spr_id,
    artikelart_bez
FROM ${TEMP_TABLE} AS T1
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.artikelart_spr_zu AS T2
    WHERE
        T1.artikelart_id = artikelart_id
        AND T1.mandant_id = mandant_id
        AND T1.spr_id = spr_id
));


UPDATE dbp_data.artikelart_spr_zu SET
    artikelart_bez = s.ro_artikelart_bez FROM (
    SELECT
        A.artikelart_id,
        A.spr_id,
        B.artikelart_bez AS ro_artikelart_bez
    FROM dbp_data.artikelart_spr_zu AS A
    INNER JOIN dbp_data.artikelart_spr_zu AS B ON A.artikelart_id = B.artikelart_id AND A.spr_id = B.spr_id

    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.artikelart_bez <> B.artikelart_bez
    GROUP BY
        A.artikelart_id,
        A.spr_id,
        ro_artikelart_bez
) AS s
WHERE
    artikelart_spr_zu.mandant_id = 4 AND artikelart_spr_zu.artikelart_id = s.artikelart_id AND artikelart_spr_zu.spr_id
    = s.spr_id;
