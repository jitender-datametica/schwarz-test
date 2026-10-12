BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.monat_2;


INSERT INTO dbp_data.monat_2 (
    kjmo, kjmo_vj, gjmo, gjmo_vj, kjqu, gjqu, kj, gj, akt_mo, akt_mo_komplett,
    akt_gjqu,
    akt_gjqu_komplett,
    akt_kjqu,
    akt_kjqu_komplett,
    akt_gj,
    akt_gj_komplett,
    akt_kj,
    akt_kj_komplett,
    mo_gj,
    mo_kj, min_dat, max_dat, gjhj, kjmo_vvj
)
(
    SELECT
        kjmo,
        kjmo_vj,
        gjmo,
        gjmo_vj,
        kjqu,
        gjqu,
        kj,
        gj,
        akt_mo,
        akt_mo_komplett,
        akt_gjqu,
        akt_gjqu_komplett,
        akt_kjqu,
        akt_kjqu_komplett,
        akt_gj,
        akt_gj_komplett,
        akt_kj,
        akt_kj_komplett,
        mo_gj,
        mo_kj,
        MIN(dat) AS min_dat,
        MAX(dat) AS max_dat,
        gjhj,
        kjmo_vvj
    FROM dbp_data.tag_2
    GROUP BY
        kjmo,
        kjmo_vj,
        kjmo_vvj,
        gjmo,
        gjmo_vj,
        kjqu,
        gjqu,
        kj,
        gj,
        akt_mo,
        akt_mo_komplett,
        akt_gjqu,
        akt_gjqu_komplett,
        akt_kjqu,
        akt_kjqu_komplett,
        akt_gj,
        akt_gj_komplett,
        akt_kj,
        akt_kj_komplett,
        mo_gj,
        mo_kj,
        gjhj
);


COMMIT TRANSACTION;
