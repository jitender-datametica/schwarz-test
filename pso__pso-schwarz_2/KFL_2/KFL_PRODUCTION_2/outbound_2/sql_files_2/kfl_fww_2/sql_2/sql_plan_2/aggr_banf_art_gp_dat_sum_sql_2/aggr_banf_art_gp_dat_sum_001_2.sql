DROP TABLE IF EXISTS dbp_etl.banf_agg_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.banf_agg_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_kalk DATE NOT NULL,
    dat_lief_soll DATE NOT NULL,
    in_aktion_fg INTEGER DEFAULT 0 NOT NULL,
    vk_brutto NUMERIC(29, 2) NOT NULL,
    banf_menge_kolli NUMERIC(29, 3) NOT NULL,
    forecast_menge_kolli NUMERIC(29, 3),
    menge_best_kolli NUMERIC(29, 3) NOT NULL,
    banf_menge_kg NUMERIC(29, 3) NOT NULL,
    forecast_menge_kg NUMERIC(29, 3),
    menge_best_kg NUMERIC(29, 3) NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.best_agg_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.best_agg_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_kalk DATE NOT NULL,
    dat_lief_soll DATE NOT NULL,
    in_aktion_fg INTEGER DEFAULT 0 NOT NULL,
    vk_brutto NUMERIC(29, 2) NOT NULL,
    banf_menge_kolli NUMERIC(29, 3) NOT NULL,
    forecast_menge_kolli NUMERIC(29, 3),
    menge_best_kolli NUMERIC(29, 3) NOT NULL,
    banf_menge_kg NUMERIC(29, 3) NOT NULL,
    forecast_menge_kg NUMERIC(29, 3),
    menge_best_kg NUMERIC(29, 3) NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.ofc_agg_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.ofc_agg_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_kalk DATE NOT NULL,
    dat_lief_soll DATE NOT NULL,
    in_aktion_fg INTEGER DEFAULT 0 NOT NULL,
    vk_brutto NUMERIC(29, 2) NOT NULL,
    banf_menge_kolli NUMERIC(29, 3) NOT NULL,
    forecast_menge_kolli NUMERIC(29, 3),
    menge_best_kolli NUMERIC(29, 3) NOT NULL,
    banf_menge_kg NUMERIC(29, 3) NOT NULL,
    forecast_menge_kg NUMERIC(29, 3),
    menge_best_kg NUMERIC(29, 3) NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.banf_art_gp_dat_sum_tmp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.banf_art_gp_dat_sum_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_kalk DATE NOT NULL,
    dat_lief_soll DATE NOT NULL,
    in_aktion_fg INTEGER DEFAULT 0 NOT NULL,
    vk_brutto NUMERIC(29, 2) NOT NULL,
    banf_menge_kolli NUMERIC(29, 3) NOT NULL,
    forecast_menge_kolli NUMERIC(29, 3),
    menge_best_kolli NUMERIC(29, 3) NOT NULL,
    banf_menge_kg NUMERIC(29, 3) NOT NULL,
    forecast_menge_kg NUMERIC(29, 3),
    menge_best_kg NUMERIC(29, 3) NOT NULL
);


-- Umrechnungsfaktor fuer Menge in 'KG' holen
-- 'nur' Artikel_2 bestimmter Lieferanten duerfen ausgewertet werden

