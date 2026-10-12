--fur_prognose


CREATE OR REPLACE TEMPORARY TABLE _fur_pass AS WITH `_ARTBEW` AS (
    SELECT
        dat,
        art_id,
        mandant_id,
        nb_id,
        wup_id,
        SUM(menge) AS vk_menge,
        SUM(CASE
            WHEN bewart_id = 1002
                THEN menge
            ELSE NULL
        END) AS vk_menge_sa,
        SUM(CASE
            WHEN bewart_id = 1001
                THEN menge
            ELSE NULL
        END) AS vk_menge_af
    FROM dbp_data.artbew
    GROUP BY
        dat,
        art_id,
        mandant_id,
        nb_id,
        wup_id
) (
    SELECT
        P_FUR.mandant_id,
        P_FUR.wup_id,
        P_FUR.nb_id,
        P_FUR.art_id,
        P_FUR.dat,
        CASE
            WHEN P_FUR.dat <= CURRENT_DATE("Europe/Berlin")
                THEN DATE_SUB(P_FUR.dat, INTERVAL 1 DAY)
            ELSE CURRENT_DATE("Europe/Berlin")
        END AS dat_prognoselauf,
        T.kjwo,
        T.kjmo,
        P_FUR.prognose_horizont AS prognose_horizont_fur,
        P_FUR.menge_prognose_aktion AS menge_prognose_sa_fur,
        CASE
            WHEN P_FUR.menge_prognose_aktion > 0
                THEN 0
            ELSE P_FUR.menge_prognose
        END AS menge_prognose_af_fur,
        CASE
            WHEN P_FUR.menge_prognose_aktion > 0
                THEN P_FUR.menge_prognose_aktion
            ELSE P_FUR.menge_prognose
        END AS menge_prognose_fur,
        P_FUR.menge_prognose_max AS menge_prognose_max_fur,
        COALESCE(artbew.vk_menge, 0) AS vk_menge_fur,
        COALESCE(artbew.vk_menge_sa, 0) AS vk_menge_sa_fur,
        COALESCE(artbew.vk_menge_af, 0) AS vk_menge_af_fur,
        ABS(CASE
            WHEN P_FUR.menge_prognose_aktion > 0
                THEN P_FUR.menge_prognose_aktion
            ELSE P_FUR.menge_prognose
        END - COALESCE(artbew.vk_menge, 0)) AS abs_diff_fur,
        ABS(P_FUR.menge_prognose_aktion - COALESCE(artbew.vk_menge_sa, 0)) AS abs_diff_sa_fur,
        ABS(CASE
            WHEN P_FUR.menge_prognose_aktion > 0
                THEN 0
            ELSE P_FUR.menge_prognose
        END - COALESCE(artbew.vk_menge_af, 0)) AS abs_diff_af_fur
    FROM dbp_data.fur_prognose AS P_FUR
    INNER JOIN dbp_data.tag AS T ON P_FUR.dat = T.dat
    LEFT JOIN `_ARTBEW` AS artbew
        ON
            P_FUR.mandant_id = artbew.mandant_id AND P_FUR.wup_id = artbew.wup_id AND P_FUR.dat
            = artbew.dat AND P_FUR.art_id = artbew.art_id
    WHERE P_FUR.dat BETWEEN DATE_SUB(DATE(${DAT_KALK}), INTERVAL 3 DAY) AND (DATE(${DAT_KALK}))
);


CREATE OR REPLACE TABLE dbp_etl.fur_pass_agg AS
SELECT
    FUR_PASS.mandant_id,
    FUR_PASS.wup_id,
    FUR_PASS.nb_id,
    FUR_PASS.dat,
    FUR_PASS.dat_prognoselauf,
    FUR_PASS.kjwo,
    FUR_PASS.kjmo,
    MAX(FUR_PASS.prognose_horizont_fur) AS fur_prognose_horizont,
    awg.wg_id,
    SUM(FUR_PASS.menge_prognose_sa_fur) AS fur_menge_prognose_sa,
    SUM(FUR_PASS.menge_prognose_af_fur) AS fur_menge_prognose_af,
    SUM(FUR_PASS.menge_prognose_fur) AS fur_menge_prognose,
    SUM(FUR_PASS.menge_prognose_max_fur) AS fur_menge_prognose_max,
    SUM(FUR_PASS.vk_menge_fur) AS fur_vk_menge,
    SUM(FUR_PASS.vk_menge_sa_fur) AS fur_vk_menge_sa,
    SUM(FUR_PASS.vk_menge_af_fur) AS fur_vk_menge_af,
    SUM(FUR_PASS.abs_diff_fur) AS fur_abs_diff,
    SUM(FUR_PASS.abs_diff_sa_fur) AS fur_abs_diff_sa,
    SUM(FUR_PASS.abs_diff_af_fur) AS fur_abs_diff_af
FROM `_fur_pass` AS FUR_PASS
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        wg_id
    FROM dbp_data.art_wg_zu_per
    WHERE
        arthiertyp_id = 2
        AND dat_bis = DATE '9999-12-31'
) AS awg ON FUR_PASS.mandant_id = awg.mandant_id AND FUR_PASS.art_id = awg.art_id
GROUP BY
    FUR_PASS.mandant_id,
    FUR_PASS.wup_id,
    FUR_PASS.nb_id,
    FUR_PASS.dat,
    FUR_PASS.dat_prognoselauf,
    FUR_PASS.kjwo,
    FUR_PASS.kjmo,
    awg.wg_id;
