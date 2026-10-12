BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.woche_gj_kl_2;


INSERT INTO dbp_data.woche_gj_kl_2 (
    gjwo_kl, gjwo_kl_dat_von, gjwo_kl_dat_bis, akt_gjwo_kl,
    akt_gjwo_kl_komplett, akt_gj, akt_gj_komplett
)
(
    SELECT
        gjwo_kl,
        gjwo_kl_dat_von,
        gjwo_kl_dat_bis,
        akt_gjwo_kl,
        akt_gjwo_kl_komplett,
        akt_gj,
        akt_gj_komplett
    FROM dbp_data.tag_2
    GROUP BY
        gjwo_kl,
        gjwo_kl_dat_von,
        gjwo_kl_dat_bis,
        akt_gjwo_kl,
        akt_gjwo_kl_komplett,
        akt_gj,
        akt_gj_komplett
);


COMMIT TRANSACTION;
