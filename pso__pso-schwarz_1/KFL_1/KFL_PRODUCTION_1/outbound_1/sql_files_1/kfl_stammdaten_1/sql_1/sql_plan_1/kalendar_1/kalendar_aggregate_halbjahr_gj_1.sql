BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.halbjahr_gj_1;


INSERT INTO dbp_data.halbjahr_gj_1 (gjhj, akt_gjhj, akt_gjhj_komplett, gj)
(
    SELECT
        gjhj,
        akt_gjhj,
        akt_gjhj_komplett,
        gj
    FROM dbp_data.tag_1
    GROUP BY
        gj,
        gjhj,
        akt_gjhj,
        akt_gjhj_komplett
);


COMMIT TRANSACTION;
