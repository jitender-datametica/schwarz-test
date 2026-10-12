UPDATE dbp_data.lief_typ_spr_zu_2 SET
    lief_typ_bez = s.ro_lief_typ_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.lief_typ_id,
        A.spr_id,
        B.lief_typ_bez AS ro_lief_typ_bez
    FROM dbp_data.lief_typ_spr_zu_2 AS A
    INNER JOIN
        dbp_data.lief_typ_spr_zu_2 AS B
        ON A.lief_typ_id = B.lief_typ_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.lief_typ_bez <> B.lief_typ_bez
    GROUP BY
        A.lief_typ_id,
        A.spr_id,
        ro_lief_typ_bez
) AS s
WHERE
    lief_typ_spr_zu.mandant_id = 4
    AND lief_typ_spr_zu.lief_typ_id = s.lief_typ_id
    AND lief_typ_spr_zu.spr_id = s.spr_id
    AND lief_typ_spr_zu.lief_typ_bez <> s.ro_lief_typ_bez;
