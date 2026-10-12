BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_gj_2;


INSERT INTO dbp_data.jahr_gj_2 (gj, akt_gj, akt_gj_komplett)
(
    SELECT
        gj,
        akt_gj,
        akt_gj_komplett
    FROM dbp_data.tag_2
    GROUP BY
        gj,
        akt_gj,
        akt_gj_komplett
);


COMMIT TRANSACTION;
