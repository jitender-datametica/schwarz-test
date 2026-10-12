UPDATE dbp_data.versandstelle_spr_zu_2 SET
    versandstelle_bez = s.ro_versandstelle_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.versandstelle_id,
        A.spr_id,
        B.versandstelle_bez AS ro_versandstelle_bez
    FROM dbp_data.versandstelle_spr_zu_2 AS A
    INNER JOIN dbp_data.versandstelle_spr_zu_2 AS B
        ON
            A.versandstelle_id = B.versandstelle_id AND A.spr_id
            = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.versandstelle_bez <> B.versandstelle_bez
    GROUP BY
        A.versandstelle_id,
        A.spr_id,
        ro_versandstelle_bez
) AS s
WHERE
    versandstelle_spr_zu.mandant_id = 4
    AND versandstelle_spr_zu.versandstelle_id = s.versandstelle_id
    AND versandstelle_spr_zu.spr_id = s.spr_id AND versandstelle_spr_zu.versandstelle_bez <> s.ro_versandstelle_bez;
