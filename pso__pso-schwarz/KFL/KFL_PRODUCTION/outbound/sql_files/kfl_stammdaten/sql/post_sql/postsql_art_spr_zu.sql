UPDATE dbp_data.art_spr_zu SET
    art_bez = s.ro_art_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.art_id,
        A.spr_id,
        B.art_bez AS ro_art_bez
    FROM dbp_data.art_spr_zu AS A
    INNER JOIN
        dbp_data.art_spr_zu AS B
        ON A.art_id = B.art_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.art_bez <> B.art_bez
    GROUP BY
        A.art_id,
        A.spr_id,
        ro_art_bez
) AS s
WHERE
    art_spr_zu.mandant_id = 4
    AND art_spr_zu.art_id = s.art_id
    AND art_spr_zu.spr_id = s.spr_id
    AND art_spr_zu.art_bez
    <> s.ro_art_bez;