INSERT INTO dbp_etl.banf_agg_tmp_2 (
    mandant_id, art_id, wup_id, nb_id, gp_id, dat_kalk, dat_lief_soll,
    in_aktion_fg, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg, forecast_menge_kg,
    menge_best_kg
)
(
    SELECT
        EO.mandant_id,
        EO.art_id,
        EO.wup_id,
        EO.nb_id,
        EO.gp_id,
        TAG.dat AS dat_kalk_,
        COALESCE(BD.dat_lief_soll, DATE('1900-01-01')) AS dat_lief_soll_,
        0 AS in_aktion_fg,
        0 AS vk_brutto,
        CAST(ROUND(SUM(ROUND(CAST(COALESCE(BD.banf_menge, 0) / COALESCE(CAST(AUEI.umrech_zaehler AS FLOAT64) / CAST(AUEI.umrech_nenner AS FLOAT64), 1) AS NUMERIC), 3)), 0) AS INTEGER)
            AS banf_menge_kolli,
        0 AS forecast_menge_kolli,
        0 AS menge_best_kolli,
        SUM(
            ROUND(CAST(COALESCE(BD.banf_menge, 0) * CAST(COALESCE(AUKG.umrech_faktor, 1) AS FLOAT64) AS NUMERIC), 3)) AS
        banf_menge_kg,
        0 AS forecast_menge_kg,
        0 AS menge_best_kg
    FROM dbp_data.tag_2 AS TAG_2
    INNER JOIN dbp_data.ek_orderbuch_2 AS EO ON TAG.dat BETWEEN EO.dat_von AND EO.dat_bis
    -- keine Artikel_2 mit loesch_id = 'L' bzw. loesch_id = 'R'

    INNER JOIN dbp_data.art_2 AS A
        ON
            EO.mandant_id = A.mandant_id AND EO.art_id = A.art_id AND A.mandant_id
            = 1 AND A.loesch_id <> 'L' AND A.loesch_id <> 'R'
    INNER JOIN dbp_data.banf_prognose_gp_filter_2 AS BPGF
        ON
            EO.mandant_id = BPGF.mandant_id AND EO.gp_id =
            BPGF.gp_id -- MengenEinheit fuer die Mengenumrechnung einholen

    INNER JOIN dbp_data.ek_infosatz_2 AS EI ON EO.mandant_id = EI.mandant_id AND EO.art_id = EI.art_id AND EO.gp_id = EI.gp_id AND TAG.dat BETWEEN EI.dat_von AND EI.dat_bis
    -- als Basis dienen die MARA_2 & EORD_2 (EK_ORDERBUCH_2) Daten, eine_2 entspr. BANF kann, muß es aber nicht geben

    LEFT JOIN dbp_data.banf_det_2 AS BD
        ON
            EO.mandant_id = BD.mandant_id AND EO.wup_id = BD.wup_id AND EO.nb_id
            = BD.nb_id AND EO.art_id = BD.art_id AND TAG.dat = BD.dat_banf_beleg AND BD.dat_lief_soll BETWEEN DATE(${DAT_KALK}
            ) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 10 DAY))
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUKG
        ON
            EO.art_id = AUKG.art_id AND EO.mandant_id =
            AUKG.mandant_id AND 'KG' = TRIM(AUKG.altnv_menge_einh_id) AND TAG.dat BETWEEN AUKG.dat_von AND AUKG.dat_bis
    -- Umrechnungsfaktor fuer Menge in'Kolli' holen

    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUEI
        ON
            EO.art_id = AUEI.art_id AND EO.mandant_id =
            AUEI.mandant_id AND EI.menge_einh_id = TRIM(AUEI.altnv_menge_einh_id) AND TAG.dat BETWEEN AUEI.dat_von AND AUEI.dat_bis
    -- es werden lediglich DE Daten betrachtet

    WHERE
        EO.mandant_id = 1
        AND TAG.dat = DATE(${DAT_KALK})
        AND (
            EO.mandant_id, EO.wup_id) NOT IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_data.wup_instanz_autodispo_2
            WHERE
                instanz = '001'
                AND modus = 'VPD'
        )
    GROUP BY
        EO.mandant_id,
        EO.wup_id,
        EO.nb_id,
        EO.art_id,
        EO.gp_id,
        dat_kalk_,
        dat_lief_soll_,
        in_aktion_fg,
        vk_brutto
);


-- wurde konzeptionell nicht definiert, beruht auf Erfahrungswerten--
-- Umrechnungsfaktor fuer Menge in 'KG' holen

