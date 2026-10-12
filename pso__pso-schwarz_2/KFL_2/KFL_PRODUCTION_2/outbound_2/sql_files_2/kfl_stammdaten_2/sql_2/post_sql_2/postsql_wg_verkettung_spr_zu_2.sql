UPDATE dbp_data.wg_verkettung_spr_zu_2 SET
    wg_verkett_bez = s.ro_wg_verkett_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.wg_verkett_id,
        A.spr_id,
        B.wg_verkett_bez AS ro_wg_verkett_bez
    FROM dbp_data.wg_verkettung_spr_zu_2 AS A
    INNER JOIN
        dbp_data.wg_verkettung_spr_zu_2 AS B
        ON A.wg_verkett_id = B.wg_verkett_id AND A.spr_id = B.spr_id

    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.wg_verkett_bez <> B.wg_verkett_bez
    GROUP BY
        A.wg_verkett_id,
        A.spr_id,
        ro_wg_verkett_bez
) AS s
WHERE
    wg_verkettung_spr_zu.mandant_id = 4
    AND wg_verkettung_spr_zu.wg_verkett_id = s.wg_verkett_id
    AND wg_verkettung_spr_zu.spr_id = s.spr_id AND wg_verkettung_spr_zu.wg_verkett_bez <> s.ro_wg_verkett_bez;
