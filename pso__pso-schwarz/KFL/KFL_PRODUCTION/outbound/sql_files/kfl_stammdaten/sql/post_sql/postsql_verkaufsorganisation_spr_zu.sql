UPDATE dbp_data.verkaufsorganisation_spr_zu SET
    verkaufsorganisation_bez = s.ro_verkaufsorganisation_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.verkaufsorganisation_id,
        A.spr_id,
        B.verkaufsorganisation_bez AS ro_verkaufsorganisation_bez
    FROM dbp_data.verkaufsorganisation_spr_zu AS A
    INNER JOIN dbp_data.verkaufsorganisation_spr_zu AS B
        ON
            A.verkaufsorganisation_id = B.verkaufsorganisation_id
            AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.verkaufsorganisation_bez <> B.verkaufsorganisation_bez
    GROUP BY
        A.verkaufsorganisation_id,
        A.spr_id,
        ro_verkaufsorganisation_bez
) AS s
WHERE
    verkaufsorganisation_spr_zu.mandant_id = 4
    AND verkaufsorganisation_spr_zu.verkaufsorganisation_id
    = s.verkaufsorganisation_id
    AND verkaufsorganisation_spr_zu.spr_id = s.spr_id AND verkaufsorganisation_spr_zu.verkaufsorganisation_bez <> s.ro_verkaufsorganisation_bez;
