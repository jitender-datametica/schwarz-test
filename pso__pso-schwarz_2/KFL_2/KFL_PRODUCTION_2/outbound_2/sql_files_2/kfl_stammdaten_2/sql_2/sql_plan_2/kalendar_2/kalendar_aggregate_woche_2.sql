BEGIN TRANSACTION;
TRUNCATE TABLE dbp_data.woche_2;


-- mfialkiewicz
-- ,(wo_dat_von-(DATE-((DATE-CAST('1990-01-01' AS DATE)) MOD 7)))/7 AS akt_wo_kalendarisch
INSERT INTO
dbp_data.woche_2 (
    gjwo,
    gjwo_vj,
    kjwo,
    kjwo_vj,
    wo_dat_von,
    wo_dat_bis,
    akt_wo,
    akt_wo_komplett,
    akt_wo_kalendarisch, kjwo_vvj
)
(
    SELECT
        gjwo,
        gjwo_vj,
        kjwo,
        kjwo_vj,
        wo_dat_von,
        wo_dat_bis,
        akt_wo,
        akt_wo_komplett,
        DATE_DIFF(CURRENT_DATE("Europe/Berlin"), wo_dat_von, WEEK)
        * -1 AS akt_wo_kalendarisch,
        kjwo_vvj
    FROM dbp_data.tag_2
    GROUP BY
        gjwo,
        gjwo_vj,
        kjwo,
        kjwo_vj,
        kjwo_vvj,
        wo_dat_von,
        wo_dat_bis,
        akt_wo,
        akt_wo_komplett,
        akt_wo_kalendarisch
);


COMMIT TRANSACTION;
