UPDATE dbp_data.konditionsart_spr_zu SET
    konditionsart_bez = s.ro_konditionsart_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.konditionsart_id,
        A.spr_id,
        B.konditionsart_bez AS ro_konditionsart_bez
    FROM dbp_data.konditionsart_spr_zu AS A
    INNER JOIN dbp_data.konditionsart_spr_zu AS B
        ON
            A.konditionsart_id = B.konditionsart_id AND A.spr_id
            = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.konditionsart_bez <> B.konditionsart_bez
    GROUP BY
        A.konditionsart_id,
        A.spr_id,
        ro_konditionsart_bez
) AS s
WHERE
    konditionsart_spr_zu.mandant_id = 4
    AND konditionsart_spr_zu.konditionsart_id = s.konditionsart_id
    AND konditionsart_spr_zu.spr_id = s.spr_id AND konditionsart_spr_zu.konditionsart_bez <> s.ro_konditionsart_bez;
