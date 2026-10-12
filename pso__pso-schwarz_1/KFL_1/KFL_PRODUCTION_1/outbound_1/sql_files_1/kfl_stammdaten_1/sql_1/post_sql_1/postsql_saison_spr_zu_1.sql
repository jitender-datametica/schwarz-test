UPDATE dbp_data.saison_spr_zu_1 SET
    saison_bez = s.ro_saison_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.saison_id,
        A.spr_id,
        B.saison_bez AS ro_saison_bez
    FROM dbp_data.saison_spr_zu_1 AS A
    INNER JOIN
        dbp_data.saison_spr_zu_1 AS B
        ON A.saison_id = B.saison_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.saison_bez <> B.saison_bez
    GROUP BY
        A.saison_id,
        A.spr_id,
        ro_saison_bez
) AS s
WHERE
    saison_spr_zu.mandant_id = 4
    AND saison_spr_zu.saison_id = s.saison_id
    AND saison_spr_zu.spr_id = s.spr_id
    AND saison_spr_zu.saison_bez <> s.ro_saison_bez;
