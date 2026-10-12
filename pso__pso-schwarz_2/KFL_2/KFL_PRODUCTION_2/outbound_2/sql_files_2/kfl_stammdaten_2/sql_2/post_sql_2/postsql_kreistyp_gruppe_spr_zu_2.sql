UPDATE dbp_data.kreistyp_gruppe_spr_zu_2 SET
    kreistyp_gruppe_bez = s.ro_kreistyp_gruppe_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.kreistyp_gruppe_id,
        A.spr_id,
        B.kreistyp_gruppe_bez AS ro_kreistyp_gruppe_bez
    FROM dbp_data.kreistyp_gruppe_spr_zu_2 AS A
    INNER JOIN dbp_data.kreistyp_gruppe_spr_zu_2 AS B
        ON
            A.kreistyp_gruppe_id = B.kreistyp_gruppe_id AND A.spr_id
            = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.kreistyp_gruppe_bez <> B.kreistyp_gruppe_bez
    GROUP BY
        A.kreistyp_gruppe_id,
        A.spr_id,
        ro_kreistyp_gruppe_bez
) AS s
WHERE
    kreistyp_gruppe_spr_zu.mandant_id = 4
    AND kreistyp_gruppe_spr_zu.kreistyp_gruppe_id = s.kreistyp_gruppe_id
    AND kreistyp_gruppe_spr_zu.spr_id = s.spr_id AND kreistyp_gruppe_spr_zu.kreistyp_gruppe_bez <> s.ro_kreistyp_gruppe_bez;