-- 'nur' Artikel_2 bestimmter Lieferanten duerfen ausgewertet werden
-- lief_einteilung_2
INSERT INTO
dbp_etl.best_agg_tmp_2 (
    mandant_id, art_id, wup_id, nb_id, gp_id, dat_kalk, dat_lief_soll, in_aktion_fg,
    vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg, forecast_menge_kg, menge_best_kg
)
(
    SELECT
        EO.mandant_id,
        EO.art_id,
        EO.wup_id,
        EO.nb_id,
        EO.gp_id,
        TAG.dat AS dat_kalk_,
        COALESCE(best.dat_lief_wunsch, DATE('1900-01-01')) AS dat_lief_soll_,
        0 AS in_aktion_fg,
        0 AS vk_brutto,
        0 AS banf_menge_kolli,
        0 AS forecast_menge_kolli,
        SUM(COALESCE(best.menge_best_kolli, 0)) AS menge_best_kolli,
        0 AS banf_menge_kg,
        0 AS forecast_menge_kg,
        SUM(ROUND(
            CAST(COALESCE(best.menge_best_kolli, 0) * (COALESCE(CAST(AUEI.umrech_zaehler AS FLOAT64) / CAST(AUEI.umrech_nenner AS FLOAT64), 1) / COALESCE(CAST(AUKG.umrech_zaehler AS FLOAT64) / CAST(AUKG.umrech_nenner AS FLOAT64), 1)) AS NUMERIC),
            3
        )) AS menge_best_kg
    FROM dbp_data.tag_2 AS TAG_2
    INNER JOIN dbp_data.ek_orderbuch_2 AS EO ON TAG.dat BETWEEN EO.dat_von AND EO.dat_bis
    -- keine Artikel_2 mit loesch_id = 'L' bzw. loesch_id = 'R'

    INNER JOIN dbp_data.art_2 AS A
        ON
            EO.mandant_id = A.mandant_id AND EO.art_id = A.art_id AND A.mandant_id
            = 1 AND A.loesch_id <> 'L' AND A.loesch_id <> 'R'
    INNER JOIN dbp_data.banf_prognose_gp_filter_2 AS BPGF
        ON
            EO.mandant_id = BPGF.mandant_id AND EO.gp_id =
            BPGF.gp_id -- MengenEinheit fuer die Mengenumrechnung einholen

    INNER JOIN dbp_data.ek_infosatz_2 AS EI ON EO.mandant_id = EI.mandant_id AND EO.art_id = EI.art_id AND EO.gp_id = EI.gp_id AND TAG.dat BETWEEN EI.dat_von AND EI.dat_bis
    -- als Basis dienen die MARA_2 & EORD_2 (EK_ORDERBUCH_2) Daten, eine_2 entspr. BESTELLUNG  kann, muß es aber nicht geben

    LEFT JOIN (
        SELECT
            BB.mandant_id,
            BBD.best_beleg_id,
            BBD.best_beleg_pos_id,
            BBD.wup_id,
            BBD.nb_id,
            BBD.art_id,
            BB.gp_id,
            t1.dat_lief_wunsch,
            BBD.menge_best_kolli,
            BBD.menge_best_bme
        FROM dbp_data.besch_best_det_2 AS BBD
        INNER JOIN dbp_data.besch_best_2 AS BB
            ON
                BBD.mandant_id = BB.mandant_id AND BBD.best_beleg_id = BB.best_beleg_id
                AND BBD.dat_best_beleg = BB.dat_best_beleg AND BBD.mandant_id = 1 AND BB.loesch_fg <> 1
                -- geloeschte Koepfe sollen ausgeschlossen werden
                AND BBD.loesch_fg <> 1
                -- geloeschte Positionen sollen ausgeschlossen werden
                AND BBD.dat_best_beleg BETWEEN DATE_SUB(
                    DATE(${DAT_KALK}),
                    INTERVAL 180 DAY
                ) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 15 DAY)
                )
        INNER JOIN (
            SELECT *
            FROM dbp_data.lief_einteilung_2 AS BBEST
            WHERE dat_lief_wunsch IN (
                SELECT dat
                FROM dbp_data.tag_2
                WHERE
                    dat BETWEEN DATE_SUB(DATE(${DAT_KALK}), INTERVAL 3 DAY) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 15 DAY)
                    )
            )
        ) AS t1_2
            ON TRUE
        WHERE
            t1.mandant_id = BBD.mandant_id
            AND t1.best_beleg_id = BBD.best_beleg_id
            AND t1.best_beleg_pos_id = BBD.best_beleg_pos_id
    ) AS best
        ON
            EO.mandant_id = best.mandant_id AND EO.wup_id = best.wup_id
            AND EO.nb_id = best.nb_id AND EO.art_id = best.art_id -- AND tag.dat =  best.dat_lief_wunsch
            AND best.dat_lief_wunsch
            BETWEEN DATE(${DAT_KALK}) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 10 DAY))
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUKG
        ON
            EO.art_id = AUKG.art_id AND EO.mandant_id =
            AUKG.mandant_id AND 'KG' = TRIM(AUKG.altnv_menge_einh_id) AND TAG.dat BETWEEN AUKG.dat_von AND AUKG.dat_bis
    -- Umrechnungsfaktor fuer Menge in'Kolli' holen

    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUEI
        ON
            EO.art_id = AUEI.art_id AND EO.mandant_id =
            AUEI.mandant_id AND EI.menge_einh_id = TRIM(AUEI.altnv_menge_einh_id) AND TAG.dat BETWEEN AUEI.dat_von AND AUEI.dat_bis
    -- es werden lediglich DE Daten betrachtet

    WHERE
        EO.mandant_id = 1
        AND TAG.dat = DATE(${DAT_KALK})
        AND (
            EO.mandant_id, EO.wup_id) NOT IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_data.wup_instanz_autodispo_2
            WHERE
                instanz = '001'
                AND modus = 'VPD'
        )
    GROUP BY
        EO.mandant_id,
        EO.wup_id,
        EO.nb_id,
        EO.art_id,
        EO.gp_id,
        dat_kalk_,
        dat_lief_soll_,
        in_aktion_fg,
        vk_brutto
);


