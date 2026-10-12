BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_gj;


INSERT INTO dbp_data.jahr_gj (gj, akt_gj, akt_gj_komplett)
(
    SELECT
        gj,
        akt_gj,
        akt_gj_komplett
    FROM dbp_data.tag
    GROUP BY
        gj,
        akt_gj,
        akt_gj_komplett
);


COMMIT TRANSACTION;
