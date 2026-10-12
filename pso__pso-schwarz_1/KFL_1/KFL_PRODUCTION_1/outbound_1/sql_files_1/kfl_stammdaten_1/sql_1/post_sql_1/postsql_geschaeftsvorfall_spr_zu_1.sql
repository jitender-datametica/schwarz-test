UPDATE dbp_data.geschaeftsvorfall_spr_zu_1 SET
    geschaeftsvorfall_bez = s.ro_geschaeftsvorfall_bez FROM (
    SELECT
        A.geschaeftsvorfall_id,
        A.spr_id,
        B.geschaeftsvorfall_bez AS ro_geschaeftsvorfall_bez
    FROM dbp_data.geschaeftsvorfall_spr_zu_1 AS A
    INNER JOIN dbp_data.geschaeftsvorfall_spr_zu_1 AS B
        ON
            A.geschaeftsvorfall_id = B.geschaeftsvorfall_id
            AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.geschaeftsvorfall_bez <> B.geschaeftsvorfall_bez
    GROUP BY
        A.geschaeftsvorfall_id,
        A.spr_id,
        ro_geschaeftsvorfall_bez
) AS s
WHERE
    geschaeftsvorfall_spr_zu.mandant_id = 4
    AND geschaeftsvorfall_spr_zu.geschaeftsvorfall_id = s.geschaeftsvorfall_id
    AND geschaeftsvorfall_spr_zu.spr_id = s.spr_id;