-- Umrechnungsfaktor fuer Menge in 'KG' holen
-- 'nur' Artikel_2 bestimmter Lieferanten duerfen ausgewertet werden

INSERT INTO dbp_etl.ofc_agg_tmp_2 (
    mandant_id, art_id, wup_id, nb_id, gp_id, dat_kalk, dat_lief_soll,
    in_aktion_fg, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg, forecast_menge_kg,
    menge_best_kg
)
(
    SELECT
        EO.mandant_id,
        EO.art_id,
        EO.wup_id,
        EO.nb_id,
        EO.gp_id,
        TAG.dat AS dat_kalk_,
        COALESCE(BF.dat_lief_soll, DATE('1900-01-01')) AS dat_lief_soll_,
        0 AS in_aktion_fg,
        0 AS vk_brutto,
        0 AS banf_menge_kolli,
        CAST(ROUND(SUM(COALESCE(BF.forecast_menge_kolli, 0)), 0) AS INTEGER) AS forecast_menge_kolli,
        0 AS menge_best_kolli,
        0 AS banf_menge_kg,
        SUM(ROUND(
            CAST(COALESCE(BF.forecast_menge_kolli, 0) * (COALESCE(
                CAST(AUEI.umrech_zaehler AS FLOAT64) / CAST(AUEI.umrech_nenner AS FLOAT64),
                1
            ) / COALESCE(CAST(AUKG.umrech_zaehler AS FLOAT64) / CAST(AUKG.umrech_nenner AS FLOAT64), 1
            )) AS NUMERIC), 3
        )) AS forecast_menge_kg,
        0 AS menge_best_kg
    FROM dbp_data.tag_2 AS TAG_2
    INNER JOIN dbp_data.ek_orderbuch_2 AS EO ON TAG.dat BETWEEN EO.dat_von AND EO.dat_bis
    -- keine Artikel_2 mit loesch_id = 'L' bzw. loesch_id = 'R'

    INNER JOIN dbp_data.art_2 AS A
        ON
            EO.mandant_id = A.mandant_id AND EO.art_id = A.art_id AND A.mandant_id
            = 1 AND A.loesch_id <> 'L' AND A.loesch_id <> 'R'
    INNER JOIN dbp_data.banf_prognose_gp_filter_2 AS BPGF
        ON
            EO.mandant_id = BPGF.mandant_id AND EO.gp_id =
            BPGF.gp_id -- MengenEinheit fuer die Mengenumrechnung einholen

    INNER JOIN dbp_data.ek_infosatz_2 AS EI ON EO.mandant_id = EI.mandant_id AND EO.art_id = EI.art_id AND EO.gp_id = EI.gp_id AND TAG.dat BETWEEN EI.dat_von AND EI.dat_bis
    -- als Basis dienen die MARA_2 & EORD_2 (EK_ORDERBUCH_2) Daten, einen entspr. Forecast kann, muß es aber nicht geben

    LEFT JOIN dbp_data.banf_forecast_2 AS BF
        ON
            EO.mandant_id = BF.mandant_id AND EO.wup_id = BF.wup_id AND
            EO.nb_id = BF.nb_id AND EO.art_id = BF.art_id AND TAG.dat = BF.dat_plan -- variabel:

            -- AND ofc.art_id IN (2841501, 5105200, 1278100, 1134601)
            -- AND eo.gp_id = 6912
            AND BF.dat_lief_soll BETWEEN
            DATE(${DAT_KALK}) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 10 DAY))
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUKG
        ON
            EO.art_id = AUKG.art_id AND EO.mandant_id =
            AUKG.mandant_id AND 'KG' = TRIM(AUKG.altnv_menge_einh_id) AND TAG.dat BETWEEN AUKG.dat_von AND AUKG.dat_bis
    -- Umrechnungsfaktor fuer Menge in'Kolli' holen

    LEFT JOIN dbp_data.art_umrechnung_faktor_per_2 AS AUEI
        ON
            EO.art_id = AUEI.art_id AND EO.mandant_id =
            AUEI.mandant_id AND EI.menge_einh_id = TRIM(AUEI.altnv_menge_einh_id) AND TAG.dat BETWEEN AUEI.dat_von AND AUEI.dat_bis
    -- es werden lediglich DE Daten betrachtet

    WHERE
        EO.mandant_id = 1
        AND TAG.dat = DATE(${DAT_KALK})
        AND (
            EO.mandant_id, EO.wup_id) NOT IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_data.wup_instanz_autodispo_2
            WHERE
                instanz = '001'
                AND modus = 'VPD'
        )
    GROUP BY
        EO.mandant_id,
        EO.wup_id,
        EO.nb_id,
        EO.art_id,
        EO.gp_id,
        dat_kalk_,
        dat_lief_soll_,
        in_aktion_fg,
        vk_brutto
);


