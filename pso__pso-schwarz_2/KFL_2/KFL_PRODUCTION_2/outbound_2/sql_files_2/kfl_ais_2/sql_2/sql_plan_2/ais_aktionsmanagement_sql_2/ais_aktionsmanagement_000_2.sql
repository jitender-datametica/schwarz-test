-- 18.10.2024
--
-- Einfuegen und Aktualisieren der neuen Werbehierarchie. Am Ende laeuft es in die
-- wg_per_2 rein.


DELETE FROM dbp_data.l_werbeteam_2
WHERE (
    mandant_id, werbeteam_cd) IN (
    SELECT (mandant_id, werbeteam_cd)
    FROM dbp_msi_data.ts_werbebereich_werbeteam_zu_2
);


INSERT INTO dbp_data.l_werbeteam_2 (
    mandant_id, werbeteam_cd, werbebereich_cd, werbeteam_bez, td_update,
    td_insert
)
(
    SELECT
        mandant_id,
        werbeteam_cd,
        werbebereich_cd,
        werbeteam_bez,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_werbebereich_werbeteam_zu_2
    GROUP BY
        mandant_id,
        werbeteam_cd,
        werbebereich_cd,
        werbeteam_bez,
        td_update,
        td_insert
);


DELETE FROM dbp_data.l_werbebereich_2
WHERE (
    mandant_id, werbebereich_cd) IN (
    SELECT (mandant_id, werbebereich_cd)
    FROM dbp_msi_data.ts_werbebereich_werbeteam_zu_2
);


INSERT INTO dbp_data.l_werbebereich_2 (
    mandant_id, werbebereich_cd, werbebereich_bez, td_update, td_insert
)
(
    SELECT
        mandant_id,
        werbebereich_cd,
        werbebereich_cd AS werbebereich_bez,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_msi_data.ts_werbebereich_werbeteam_zu_2
    GROUP BY
        mandant_id,
        werbebereich_cd,
        werbebereich_bez,
        td_update,
        td_insert
);


UPDATE dbp_data.wg_per_2 SET
    werbeteam_cd = 'nicht vorhanden'
WHERE TRUE;


UPDATE dbp_data.wg_per_2 SET
    werbeteam_cd = b.werbeteam_cd FROM (
    SELECT
        mandant_id,
        wg_id,
        werbeteam_cd
    FROM dbp_msi_data.ts_werbebereich_werbeteam_zu_2
    GROUP BY
        mandant_id,
        wg_id,
        werbeteam_cd
) AS b
WHERE
    wg_per.mandant_id = b.mandant_id
    AND wg_per.wg_id = b.wg_id
    AND wg_per.arthiertyp_id = 2
    AND wg_per.dat_bis
    = DATE '9999-12-31';


-- 06.11.2024
--
-- Hier die Aufbereitung der Aktionsthemen aus den Bondaten, die deutlich genauer sind als die Stammdaten.


CREATE OR REPLACE TEMPORARY TABLE _bon_aktion AS
SELECT
    B.mandant_id,
    B.aktion_id,
    B.wup_id,
    B.kl_art_id,
    B.bon_dat
FROM dbp_ods.ods_bon_kopf_2 AS A
INNER JOIN dbp_ods.ods_bon_verkauf_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.bon_id = B.bon_id AND A.wup_id
        = B.wup_id AND A.bon_dat = B.bon_dat
WHERE
    A.turnover_fg = 1
    AND A.kunde_fg = 1
    AND A.suspended_fg = 0
    AND B.zeilenstorno_fg = 0
    AND A.bon_dat BETWEEN DATE_SUB(
        CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY
    ) AND (CURRENT_DATE("Europe/Berlin"))
    AND B.aktion_id IS NOT NULL
GROUP BY
    B.mandant_id,
    B.wup_id,
    B.bon_dat,
    B.kl_art_id,
    B.aktion_id
UNION DISTINCT
SELECT
    A.mandant_id,
    t3.aktion_id,
    A.wup_id,
    A.kl_art_id,
    A.bon_dat
