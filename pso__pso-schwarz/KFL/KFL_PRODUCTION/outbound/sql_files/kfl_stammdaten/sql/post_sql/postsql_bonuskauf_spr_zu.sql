UPDATE dbp_data.bonuskauf_spr_zu SET
    bonuskauf_bez = s.ro_bonuskauf_bez FROM (
    SELECT
        A.bonuskauf_id,
        A.spr_id,
        B.bonuskauf_bez AS ro_bonuskauf_bez
    FROM dbp_data.bonuskauf_spr_zu AS A
    INNER JOIN
        dbp_data.bonuskauf_spr_zu AS B
        ON A.bonuskauf_id = B.bonuskauf_id AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.bonuskauf_bez <> B.bonuskauf_bez
    GROUP BY
        A.bonuskauf_id,
        A.spr_id,
        ro_bonuskauf_bez
) AS s
WHERE
    bonuskauf_spr_zu.mandant_id = 4
    AND bonuskauf_spr_zu.bonuskauf_id = s.bonuskauf_id
    AND bonuskauf_spr_zu.spr_id = s
    .spr_id;
