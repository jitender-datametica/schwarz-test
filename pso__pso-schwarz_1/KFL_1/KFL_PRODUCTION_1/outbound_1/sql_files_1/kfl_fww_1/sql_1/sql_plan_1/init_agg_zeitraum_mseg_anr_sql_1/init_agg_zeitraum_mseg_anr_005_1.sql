--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.kmo_mseg_dat_1 (dat_buch, mandant_id)
(
    SELECT
        T2.dat,
        T1.mandant_id
    FROM dbp_etl.zeitraum_mseg_anr_1 AS T1_1
    INNER JOIN dbp_data.tag_1 AS T2 ON T2.dat BETWEEN T1.min_dat AND T1.max_dat
);
