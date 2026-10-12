--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.kmo_mard_dat_2 (mandant_id, dat_von)
(
    SELECT
        mandant_id,
        dat_von
    FROM dbp_etl.lagerbestand_erp_tmpk_2
    GROUP BY
        mandant_id,
        dat_von
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.lagerbestand_erp_tmpk_2 SET
    wrg_id = gld.wrg_id_,
    ek_netto_bnk = gld.gld_ FROM (
    SELECT
        DT1.mandant_id AS mandant_id_,
        DT1.art_id AS art_id_,
        DT1.bewertungskreis_id AS bewertungskreis_id_,
        DT1.dat_gld AS dat_gld_,
        DT1.wrg_id AS wrg_id_,
        DT1.gld AS gld_
    FROM dbp_data.art_bewertungskreis_tag_2 AS DT1
    INNER JOIN
        dbp_etl.kmo_mard_dat_2 AS DT2
        ON DT1.dat_gld = DT2.dat_von AND DT1.mandant_id = DT2.mandant_id

    GROUP BY
        mandant_id_,
        art_id_,
        bewertungskreis_id_,
        dat_gld_,
        wrg_id_,
        gld_
) AS gld
WHERE
    lagerbestand_erp_tmpk.art_id = gld.art_id_
    AND lagerbestand_erp_tmpk.mandant_id = gld.mandant_id_
    AND lagerbestand_erp_tmpk.dat_von = gld.dat_gld_ AND lagerbestand_erp_tmpk.bewertungskreis_id = gld.bewertungskreis_id_;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.kmo_mard_dat_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.kmo_mard_dat_2 (mandant_id, dat_von)
(
    SELECT
        mandant_id,
        dat_von
    FROM dbp_etl.lagerbestand_erp_tmpk_2
    WHERE ek_netto_bnk IS NULL
    GROUP BY
        mandant_id,
        dat_von
);


UPDATE dbp_etl.lagerbestand_erp_tmpk_2 SET
    wrg_id = xx.wrg_id_,
    ek_netto_bnk = xx.ek_netto_bnk_ FROM (
    SELECT
        BLD.mandant_id AS mandant_id_,
        BLD.lagerort_id AS lagerort_id_,
        BLD.wup_id AS wup_id_,
        BLD.dat_von AS dat_von_,
        BLD.art_id AS art_id_,
        COALESCE(gld.wrg_id, BLD.wrg_id) AS wrg_id_,
        COALESCE(gld.gld, 0) AS ek_netto_bnk_
    FROM dbp_etl.lagerbestand_erp_tmpk_2 AS BLD
    LEFT JOIN (
        SELECT
            DT1.mandant_id,
            DT1.art_id,
            DT1.dat_gld,
            DT1.wrg_id,
            DT1.gld
        FROM dbp_data.art_bewertungskreis_tag_2 AS DT1
        INNER JOIN
            dbp_etl.kmo_mard_dat_2 AS DT2
            ON DT1.dat_gld = DT2.dat_von AND DT1.mandant_id = DT2.mandant_id
    ) AS gld
        ON
            BLD.art_id = gld.art_id
            AND BLD.mandant_id = gld.mandant_id
            AND BLD.dat_von = gld.dat_gld
    WHERE BLD.ek_netto_bnk IS NULL
    QUALIFY
        (ROW_NUMBER() OVER (
            PARTITION BY
                BLD.mandant_id,
                BLD.lagerort_id,
                BLD.wup_id,
                BLD.art_id,
                BLD.dat_von
            ORDER BY
                ek_netto_bnk_ IS NULL DESC, ek_netto_bnk_ DESC
        )) = 1
) AS xx
WHERE
    lagerbestand_erp_tmpk.mandant_id = xx.mandant_id_
    AND lagerbestand_erp_tmpk.dat_von = xx.dat_von_
    AND lagerbestand_erp_tmpk.lagerort_id = xx.lagerort_id_ AND lagerbestand_erp_tmpk.wup_id = xx.wup_id_
    AND lagerbestand_erp_tmpk.art_id = xx.art_id_ AND lagerbestand_erp_tmpk.ek_netto_bnk IS NULL;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.kmo_mard_dat_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.kmo_mard_dat_2 (mandant_id, dat_von)
(
    SELECT
        mandant_id,
        DATE_SUB(dat_von, INTERVAL 1 DAY)
    FROM dbp_etl.lagerbestand_erp_tmpk_2
    WHERE ek_netto_bnk = 0
    GROUP BY
        mandant_id,
        DATE_SUB(dat_von, INTERVAL 1 DAY)
);


UPDATE dbp_etl.lagerbestand_erp_tmpk_2 SET
    wrg_id = xx.wrg_id_,
    ek_netto_bnk = xx.ek_netto_bnk_ FROM (
    SELECT
        BLD.mandant_id AS mandant_id_,
        BLD.lagerort_id AS lagerort_id_,
        BLD.wup_id AS wup_id_,
        BLD.dat_von AS dat_von_,
        DATE_SUB(BLD.dat_von, INTERVAL 1 DAY) AS dat_von_1,
        BLD.art_id AS art_id_,
        COALESCE(gld.wrg_id, BLD.wrg_id) AS wrg_id_,
        COALESCE(gld.gld, 0) AS ek_netto_bnk_
    FROM dbp_etl.lagerbestand_erp_tmpk_2 AS BLD
    LEFT JOIN (
        SELECT
            DT1.mandant_id,
            DT1.art_id,
            DT1.dat_gld,
            DT1.wrg_id,
            DT1.gld
        FROM dbp_data.art_bewertungskreis_tag_2 AS DT1
        INNER JOIN
            dbp_etl.kmo_mard_dat_2 AS DT2
            ON DT1.dat_gld = DT2.dat_von AND DT1.mandant_id = DT2.mandant_id
    ) AS gld
        ON
            BLD.art_id = gld.art_id
            AND BLD.mandant_id = gld.mandant_id
            AND DATE_SUB(BLD.dat_von, INTERVAL 1 DAY
            ) = gld.dat_gld
    WHERE BLD.ek_netto_bnk = 0
    QUALIFY
        (ROW_NUMBER() OVER (
            PARTITION BY
                BLD.mandant_id,
                BLD.lagerort_id,
                BLD.wup_id,
                BLD.art_id,
                dat_von_1
            ORDER BY
                ek_netto_bnk_ IS NULL DESC, ek_netto_bnk_ DESC
        )) = 1
) AS xx
WHERE
    lagerbestand_erp_tmpk.mandant_id = xx.mandant_id_
    AND lagerbestand_erp_tmpk.dat_von = xx.dat_von_
    AND lagerbestand_erp_tmpk.lagerort_id = xx.lagerort_id_ AND lagerbestand_erp_tmpk.wup_id = xx.wup_id_
    AND lagerbestand_erp_tmpk.art_id = xx.art_id_ AND lagerbestand_erp_tmpk.ek_netto_bnk = 0;


UPDATE dbp_etl.lagerbestand_erp_tmpk_2 SET
    vk_netto = x.vk_netto_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.dat_von AS dat_von_,
        A.dat_bis AS dat_bis_,
        A.art_id AS art_id_,
        COALESCE(AP.vk_brutto, 0) AS vk_brutto_,
        CAST(COALESCE(AP.vk_brutto, 0) / CASE
            WHEN MWST.mwst_id IS NULL
                THEN 1
            ELSE 1 + MWST.mwst / 100
        END AS NUMERIC) AS vk_netto_
    FROM dbp_etl.lagerbestand_erp_tmpk_2 AS A
    INNER JOIN
        dbp_data.art_2 AS ART_2
        ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
    INNER JOIN dbp_data.mwst_per_2 AS MWST
        ON
            A.mandant_id = MWST.mandant_id AND ART.mwst_id = MWST.mwst_id
            AND A.dat_von BETWEEN MWST.dat_von AND MWST.dat_bis
    LEFT JOIN dbp_data.art_pm_vw_zu_per_2 AS AP
        ON
            A.mandant_id = AP.mandant_id AND A.art_id = AP.art_id
            AND A.dat_von BETWEEN AP.dat_von AND AP.dat_bis AND AP.preistyp_id = 0 AND AP.pm_id = 1 AND AP.vw_id IN (10, 90)
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            A.mandant_id, A.dat_von, A.dat_bis, A.art_id ORDER BY
            ABS(AP.vk_brutto)
            IS NULL DESC, ABS(AP.vk_brutto) DESC
    )) = 1
) AS x
WHERE
    lagerbestand_erp_tmpk.mandant_id = x.mandant_id_
    AND lagerbestand_erp_tmpk.dat_von = x.dat_von_
    AND lagerbestand_erp_tmpk.dat_bis = x.dat_bis_ AND lagerbestand_erp_tmpk.art_id = x.art_id_;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.lagerbestand_erp_per_2
