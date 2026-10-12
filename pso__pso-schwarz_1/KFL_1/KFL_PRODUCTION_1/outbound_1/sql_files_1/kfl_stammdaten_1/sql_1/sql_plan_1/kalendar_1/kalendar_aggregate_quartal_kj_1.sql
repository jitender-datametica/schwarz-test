BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.quartal_kj_1;


INSERT INTO dbp_data.quartal_kj_1 (
    kjqu, kj, akt_kjqu, akt_kjqu_komplett, akt_kj, akt_kj_komplett
)
(
    SELECT
        kjqu,
        kj,
        akt_kjqu,
        akt_kjqu_komplett,
        akt_kj,
        akt_kj_komplett
    FROM dbp_data.tag_1
    GROUP BY
        kjqu,
        kj,
        akt_kjqu,
        akt_kjqu_komplett,
        akt_kj,
        akt_kj_komplett
);


COMMIT TRANSACTION;
