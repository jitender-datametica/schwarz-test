DELETE FROM dbp_data.artbew_gp_sum
WHERE dat = DATE '1900-01-01' OR dat IN (
    SELECT dat
    FROM dbp_data.artbew_agg_wt
    WHERE mandant_id = 1
    GROUP BY dat
);


INSERT INTO dbp_data.artbew_gp_sum (
    mandant_id, dat, gp_id, vw_id, wrg, umrechnungskurs_hist,
    umsatz_netto, ek_mep
)
(
    SELECT
        T1.mandant_id,
        T1.dat,
        T1.gp_id,
        T2.vw_id,
        T1.wrg,
        T1.umrechnungskurs_hist,
        SUM(T1.umsatz_netto) AS umsatz_netto,
        COALESCE(SUM(CAST(T1.ek_mep AS NUMERIC)), 0) AS ek_mep
    FROM dbp_data.artbew AS T1
    INNER JOIN
        dbp_data.wup AS T2
        ON T1.wup_id = T2.wup_id AND T1.mandant_id = T2.mandant_id
    WHERE
        T1.mandant_id = 1
        AND (T1.dat = DATE '1900-01-01' OR T1.dat IN (
            SELECT dat
            FROM dbp_data.artbew_agg_wt
            WHERE mandant_id = 1
            GROUP BY dat
        ))
    GROUP BY
        T1.mandant_id,
        T1.gp_id,
        T2.vw_id,
        T1.dat,
        T1.wrg,
        T1.umrechnungskurs_hist
);
