--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.kmo_mseg_dat_2 (dat_buch, mandant_id)
(
    SELECT
        T2.dat,
        T1.mandant_id
    FROM dbp_etl.zeitraum_mseg_anr_2 AS T1_2
    INNER JOIN dbp_data.tag_2 AS T2 ON T2.dat BETWEEN T1.min_dat AND T1.max_dat
);
