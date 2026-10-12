BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_kj_2;


INSERT INTO dbp_data.jahr_kj_2 (kj, akt_kj, akt_kj_komplett)
(
    SELECT
        kj,
        akt_kj,
        akt_kj_komplett
    FROM dbp_data.tag_2
    GROUP BY
        kj,
        akt_kj,
        akt_kj_komplett
);


COMMIT TRANSACTION;
