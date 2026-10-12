BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_kj;


INSERT INTO dbp_data.jahr_kj (kj, akt_kj, akt_kj_komplett)
(
    SELECT
        kj,
        akt_kj,
        akt_kj_komplett
    FROM dbp_data.tag
    GROUP BY
        kj,
        akt_kj,
        akt_kj_komplett
);


COMMIT TRANSACTION;
