INSERT INTO dbp_etl_process.hive_art_umbewertung
(
    SELECT
        B.mandant_id,
        B.dat_umbew,
        'ZUSEG',
        CURRENT_DATE("Europe/Berlin"),
        CAST(CURRENT_DATE AS TIMESTAMP),
        CAST(CURRENT_DATE AS TIMESTAMP)
    FROM dbp_etl.kmo_idb_zmuseg AS A
    INNER JOIN dbp_data.art_umbewertung AS B
        ON
            A.mandant_id = B.mandant_id AND A.umbew_beleg_id = B.umbew_beleg_id
            AND A.umbew_beleg_pos_id = B.umbew_beleg_pos_id AND A.kj = B.kj
    GROUP BY
        B.mandant_id,
        B.dat_umbew
);
