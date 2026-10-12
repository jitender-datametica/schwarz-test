BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.jahr_gj_1;


INSERT INTO dbp_data.jahr_gj_1 (gj, akt_gj, akt_gj_komplett)
(
    SELECT
        gj,
        akt_gj,
        akt_gj_komplett
    FROM dbp_data.tag_1
    GROUP BY
        gj,
        akt_gj,
        akt_gj_komplett
);


COMMIT TRANSACTION;
