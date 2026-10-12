BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_kj_1;


INSERT INTO dbp_data.jahr_kj_1 (kj, akt_kj, akt_kj_komplett)
(
    SELECT
        kj,
        akt_kj,
        akt_kj_komplett
    FROM dbp_data.tag_1
    GROUP BY
        kj,
        akt_kj,
        akt_kj_komplett
);


COMMIT TRANSACTION;