INSERT INTO dbp_etl.banf_art_gp_dat_sum_tmp_2 (
    mandant_id, art_id, wup_id, nb_id, gp_id, dat_kalk,
    dat_lief_soll, in_aktion_fg, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg,
    forecast_menge_kg, menge_best_kg
)
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        gp_id,
        dat_kalk,
        dat_lief_soll,
        in_aktion_fg,
        vk_brutto,
        SUM(banf_menge_kolli) AS banf_menge_kolli,
        SUM(forecast_menge_kolli) AS forecast_menge_kolli,
        SUM(menge_best_kolli) AS menge_best_kolli,
        SUM(banf_menge_kg) AS banf_menge_kg,
        SUM(forecast_menge_kg) AS forecast_menge_kg,
        SUM(menge_best_kg) AS menge_best_kg
    FROM (SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        gp_id,
        dat_kalk,
        dat_lief_soll,
        in_aktion_fg,
        vk_brutto,
        banf_menge_kolli,
        forecast_menge_kolli,
        menge_best_kolli,
        banf_menge_kg,
        forecast_menge_kg,
        menge_best_kg
    FROM dbp_etl.banf_agg_tmp_2
    UNION ALL
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        gp_id,
        dat_kalk,
        dat_lief_soll,
        in_aktion_fg,
        vk_brutto,
        banf_menge_kolli,
        forecast_menge_kolli,
        menge_best_kolli,
        banf_menge_kg,
        forecast_menge_kg,
        menge_best_kg
    FROM dbp_etl.best_agg_tmp_2
    UNION ALL
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        gp_id,
        dat_kalk,
        dat_lief_soll,
        in_aktion_fg,
        vk_brutto,
        banf_menge_kolli,
        forecast_menge_kolli,
        menge_best_kolli,
        banf_menge_kg,
        forecast_menge_kg,
        menge_best_kg
    FROM dbp_etl.ofc_agg_tmp_2) AS x
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        gp_id,
        dat_kalk,
        dat_lief_soll,
        in_aktion_fg,
        vk_brutto
);


DELETE FROM dbp_etl.banf_art_gp_dat_sum_tmp_2
WHERE
    banf_menge_kolli = 0 AND forecast_menge_kolli = 0 AND menge_best_kolli = 0 AND banf_menge_kg = 0 AND
    forecast_menge_kg = 0 AND menge_best_kg = 0;


UPDATE dbp_etl.banf_art_gp_dat_sum_tmp_2 SET
    vk_brutto = x.vk_brutto_,
    in_aktion_fg = x.in_aktion_fg_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.wup_id AS wup_id_,
        A.nb_id AS nb_id_,
        A.dat_lief_soll AS dat_lief_soll_,
        A.art_id AS art_id_,
        0 AS in_aktion_fg_,
        COALESCE(AWVP.vk_brutto, 0) AS vk_brutto_
    FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS A
    INNER JOIN dbp_data.art_2 AS ART_2 ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
    -- Auflösung Normalpreise Markt--

    LEFT JOIN dbp_data.art_wup_vk_per_2 AS AWVP
        ON
            A.mandant_id = AWVP.mandant_id AND A.art_id = AWVP.art_id
            AND A.wup_id = AWVP.wup_id AND A.nb_id = AWVP.nb_id AND A.dat_lief_soll BETWEEN AWVP.dat_von AND AWVP.dat_bis
    WHERE
        A.mandant_id = 1
        AND A.nb_id = 0 -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --
) AS x
WHERE
    banf_art_gp_dat_sum_tmp.mandant_id = x.mandant_id_ AND banf_art_gp_dat_sum_tmp.wup_id = x.wup_id_ AND
    banf_art_gp_dat_sum_tmp.nb_id = x.nb_id_ AND banf_art_gp_dat_sum_tmp.dat_lief_soll = x.dat_lief_soll_ AND
    banf_art_gp_dat_sum_tmp.art_id = x.art_id_;


