/* AW check 2021-05-17*/


TRUNCATE TABLE dbp_data.werbewoche_kl_vvt_2;


INSERT INTO dbp_data.werbewoche_kl_vvt_2 (
    mandant_id, dat, akt_kjwo_ww, akt_kjwo_ww_komplett, kjwo_ww
)
(SELECT
    mandant_id,
    dat,
    akt_kjwo_ww,
    akt_kjwo_ww_komplett,
    kjwo_ww
FROM dbp_data.werbewoche_kl_2);


TRUNCATE TABLE dbp_data.werbewoche_kl_2;


INSERT INTO dbp_data.werbewoche_kl_2 (
    mandant_id, dat, akt_kjwo_ww, akt_kjwo_ww_komplett, kjwo_ww
)
(
    SELECT
        x.mandant_id,
        x.dat,
        x.akt_wo_ AS akt_kjwo_ww,
        x.akt_wo_komplett AS akt_kjwo_ww_komplett,
        Y.kjwo AS kjwo_ww
    FROM (
        SELECT
            B.mandant_id,
            A.dat,
            CASE
                WHEN B.mandant_id = 8 AND A.wtag_id BETWEEN 1 AND 7
                    THEN A.akt_wo
                WHEN
                    B.mandant_id IN (2)
                    AND A.wtag_id BETWEEN 1 AND 2
                    AND A.kjwo >= 201909
                    OR B.mandant_id IN (2) AND A.wtag_id
                    BETWEEN 1 AND 3 AND A.kjwo <= 201908
                    OR B.mandant_id IN (6)
                    AND A.wtag_id BETWEEN 1 AND 3
                    AND A.kjwo
                    <= 202204 OR B.mandant_id IN (6) AND A.wtag_id BETWEEN 1 AND 2 AND A.kjwo >= 202205 OR B.mandant_id IN (4)
                    AND A.wtag_id BETWEEN 1 AND 2 AND A.kjwo <= 202330
                    OR B.mandant_id IN (4) AND A.wtag_id BETWEEN 1 AND 3
                    AND A.kjwo = 202331 OR B.mandant_id IN (4) AND A.wtag_id BETWEEN 1 AND 3 AND A.kjwo >= 202332 OR B.mandant_id IN
                    (7) AND A.wtag_id BETWEEN 1 AND 2
                    OR B.mandant_id IN (1, 3, 5) AND A.wtag_id BETWEEN 1 AND 3
                    THEN A.akt_wo - 1
                ELSE A.akt_wo
            END AS akt_wo_,
            CASE
                WHEN
                    CASE
                        WHEN B.mandant_id = 8 AND A.wtag_id BETWEEN 1 AND 7
                            THEN A.akt_wo
                        WHEN
                            B.mandant_id IN (2)
                            AND A.wtag_id BETWEEN 1 AND 2
                            AND A.kjwo >= 201909
                            OR B.mandant_id IN (2) AND A.wtag_id
                            BETWEEN 1 AND 3 AND A.kjwo <= 201908
                            OR B.mandant_id IN (6)
                            AND A.wtag_id BETWEEN 1 AND 3
                            AND A.kjwo
                            <= 202204
                            OR B.mandant_id IN (6)
                            AND A.wtag_id BETWEEN 1 AND 2
                            AND A.kjwo >= 202205
                            OR B.mandant_id IN (4
                            ) AND A.wtag_id BETWEEN 1 AND 2 AND A.kjwo <= 202330
                            OR B.mandant_id IN (4) AND A.wtag_id BETWEEN 1 AND
                            3 AND A.kjwo = 202331
                            OR B.mandant_id IN (4)
                            AND A.wtag_id BETWEEN 1 AND 3
                            AND A.kjwo >= 202332
                            OR B.mandant_id
                            IN (7) AND A.wtag_id BETWEEN 1 AND 2
                            OR B.mandant_id IN (1, 3, 5)
                            AND A.wtag_id BETWEEN 1 AND 3
                            THEN A.akt_wo - 1
                        ELSE A.akt_wo
                    END NOT IN (-1, 0)
                    THEN CASE
                        WHEN B.mandant_id = 8 AND A.wtag_id BETWEEN 1 AND 7
                            THEN A.akt_wo
                        WHEN
                            B.mandant_id IN (2)
                            AND A.wtag_id BETWEEN 1 AND 2
                            AND A.kjwo >= 201909
                            OR B.mandant_id IN (2) AND A.wtag_id
                            BETWEEN 1 AND 3 AND A.kjwo <= 201908
                            OR B.mandant_id IN (6)
                            AND A.wtag_id BETWEEN 1 AND 3
                            AND A.kjwo
                            <= 202204 OR B.mandant_id IN (6) AND A.wtag_id BETWEEN 1 AND 2 AND A.kjwo >= 202205 OR B.mandant_id IN (4)
                            AND A.wtag_id BETWEEN 1 AND 2 AND A.kjwo <= 202330
                            OR B.mandant_id IN (4) AND A.wtag_id BETWEEN 1 AND 3
                            AND A.kjwo = 202331 OR B.mandant_id IN (4) AND A.wtag_id BETWEEN 1 AND 3 AND A.kjwo >= 202332 OR B.mandant_id IN
                            (7) AND A.wtag_id BETWEEN 1 AND 2
                            OR B.mandant_id IN (1, 3, 5)
                            AND A.wtag_id BETWEEN 1 AND 3
                            THEN A.akt_wo - 1
                        ELSE A.akt_wo
                    END
                ELSE 0
            END AS akt_wo_komplett
        FROM dbp_data.tag_2 AS A
        INNER JOIN dbp_data.mandant_2 AS B ON TRUE
    ) AS x
    INNER JOIN dbp_data.woche_2 AS Y ON x.akt_wo_ = Y.akt_wo
    INNER JOIN dbp_data.tag_2 AS Z ON x.dat = Z.dat
);
