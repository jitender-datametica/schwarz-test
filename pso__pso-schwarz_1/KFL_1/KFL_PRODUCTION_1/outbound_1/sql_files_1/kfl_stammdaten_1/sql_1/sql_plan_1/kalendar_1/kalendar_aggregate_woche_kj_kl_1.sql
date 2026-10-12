BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.woche_kj_kl_1;


INSERT INTO dbp_data.woche_kj_kl_1 (
    kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis, akt_kjwo_kl,
    akt_kjwo_kl_komplett, akt_kj, akt_kj_komplett, kjwo, akt_wo
)
(
    SELECT
        kjwo_kl,
        kjwo_kl_dat_von,
        kjwo_kl_dat_bis,
        akt_kjwo_kl,
        akt_kjwo_kl_komplett,
        akt_kj,
        akt_kj_komplett,
        kjwo,
        akt_wo
    FROM dbp_data.tag_1
    GROUP BY
        kjwo,
        kjwo_kl,
        kjwo_kl_dat_von,
        kjwo_kl_dat_bis,
        akt_wo,
        akt_kjwo_kl,
        akt_kjwo_kl_komplett,
        akt_kj,
        akt_kj_komplett
);


COMMIT TRANSACTION;