UPDATE dbp_etl.banf_art_gp_dat_sum_tmp_2 SET
    vk_brutto = x.vk_brutto_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.dat_lief_soll AS dat_lief_soll_,
        A.art_id AS art_id_,
        COALESCE(AP.vk_brutto, 0) AS vk_brutto_
    FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS A
    INNER JOIN dbp_data.art_2 AS ART_2 ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
    LEFT JOIN dbp_data.art_pm_vw_zu_per_2 AS AP
        ON
            AP.mandant_id = 1 AND A.art_id = AP.art_id AND A.dat_lief_soll
            BETWEEN AP.dat_von AND AP.dat_bis AND AP.preistyp_id = 0 AND AP.pm_id = 1 AND AP.vw_id = 6
    WHERE
        A.mandant_id = 1
        AND A.nb_id = -111 -- hier werden nur die VZ's mit vk_brutto versorgt --

    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            A.mandant_id, A.dat_lief_soll, A.art_id ORDER BY
            ABS(AP.vk_brutto) IS NULL
            DESC, ABS(AP.vk_brutto) DESC
    )) = 1
) AS x
WHERE
    banf_art_gp_dat_sum_tmp.mandant_id = x.mandant_id_ AND banf_art_gp_dat_sum_tmp.dat_lief_soll = x.dat_lief_soll_
    AND banf_art_gp_dat_sum_tmp.art_id = x.art_id_;


DROP TABLE IF EXISTS dbp_etl.wupcal_zukunft_2;


CREATE TABLE IF NOT EXISTS dbp_etl.wupcal_zukunft_2 AS
SELECT
    W.mandant_id,
    W.wup_id,
    T.dat,
    COALESCE(WE.offen, 1) AS offen
FROM dbp_data.wup_2 AS W
INNER JOIN dbp_data.tag_2 AS T ON TRUE
LEFT JOIN dbp_data.wupcal_ereignis_zu_2 AS WE
    ON
        W.mandant_id = WE.mandant_id AND W.wup_id = WE.wup_id AND
        T.dat = WE.dat
WHERE
    T.dat BETWEEN DATE_SUB(DATE(${DAT_KALK}), INTERVAL 7 DAY) AND (DATE_ADD(DATE(${DAT_KALK}), INTERVAL 14 DAY))
    AND W.mandant_id = 1;


DROP TABLE IF EXISTS dbp_etl.wupcal_letzter_naechster_2;


CREATE TABLE IF NOT EXISTS dbp_etl.wupcal_letzter_naechster_2 AS
SELECT
    W.mandant_id,
    W.wup_id,
    W.dat,
    W.offen,
    MIN(W1.dat) AS naechster_offener_tag,
    MAX(W2.dat) AS letzter_offener_tag,
    COALESCE(DATE_DIFF(MIN(W1.dat), W.dat, DAY), 0) AS diff_tage_naechster
FROM dbp_etl.wupcal_zukunft_2 AS W
LEFT JOIN dbp_etl.wupcal_zukunft_2 AS W1
    ON
        W.mandant_id = W1.mandant_id AND W.wup_id = W1.wup_id AND W.dat
        < W1.dat AND W1.dat < DATE_ADD(W.dat, INTERVAL 7 DAY) AND W1.offen = 1
LEFT JOIN dbp_etl.wupcal_zukunft_2 AS W2
    ON
        W.mandant_id = W2.mandant_id AND W.wup_id = W2.wup_id AND W.dat
        > W2.dat AND W2.dat > DATE_SUB(W.dat, INTERVAL 7 DAY) AND W2.offen = 1
GROUP BY
    W.mandant_id,
    W.wup_id,
    W.dat,
    W.offen;