FROM dbp_ods.ods_promotion_2 AS A
INNER JOIN (
    SELECT
        B.mandant_id,
        B.bonuskauf_id,
        MAX(A0.aktion_id) AS aktion_id
    FROM dbp_data.aktion_2 AS A0
    LEFT JOIN
        dbp_data.l_bonuskauf_2 AS B
        ON A0.aktion_id = B.aktion_id AND A0.mandant_id = B.mandant_id
    GROUP BY
        B.mandant_id,
        B.bonuskauf_id
) AS t3 ON A.bonuskauf_id = t3.bonuskauf_id AND A.mandant_id = t3.mandant_id
WHERE
    A.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"));


CREATE OR REPLACE TEMPORARY TABLE _aktion_thema AS
SELECT
    A.mandant_id,
    A.aktion_id,
    A.wup_id,
    A.kl_art_id,
    A.bon_dat,
    C.dat_von,
    C.dat_bis,
    CAST(NULL AS STRING) AS aktionsthema
FROM `_bon_aktion` AS A
INNER JOIN
    dbp_data.aktion_2 AS C
    ON A.mandant_id = C.mandant_id AND A.aktion_id = C.aktion_id
GROUP BY
    A.mandant_id,
    A.aktion_id,
    A.wup_id,
    A.kl_art_id,
    A.bon_dat,
    C.dat_von,
    C.dat_bis,
    aktionsthema;


CREATE OR REPLACE TEMPORARY TABLE _bon_aktion_thema AS
SELECT
    A.mandant_id,
    A.aktion_id,
    A.wup_id,
    A.kl_art_id,
    A.bon_dat,
    A.dat_von,
    A.dat_bis,
    b.aktion_thema_id
FROM `_aktion_thema` AS A
INNER JOIN (
    SELECT
        mandant_id,
        aktion_id,
        wup_id,
        CASE
            WHEN mandant_id = 1
                THEN FLOOR(art_id / 100)
            ELSE FLOOR(art_id / 10)
        END AS kl_art_id,
        aktion_thema_id
    FROM dbp_data.aktion_art_wup_zu_2 AS B
    WHERE nb_id = 0
    GROUP BY
        mandant_id,
        aktion_id,
        wup_id,
        kl_art_id,
        aktion_thema_id
) AS b
    ON
        A.mandant_id = b.mandant_id
        AND A.aktion_id = b.aktion_id
        AND A.kl_art_id = b.kl_art_id
        AND A.wup_id = b.wup_id
GROUP BY
    A.mandant_id,
    A.aktion_id,
    A.wup_id,
    A.kl_art_id,
    A.bon_dat,
    A.dat_von,
    A.dat_bis,
    b.aktion_thema_id;


CREATE OR REPLACE TEMPORARY TABLE _bon_aktion_thema_group AS
SELECT
    mandant_id,
    wup_id,
    kl_art_id,
    bon_dat,
    dat_von,
    dat_bis,
    aktion_thema_id
FROM `_bon_aktion_thema`
GROUP BY
    mandant_id,
    wup_id,
    kl_art_id,
    bon_dat,
    dat_von,
    dat_bis,
    aktion_thema_id;


DELETE FROM dbp_etl_process.bon_aktion_thema_group_2
WHERE
    bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY) AND (CURRENT_DATE("Europe/Berlin"));


INSERT INTO dbp_etl_process.bon_aktion_thema_group_2 (
    mandant_id, wup_id, kl_art_id, bon_dat, dat_von,
    dat_bis, aktion_thema_id
)
(
     SELECT 
        mandant_id,
        wup_id,
        kl_art_id,
        bon_dat,
        dat_von,
        dat_bis,
        aktion_thema_id
    FROM `_bon_aktion_thema_group`
    WHERE
        bon_dat BETWEEN DATE_SUB(
            CURRENT_DATE("Europe/Berlin"), INTERVAL 10 DAY
        ) AND (CURRENT_DATE("Europe/Berlin"))
);