WHERE (
    mandant_id, wup_id, lagerort_id, art_id, dat_von) IN (
    SELECT (mandant_id, wup_id, lagerort_id, art_id, dat_von)
    FROM dbp_etl.lagerbestand_erp_tmpk_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.lagerbestand_erp_tmp3_2 (
    wup_id, mandant_id, nb_id, lagerort_id, art_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    dat_von,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    dat_bis,
    betrag_lgbest_erp,
    wrg_id,
    vk_netto_lgbest_erp
)
(
    SELECT
        L.wup_id,
        L.mandant_id,
        L.nb_id,
        L.lagerort_id,
        L.art_id,
        L.menge_lgbest_erp_frei_bme,
        L.menge_lgbest_erp_umlag_bme,
        L.menge_lgbest_erp_qual_bme,
        L.menge_lgbest_erp_nf_charge_bme,
        L.menge_lgbest_erp_gesp_bme,
        L.menge_lgbest_erp_ret_gesp_bme,
        L.sperr_id,
        L.gjmo_buch,
        L.lagerort_loesch_fg,
        L.pflege_status,
        L.dat_von,
        L.menge_lgbest_erp_kolli,
        -- das korrekte dat_bis ist dat_von des Nachfolgers - 1
        L.menge_lgbest_erp_palette
        ,
        DATE_SUB(T.dat_von, INTERVAL 1 DAY),
        L.betrag_lgbest_erp,
        L.wrg_id,
        L.vk_netto_lgbest_erp
    FROM dbp_data.lagerbestand_erp_per_2 AS L
    INNER JOIN
        dbp_etl.lagerbestand_erp_tmpk_2
            AS T
        ON
            L.wup_id = T.wup_id AND L.mandant_id = T.mandant_id
            AND L.nb_id = T.nb_id
            AND L.lagerort_id = T.lagerort_id
            AND L.art_id = T.art_id
            -- das dat_von des neuen Satzes muss zwischen dem dat_von und dat_bis des alten liegen
            AND T.dat_von BETWEEN L.dat_von
            AND L.dat_bis
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.lagerbestand_erp_per_2
WHERE (
    mandant_id, wup_id, lagerort_id, art_id, dat_von) IN (
    SELECT (mandant_id, wup_id, lagerort_id, art_id, dat_von)
    FROM dbp_etl.lagerbestand_erp_tmp3_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.lagerbestand_erp_per_2 (
    wup_id, mandant_id, nb_id, lagerort_id, art_id, dat_von,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    dat_bis,
    betrag_lgbest_erp,
    wrg_id,
    vk_netto_lgbest_erp,
    td_insert
)
(SELECT
    wup_id,
    mandant_id,
    nb_id,
    lagerort_id,
    art_id,
    dat_von,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    dat_bis,
    betrag_lgbest_erp,
    wrg_id,
    vk_netto_lgbest_erp,
    CURRENT_TIMESTAMP()
FROM dbp_etl.lagerbestand_erp_tmp3_2);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Palettenfaktor und Default Mengeneinheit holen
-- Umrechnungsfaktor für Default Mengeneinheit holen
INSERT INTO
dbp_data.lagerbestand_erp_per_2 (
    wup_id, mandant_id, nb_id, lagerort_id, art_id, dat_von,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_umlag_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_nf_charge_bme,
    menge_lgbest_erp_gesp_bme,
    menge_lgbest_erp_ret_gesp_bme,
    sperr_id,
    gjmo_buch,
    lagerort_loesch_fg,
    pflege_status,
    menge_lgbest_erp_kolli,
    menge_lgbest_erp_palette,
    dat_bis,
    betrag_lgbest_erp,
    wrg_id,
    vk_netto_lgbest_erp,
    td_insert
)
(
    SELECT
        T.wup_id,
        T.mandant_id,
        T.nb_id,
        T.lagerort_id,
        T.art_id,
        T.dat_von,
        T.menge_lgbest_erp_frei_bme,
        T.menge_lgbest_erp_umlag_bme,
        T.menge_lgbest_erp_qual_bme,
        T.menge_lgbest_erp_nf_charge_bme,
        T.menge_lgbest_erp_gesp_bme,
        T.menge_lgbest_erp_ret_gesp_bme,
        T.sperr_id,
        T.gjmo_buch,
        T.lagerort_loesch_fg,
        T.pflege_status,
        CAST(
            (
                T.menge_lgbest_erp_frei_bme
                + T.menge_lgbest_erp_umlag_bme
                + T.menge_lgbest_erp_qual_bme
                + T.menge_lgbest_erp_gesp_bme
                + T.menge_lgbest_erp_ret_gesp_bme
            )
            * CASE
                WHEN aukolli.umrech_faktor IS NULL
                    THEN 1
                ELSE aukolli.umrech_faktor
            END AS NUMERIC
        ) AS menge_lgbest_erp_kolli,
        CAST(CASE
            WHEN aupalette.umrech_faktor IS NULL
                THEN NULL
            ELSE ROUND(
                CAST(
                    (
                        T.menge_lgbest_erp_frei_bme
                        + T.menge_lgbest_erp_umlag_bme
                        + T.menge_lgbest_erp_qual_bme
                        + T.menge_lgbest_erp_gesp_bme
                        + T.menge_lgbest_erp_ret_gesp_bme
                    )
                    * aupalette.umrech_faktor AS NUMERIC
                ),
                3
            )
        END AS NUMERIC) AS menge_lgbest_erp_palette,
        T.dat_bis,
        ROUND(CAST(
            (
                T.menge_lgbest_erp_frei_bme
                + T.menge_lgbest_erp_gesp_bme
                + T.menge_lgbest_erp_qual_bme
                + T.menge_lgbest_erp_ret_gesp_bme
                + T.menge_lgbest_erp_umlag_bme
            )
            * CAST(T.ek_netto_bnk AS FLOAT64)
            AS NUMERIC
        ), 2) AS betrag_lgbest_erp,
        T.wrg_id,
        COALESCE(ROUND(CAST(
            (
                T.menge_lgbest_erp_frei_bme
                + T.menge_lgbest_erp_umlag_bme
                + T.menge_lgbest_erp_qual_bme
                + T.menge_lgbest_erp_gesp_bme
                + T.menge_lgbest_erp_ret_gesp_bme
            )
            * CAST(T.vk_netto AS FLOAT64)
            AS NUMERIC
        ), 4), 0) AS vk_netto_lgbest_erp,
        CURRENT_TIMESTAMP()
    FROM dbp_etl.lagerbestand_erp_tmpk_2 AS T
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        paletten_faktor_einh_id,
        ausg_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_vorschlagswert_per_2) AS av
        ON T.art_id = av.art_id AND T.mandant_id = av.mandant_id
        -- Umrechnungsfaktor für Palettenfaktor holen
        AND T.dat_von BETWEEN av.dat_von AND av.dat_bis

    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        umrech_faktor,
        altnv_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aupalette
        ON
            T.art_id = aupalette.art_id AND T.mandant_id
            = aupalette.mandant_id
            AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
            AND T.dat_von BETWEEN
            -- Umrechnungsfaktor für Default Mengeneinheit holen
            aupalette.dat_von AND aupalette.dat_bis

    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aukolli
        ON
            T.art_id = aukolli.art_id AND T.mandant_id
            = aukolli.mandant_id AND av.ausg_menge_einh_id = aukolli.altnv_menge_einh_id AND T.dat_von BETWEEN aukolli.dat_von
            -- Default Palettenfaktor und Mengeneinheit holen
            AND aukolli.dat_bis

    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        paletten_faktor_einh_id,
        ausg_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_vorschlagswert_per_2) AS av_q
        ON T.art_id = av_q.art_id AND T.mandant_id = av_q.mandant_id
        -- Umrechnungsfaktor für Palettenfaktor holen
        AND T.dat_von BETWEEN av_q.dat_von AND av_q.dat_bis

    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        umrech_faktor,
        altnv_menge_einh_id,
        dat_von,
        dat_bis
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aupalette_q
        ON
            T.art_id = aupalette_q.art_id AND T.mandant_id
            = aupalette_q.mandant_id
            AND aupalette_q.altnv_menge_einh_id = 'PAL'
            AND aupalette_q.dat_bis = PARSE_DATE(
                '%F',
                '9999-12-31'
            )
    LEFT JOIN (SELECT
        mandant_id,
        art_id,
        altnv_menge_einh_id,
        dat_von,
        dat_bis,
        umrech_faktor
    FROM dbp_data.art_umrechnung_faktor_per_2) AS aukolli_q
        ON
            T.art_id = aukolli_q.art_id AND T.mandant_id
            = aukolli_q.mandant_id
            AND av_q.ausg_menge_einh_id = aukolli_q.altnv_menge_einh_id
            AND aukolli_q.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.bestand_mardh_mard_vz_log_kmo_2 (
    art_id, mandant_id, wup_id, nb_id, lagerort_id, dat
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        lagerort_id,
        dat_von
    FROM dbp_etl.lagerbestand_erp_tmpk_2
    WHERE
        (art_id, mandant_id, wup_id, nb_id, lagerort_id, dat_von) NOT IN (
            SELECT (
                art_id, mandant_id, wup_id, nb_id,
                lagerort_id, dat
            )
            FROM dbp_etl.bestand_mardh_mard_vz_log_kmo_2
        )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        lagerort_id,
        art_id,
        dat_von
);
