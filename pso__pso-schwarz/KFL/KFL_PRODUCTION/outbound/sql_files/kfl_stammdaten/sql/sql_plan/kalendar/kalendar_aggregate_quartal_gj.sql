BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.quartal_gj;


INSERT INTO dbp_data.quartal_gj (
    gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett, gjhj
)
(
    SELECT
        gjqu,
        akt_gjqu,
        akt_gjqu_komplett,
        gj,
        akt_gj,
        akt_gj_komplett,
        gjhj
    FROM dbp_data.tag
    GROUP BY
        gjqu,
        gj,
        akt_gjqu,
        akt_gjqu_komplett,
        akt_gj,
        akt_gj_komplett,
        gjhj
);


COMMIT TRANSACTION;
