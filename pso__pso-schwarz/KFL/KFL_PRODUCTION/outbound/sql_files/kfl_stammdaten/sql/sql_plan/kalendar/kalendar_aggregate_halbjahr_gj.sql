BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.halbjahr_gj;


INSERT INTO dbp_data.halbjahr_gj (gjhj, akt_gjhj, akt_gjhj_komplett, gj)
(
    SELECT
        gjhj,
        akt_gjhj,
        akt_gjhj_komplett,
        gj
    FROM dbp_data.tag
    GROUP BY
        gj,
        gjhj,
        akt_gjhj,
        akt_gjhj_komplett
);


COMMIT TRANSACTION;
