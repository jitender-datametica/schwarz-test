--AW 2021-04-22 check OK


UPDATE dbp_data.gp_2 SET
    herst_fg = 1 FROM (
    SELECT
        MAX(T1.herst_id) AS dt_herst_id,
        T2.gp_id AS dt_gp_id,
        T2.mandant_id AS dt_mandant_id
    FROM dbp_data.art_gp_zu_per_2 AS T1_2
    INNER JOIN
        dbp_data.gp_2 AS T2
        ON T1.herst_id = T2.gp_id AND T1.mandant_id = T2.mandant_id
    GROUP BY
        dt_gp_id,
        dt_mandant_id
) AS dt
WHERE gp.gp_id = dt.dt_gp_id AND gp.mandant_id = dt.dt_mandant_id;


INSERT INTO dbp_data.art_gp_zu_per_2 (
    dat_von, mandant_id, art_id, gp_id, einkaufsorganisation_id,
    gp_art_id, dat_bis, herst_id, mhd_zeitraum_dz, mutter_ek_id
)
(
    SELECT
        DT1.dat_von,
        DT1.mandant_id,
        DT1.art_id,
        -1 AS gp_id,
        DT2.einkaufsorganisation_id,
        '-1' AS gp_art_id,
        DT1.dat_bis,
        -2 AS herst_id,
        -1 AS mhd_zeitraum_dz,
        -1 AS mutter_ek_id
    FROM dbp_data.art_2 AS DT1
    INNER JOIN dbp_data.l_einkaufsorganisation_2 AS DT2
        ON
            DT1.mandant_id = DT2.mandant_id AND DT2.einkaufsorganisation_id
            = 1000
    LEFT JOIN
        dbp_data.art_gp_zu_per_2 AS DT3
        ON DT1.mandant_id = DT3.mandant_id AND DT1.art_id = DT3.art_id
    WHERE
        DT1.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND DT1.mandant_id = 1
        AND DT3.art_id IS NULL
);
