CREATE OR REPLACE TABLE dbp_etl.lagerbestand_erp_wg_dat_2 (
    init_dat_von DATE NOT NULL
);


INSERT INTO dbp_etl.lagerbestand_erp_wg_dat_2 (init_dat_von)
(SELECT DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 30 DAY) AS init_dat_von);


DELETE FROM dbp_data.lagerbestand_erp_wg_2 AS LEW
WHERE dat >= (
    SELECT init_dat_von
    FROM dbp_etl.lagerbestand_erp_wg_dat_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.lagerbestand_erp_wg_2 (
    mandant_id, wup_id, nb_id, lagerort_id, wg_id, arthiertyp_id,
    dat, menge_lgbest_erp_frei_bme, menge_lgbest_erp_umlag_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme, menge_lgbest_erp_ret_gesp_bme, menge_lgbest_erp_kolli, menge_lgbest_erp_palette,
    betrag_lgbest_erp, wrg_id, vk_netto_lgbest_erp, td_insert, td_update
)
(
    SELECT
        MARD.mandant_id,
        MARD.wup_id,
        MARD.nb_id,
        MARD.lagerort_id,
        AWZP.wg_id,
        AWZP.arthiertyp_id,
        dat0.dat,
        SUM(MARD.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
        SUM(MARD.menge_lgbest_erp_umlag_bme) AS menge_lgbest_erp_umlag_bme,
        SUM(MARD.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
        SUM(MARD.menge_lgbest_erp_nf_charge_bme) AS menge_lgbest_erp_nf_charge_bme,
        SUM(MARD.menge_lgbest_erp_gesp_bme) AS menge_lgbest_erp_gesp_bme,
        SUM(MARD.menge_lgbest_erp_ret_gesp_bme) AS menge_lgbest_erp_ret_gesp_bme,
        SUM(MARD.menge_lgbest_erp_kolli) AS menge_lgbest_erp_kolli,
        SUM(MARD.menge_lgbest_erp_palette) AS menge_lgbest_erp_palette,
        SUM(CAST(MARD.betrag_lgbest_erp AS NUMERIC)) AS betrag_lgbest_erp,
        MARD.wrg_id,
        SUM(MARD.vk_netto_lgbest_erp) AS vk_netto_lgbest_erp,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.lagerbestand_erp_per_2 AS MARD_2
    INNER JOIN dbp_data.art_wg_zu_per_2 AS AWZP
        ON
            MARD.art_id = AWZP.art_id AND AWZP.arthiertyp_id = 2 AND
            MARD.mandant_id = AWZP.mandant_id AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN (
        SELECT tag.dat
        FROM dbp_data.tag_2
        INNER JOIN dbp_etl.lagerbestand_erp_wg_dat_2 AS LED ON TRUE
        WHERE tag.dat BETWEEN LED.init_dat_von AND (CURRENT_DATE("Europe/Berlin"))
    ) AS dat0
        ON dat0.dat BETWEEN MARD.dat_von AND MARD.dat_bis
    GROUP BY
        MARD.mandant_id,
        MARD.wrg_id,
        MARD.wup_id,
        MARD.nb_id,
        MARD.lagerort_id,
        AWZP.wg_id,
        dat0.dat,
        AWZP.arthiertyp_id,
        CURRENT_TIMESTAMP()
);
