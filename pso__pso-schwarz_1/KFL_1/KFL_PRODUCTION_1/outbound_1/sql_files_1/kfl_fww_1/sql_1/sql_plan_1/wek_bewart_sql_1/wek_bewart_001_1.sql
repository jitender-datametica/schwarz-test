/* AW check 2021-05-17*/


DELETE FROM dbp_etl_process.ekc_artbew_flagging_1
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl_process.ekc_artbew_agg_wt_1
);


INSERT INTO dbp_etl_process.ekc_artbew_flagging_1 (
    mandant_id, wup_id, art_id, dat, bewart_id, menge,
    menge_sum, anteil, bewart_det_id
)
(SELECT
    t2.mandant_id,
    t2.wup_id,
    t2.art_id,
    t2.dat,
    t2.bewart_id,
    t2.menge,
    SUM(ABS(
        t2.menge
    ))
        OVER (
            PARTITION BY
                t2.mandant_id, t2.wup_id, t2.art_id, t2.dat
            RANGE BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING
        ) AS menge_sum,
    IFNULL(CAST(ABS(t2.menge) AS FLOAT64) / IF(
        CAST(
            SUM(ABS(t2.menge))
                OVER (
                    PARTITION BY
                        t2.mandant_id, t2.wup_id, t2.art_id, t2.dat
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            AS FLOAT64
        )
        = 0,
        NULL,
        CAST(
            SUM(ABS(t2.menge))
                OVER (
                    PARTITION BY
                        t2.mandant_id, t2.wup_id, t2.art_id, t2.dat
                    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                )
            AS FLOAT64
        )
    ), 0) AS anteil,
    t2.bewart_det_id
FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id,
        A.dat,
        A.bewart_id,
        A.bewart_det_id,
        SUM(A.menge) AS menge
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl_process.ekc_artbew_agg_wt_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.nb_id = B.nb_id AND A.dat = B.dat
    WHERE A.bewart_id IN (1001, 1002)
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.dat,
        A.bewart_id,
        A.art_id,
        A.bewart_det_id
    HAVING menge <> 0
) AS t2);