UPDATE dbp_etl.banf_art_gp_dat_sum_tmp_2 SET
    vk_brutto = x.vk_brutto_,
    in_aktion_fg = x.in_aktion_fg_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.wup_id AS wup_id_,
        A.dat_lief_soll AS dat_lief_soll_,
        A.art_id AS art_id_,
        A.nb_id AS nb_id_,
        1 AS in_aktion_fg_,
        COALESCE(dt1.vk_aktion_brutto, 0) AS vk_brutto_
    FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS A
    INNER JOIN dbp_data.art_2 AS ART_2 ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
    INNER JOIN dbp_etl.wupcal_letzter_naechster_2 AS NAECHST
        ON
            A.mandant_id = NAECHST.mandant_id AND A.wup_id
            = NAECHST.wup_id AND A.dat_lief_soll -- Auflösung Aktionspreise Markt--
            = NAECHST.dat
    INNER JOIN (
        SELECT
            AAWZ.art_id,
            AAWZ.wup_id,
            AAWZ.mandant_id,
            A0.dat_von,
            A0.dat_bis,
            AAWZ.vk_aktion_brutto,
            AAWZ.aktion_id
        FROM dbp_data.aktion_art_wup_zu_2 AS AAWZ
        INNER JOIN dbp_data.aktion_2 AS A0
            ON
                AAWZ.aktion_id = A0.aktion_id AND AAWZ.mandant_id = A0.mandant_id
                AND AAWZ.bewart_id = A0.bewart_id
        WHERE
            AAWZ.mandant_id = 1 -- nur MandantDeutschland

            AND AAWZ.nb_id = 0 -- nur Maerkte

            AND A0.bewart_id = 1002 -- Kennzeichen Aktion_2

            -- AND (UPPER(aawz.grund_sperrung) <> 'X'  OR aawz.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_2, Artikel_2, Wup_2 aktiv

            AND AAWZ.grund_sperrung IS NULL
    ) AS dt1
        ON
            A.art_id = dt1.art_id AND A.wup_id = dt1.wup_id AND A.mandant_id = dt1.mandant_id
            AND NAECHST.naechster_offener_tag BETWEEN dt1.dat_von AND dt1.dat_bis
    WHERE
        A.mandant_id = 1
        AND A.nb_id = 0 -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --

    QUALIFY (RANK() OVER (
        PARTITION BY
            A.mandant_id, A.wup_id, A.art_id, A.dat_lief_soll ORDER BY
            dt1.aktion_id IS NULL
            DESC, dt1.aktion_id DESC
    )) = 1
) AS x
WHERE
    banf_art_gp_dat_sum_tmp.mandant_id = x.mandant_id_ AND banf_art_gp_dat_sum_tmp.wup_id = x.wup_id_ AND
    banf_art_gp_dat_sum_tmp.dat_lief_soll = x.dat_lief_soll_ AND banf_art_gp_dat_sum_tmp.art_id = x.art_id_;


UPDATE dbp_etl.banf_art_gp_dat_sum_tmp_2 SET
    vk_brutto = x.vk_brutto_,
    in_aktion_fg = x.in_aktion_fg_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.wup_id AS wup_id_,
        A.dat_lief_soll AS dat_lief_soll_,
        A.art_id AS art_id_,
        1 AS in_aktion_fg_,
        COALESCE(dt1.vk_aktion_brutto, 0) AS vk_brutto_
    FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS A
    INNER JOIN dbp_data.art_2 AS ART_2 ON A.art_id = ART.art_id AND A.mandant_id = ART.mandant_id
    -- Auflösung Aktionspreise Markt--

    INNER JOIN (
        SELECT
            AAWZ.art_id,
            AAWZ.wup_id,
            AAWZ.mandant_id,
            A0.dat_von,
            A0.dat_bis,
            AAWZ.vk_aktion_brutto,
            AAWZ.aktion_id
        FROM dbp_data.aktion_art_wup_zu_2 AS AAWZ
        INNER JOIN dbp_data.aktion_2 AS A0
            ON
                AAWZ.aktion_id = A0.aktion_id AND AAWZ.mandant_id = A0.mandant_id
                AND AAWZ.bewart_id = A0.bewart_id
        WHERE
            AAWZ.mandant_id = 1 -- nur MandantDeutschland

            AND AAWZ.nb_id = 0 -- nur Maerkte

            AND A0.bewart_id = 1002 -- Kennzeichen Aktion_2

            -- AND (UPPER(aawz.grund_sperrung) <> 'X'  OR aawz.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion_2, Artikel_2, Wup_2 aktiv

            AND AAWZ.grund_sperrung IS NULL
    ) AS dt1
        ON
            A.art_id = dt1.art_id AND A.wup_id = dt1.wup_id AND A.mandant_id = dt1.mandant_id
            AND A.dat_lief_soll BETWEEN dt1.dat_von AND dt1.dat_bis
    WHERE
        A.mandant_id = 1
        AND A.nb_id = 0 -- hier werden nur die Filialen (keine VZ's) mit vk_brutto versorgt --

    QUALIFY (RANK() OVER (
        PARTITION BY
            A.mandant_id, A.wup_id, A.art_id, A.dat_lief_soll ORDER BY
            dt1.aktion_id IS NULL
            DESC, dt1.aktion_id DESC
    )) = 1
) AS x
WHERE
    banf_art_gp_dat_sum_tmp.mandant_id = x.mandant_id_ AND banf_art_gp_dat_sum_tmp.wup_id = x.wup_id_ AND
    banf_art_gp_dat_sum_tmp.dat_lief_soll = x.dat_lief_soll_ AND banf_art_gp_dat_sum_tmp.art_id = x.art_id_ AND (banf_art_gp_dat_sum_tmp.in_aktion_fg = 0 OR banf_art_gp_dat_sum_tmp.in_aktion_fg = 1 AND x.vk_brutto_ < banf_art_gp_dat_sum_tmp.vk_brutto);


UPDATE dbp_etl.banf_art_gp_dat_sum_tmp_2 SET
    gp_id = dt.gp_id_new FROM (
    SELECT
        AGG.mandant_id AS mandant_id_,
        AGG.wup_id AS wup_id_,
        AGG.nb_id AS nb_id_,
        AGG.art_id AS art_id_,
        AGG.dat_lief_soll AS dat_lief_soll_,
        AGG.gp_id AS gp_id_old,
        EORD.gp_id AS gp_id_new,
        AGG.dat_kalk AS dat_kalk_,
        AGG.in_aktion_fg AS in_aktion_fg_
    FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS AGG
    INNER JOIN dbp_data.ek_orderbuch_2 AS EORD_2
        ON
            AGG.mandant_id = EORD.mandant_id AND AGG.wup_id = EORD.wup_id
            AND AGG.art_id = EORD.art_id AND AGG.dat_lief_soll BETWEEN EORD.dat_von AND EORD.dat_bis
    WHERE AGG.gp_id <> EORD.gp_id
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        art_id_,
        dat_lief_soll_,
        gp_id_old,
        gp_id_new,
        dat_kalk_,
        in_aktion_fg_
) AS dt
WHERE
    banf_art_gp_dat_sum_tmp.mandant_id = dt.mandant_id_ AND banf_art_gp_dat_sum_tmp.wup_id = dt.wup_id_ AND
    banf_art_gp_dat_sum_tmp.nb_id = dt.nb_id_ AND banf_art_gp_dat_sum_tmp.art_id = dt.art_id_ AND
    banf_art_gp_dat_sum_tmp.dat_lief_soll = dt.dat_lief_soll_ AND banf_art_gp_dat_sum_tmp.dat_kalk = dt.dat_kalk_ AND
    banf_art_gp_dat_sum_tmp.in_aktion_fg = dt.in_aktion_fg_ AND banf_art_gp_dat_sum_tmp.gp_id = dt.gp_id_old;


DELETE FROM dbp_data.banf_art_gp_dat_sum_2
WHERE (mandant_id, wup_id, nb_id, art_id, gp_id, dat_lief_soll, dat_kalk, in_aktion_fg) IN (SELECT (
    mandant_id, wup_id,
    nb_id, art_id, gp_id, dat_lief_soll, dat_kalk, in_aktion_fg
)
FROM dbp_etl.banf_art_gp_dat_sum_tmp_2);


INSERT INTO dbp_data.banf_art_gp_dat_sum_2 (
    mandant_id, art_id, wup_id, nb_id, gp_id, dat_lief_soll,
    in_aktion_fg, dat_kalk, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg,
    forecast_menge_kg, menge_best_kg
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    gp_id,
    dat_lief_soll,
    in_aktion_fg,
    dat_kalk,
    vk_brutto,
    banf_menge_kolli,
    forecast_menge_kolli,
    menge_best_kolli,
    banf_menge_kg,
    forecast_menge_kg,
    menge_best_kg
FROM dbp_etl.banf_art_gp_dat_sum_tmp_2 AS D);
