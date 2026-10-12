DROP TABLE IF EXISTS dbp_etl.kmo_mseg_work;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_work (
    art_id INTEGER,
    art_id_bf INTEGER NOT NULL,
    art_id_empfaenger INTEGER NOT NULL,
    auto_fg STRING(1) COLLATE 'und:ci' NOT NULL,
    beleg_user_name STRING(20) COLLATE 'und:ci' NOT NULL,
    belegart_id STRING(2) COLLATE 'und:ci',
    belegkopftext STRING(30) COLLATE 'und:ci',
    best_beleg_id INTEGER,
    best_beleg_pos_id INTEGER NOT NULL,
    betrag_belegfluss_wg_art NUMERIC(29, 2),
    betrag_bnk NUMERIC(29, 4) NOT NULL,
    betrag_einstandspreis NUMERIC(29, 4),
    betrag_exbwr NUMERIC(29, 4) NOT NULL,
    betrag_lagerbew NUMERIC(29, 4),
    betrag_umbewertung NUMERIC(29, 4) NOT NULL,
    betrag_verkauf NUMERIC(29, 2) NOT NULL,
    betrag_verkauf_ist NUMERIC(29, 2) NOT NULL,
    betrag_verkauf_ist_netto NUMERIC(29, 4),
    betrag_vk_netto NUMERIC(29, 2) NOT NULL,
    betrag_vk_netto_vz NUMERIC(29, 4) NOT NULL,
    bq_findung_id INTEGER NOT NULL,
    buchungskreis_id INTEGER NOT NULL,
    bw_vorgang_id INTEGER NOT NULL,
    dat_beleg DATE NOT NULL,
    dat_buch DATE NOT NULL,
    dat_erfasst DATE,
    einkaufsorganisation_id INTEGER,
    empfaenger STRING(10),
    empfaenger_id INTEGER,
    endlief_fg INTEGER NOT NULL,
    erfsngs_menge_einh_id STRING(3) NOT NULL,
    gp_id INTEGER,
    gp_id_zl INTEGER,
    grund_id STRING(10) COLLATE 'und:ci' NOT NULL,
    kj INTEGER NOT NULL,
    kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL,
    kunde_id STRING(10) COLLATE 'und:ci',
    lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    lagerbew_beleg_pos_mutter_id INTEGER NOT NULL,
    lagerbew_beleg_pos_storno_id INTEGER,
    lagerbew_beleg_storno_id INTEGER,
    lagerbew_beleg_storno_kj INTEGER,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    lagerort_id_empfaenger STRING(4) COLLATE 'und:ci' NOT NULL,
    lagerplatz_id STRING(10) COLLATE 'und:ci',
    lief_gp_id INTEGER NOT NULL,
    line_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    mandant_id_empfaenger INTEGER,
    mandant_id_kunde INTEGER,
    menge_bestand_bme NUMERIC(29, 3) NOT NULL,
    menge_erf NUMERIC(29, 3) NOT NULL,
    menge_lagerbew_bme NUMERIC(29, 3) NOT NULL,
    menge_lagerbew_kolli NUMERIC(29, 3) NOT NULL,
    menge_lagerbew_palette NUMERIC(29, 3),
    menge_lief NUMERIC(29, 3) NOT NULL,
    menge_lieferschein NUMERIC(29, 3) NOT NULL,
    mwst NUMERIC(29, 2) NOT NULL,
    mwst_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    ref_lagerbew_beleg_id STRING(20) COLLATE 'und:ci',
    ref_lagerbew_beleg_id_num INTEGER NOT NULL,
    sachkonto_id STRING(10) COLLATE 'und:ci' NOT NULL,
    shkum STRING(1) COLLATE 'und:ci' NOT NULL,
    soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL,
    spr_id INTEGER NOT NULL,
    system_id INTEGER,
    transaktion_code STRING(10) COLLATE 'und:ci',
    vorgangsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
    waren_begl_schein_id STRING(10) COLLATE 'und:ci',
    wert_bestand NUMERIC(29, 4) NOT NULL,
    wg_art_fg INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    wup_id INTEGER,
    xruem_fg INTEGER NOT NULL,
    zeit_erfasst INTEGER NOT NULL,
    lagerbew_beleg_pos_sort_id INTEGER,
    lagerbew_beleg_parent_pos_sort_id INTEGER,
    display_art_id INTEGER
);


INSERT INTO dbp_etl.kmo_mseg_work (
    art_id, art_id_bf, art_id_empfaenger, auto_fg, beleg_user_name,
    belegart_id, belegkopftext, best_beleg_id, best_beleg_pos_id, betrag_belegfluss_wg_art, betrag_bnk, betrag_exbwr,
    betrag_lagerbew, betrag_umbewertung, betrag_verkauf, betrag_verkauf_ist, betrag_verkauf_ist_netto, betrag_vk_netto,
    betrag_vk_netto_vz, bq_findung_id, buchungskreis_id, bw_vorgang_id, dat_beleg, dat_buch, dat_erfasst,
    einkaufsorganisation_id, empfaenger, empfaenger_id, endlief_fg, erfsngs_menge_einh_id, gp_id, grund_id, kj,
    kostenstelle_id, kunde_id, lager_bewart_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, lagerbew_beleg_pos_mutter_id,
    lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_id, lagerbew_beleg_storno_kj, lagerort_id, lagerort_id_empfaenger,
    lagerplatz_id, lief_gp_id, line_id, mandant_id, mandant_id_empfaenger, menge_bestand_bme, menge_erf, menge_lagerbew_bme,
    menge_lagerbew_kolli, menge_lagerbew_palette, menge_lief, menge_lieferschein, mwst, mwst_id, nb_id,
    ref_lagerbew_beleg_id, ref_lagerbew_beleg_id_num, sachkonto_id, shkum, soll_haben_kz, spr_id, system_id,
    transaktion_code, vorgangsart_id, waren_begl_schein_id, wert_bestand, wg_art_fg, wrg_id, wup_id, xruem_fg, zeit_erfasst,
    lagerbew_beleg_pos_sort_id, lagerbew_beleg_parent_pos_sort_id, display_art_id
)
(
    SELECT
        MM.art_id,
        MM.art_id_bf,
        MM.art_id_empfaenger,
        MM.auto_fg,
        MM.beleg_user_name,
        MM.belegart_id,
        MM.belegkopftext,
        MM.best_beleg_id,
        MM.best_beleg_pos_id,
        COALESCE(ROUND(CAST(BBF.betrag_ek_netto AS NUMERIC), 2), 0) AS betrag_belegfluss_wg_art,
        MM.betrag_bnk,
        MM.betrag_exbwr,
        MM.betrag_lagerbew,
        MM.betrag_umbewertung,
        MM.betrag_verkauf,
        MM.betrag_verkauf_ist,
        COALESCE(CAST(MM.betrag_verkauf_ist AS NUMERIC) / (MM.mwst + 100) * 100, 0) AS betrag_verkauf_ist_netto, --PE-Review
        MM.betrag_vk_netto,
        MM.betrag_vk_netto_vz,
        MM.bq_findung_id,
        MM.buchungskreis_id,
        MM.bw_vorgang_id,
        MM.dat_beleg,
        MM.dat_buch,
        MM.dat_erfasst,
        MM.einkaufsorganisation_id,
        MM.empfaenger,
        MM.empfaenger_id,
        MM.endlief_fg,
        MM.erfsngs_menge_einh_id,
        MM.gp_id,
        MM.grund_id,
        MM.kj,
        MM.kostenstelle_id,
        COALESCE(TRIM(bb.kunde_id), TRIM(MM.kunnr)) AS kunde_id,
        MM.lager_bewart_id,
        MM.lagerbew_beleg_id,
        MM.lagerbew_beleg_pos_id,
        MM.lagerbew_beleg_pos_mutter_id,
        MM.lagerbew_beleg_pos_storno_id,
        MM.lagerbew_beleg_storno_id,
        MM.lagerbew_beleg_storno_kj,
        MM.lagerort_id,
        MM.lagerort_id_empfaenger,
        MM.lagerplatz_id,
        MM.lief_gp_id,
        MM.line_id,
        MM.mandant_id,
        MM.mandant_id_empfaenger,
        MM.menge_bestand_bme,
        MM.menge_erf,
        MM.menge_lagerbew_bme,
        ROUND(
            CAST(MM.menge_lagerbew_bme * COALESCE(AUKOLLI_ALTERNATIV.umrech_faktor, AUKOLLI_ALTERNATIV_Q.umrech_faktor, 1) AS NUMERIC),
            3
        ) AS menge_lagerbew_kolli,
        ROUND(
            CAST(MM.menge_lagerbew_bme * COALESCE(AUPALETTE.umrech_faktor, AUPALETTE_Q.umrech_faktor, 0) AS NUMERIC), 3) AS
        menge_lagerbew_palette,
        MM.menge_lief,
        MM.menge_lieferschein,
        MM.mwst,
        MM.mwst_id,
        MM.nb_id,
        MM.ref_lagerbew_beleg_id,
        MM.ref_lagerbew_beleg_id_num,
        MM.sachkonto_id,
        MM.shkum,
        MM.soll_haben_kz,
        MM.spr_id,
        MM.system_id,
        MM.transaktion_code,
        MM.vorgangsart_id,
        MM.waren_begl_schein_id,
        MM.wert_bestand,
        MM.wg_art_fg,
        MM.wrg_id,
        MM.wup_id,
        MM.xruem_fg,
        CAST(ROUND(CAST(REPLACE(CAST(MM.zeit_erfasst AS STRING), ':', '') AS BIGNUMERIC), 0) AS INTEGER) AS zeit_erfasst,
        MM.lagerbew_beleg_pos_sort_id,
        MM.lagerbew_beleg_parent_pos_sort_id,
        MM.display_art_id
    FROM dbp_etl.kmo_mseg_delta AS MM
    LEFT JOIN (
        SELECT *
        FROM dbp_data.besch_best_det
        WHERE (
            mandant_id, dat_best_beleg) IN (
            SELECT (A.mandant_id, A.dat_best_beleg)
            FROM dbp_data.besch_best AS A
            INNER JOIN dbp_etl.kmo_mseg_delta AS B ON A.mandant_id = B.mandant_id AND A.best_beleg_id = B.best_beleg_id

            GROUP BY A.mandant_id,
            A.dat_best_beleg
        )
    ) AS bb
        ON
            MM.mandant_id = bb.mandant_id AND MM.best_beleg_id = bb.best_beleg_id AND MM.best_beleg_pos_id
            = bb.best_beleg_pos_id AND bb.mandant_id <> 1
    LEFT JOIN dbp_data.art_vorschlagswert_per AS AV
        ON
            MM.mandant_id = AV.mandant_id AND MM.art_id = AV.art_id
            AND MM.dat_buch >= AV.dat_von AND MM.dat_buch <= AV.dat_bis
    LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUPALETTE
        ON
            MM.mandant_id = AUPALETTE.mandant_id AND
            MM.art_id = AUPALETTE.art_id AND AV.paletten_faktor_einh_id = AUPALETTE.altnv_menge_einh_id AND MM.dat_buch >=
            AUPALETTE.dat_von AND MM.dat_buch <= AUPALETTE.dat_bis
    LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_ALTERNATIV
        ON
            MM.mandant_id =
            AUKOLLI_ALTERNATIV.mandant_id AND MM.art_id = AUKOLLI_ALTERNATIV.art_id AND AV.ausg_menge_einh_id =
            AUKOLLI_ALTERNATIV.altnv_menge_einh_id AND MM.dat_buch >= AUKOLLI_ALTERNATIV.dat_von AND MM.dat_buch <=
            AUKOLLI_ALTERNATIV.dat_bis
    LEFT JOIN dbp_data.art_vorschlagswert_per AS AV_Q
        ON
            MM.mandant_id = AV_Q.mandant_id AND MM.art_id =
            AV_Q.art_id AND MM.dat_buch >= AV_Q.dat_von AND MM.dat_buch <= AV_Q.dat_bis
    LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUPALETTE_Q
        ON
            MM.mandant_id = AUPALETTE_Q.mandant_id
            AND MM.art_id = AUPALETTE_Q.art_id AND AUPALETTE_Q.altnv_menge_einh_id = 'PAL' AND AUPALETTE_Q.dat_bis = PARSE_DATE(
                '%F',
                '9999-12-31'
            )
    LEFT JOIN dbp_data.art_umrechnung_faktor_per AS AUKOLLI_ALTERNATIV_Q
        ON
            MM.mandant_id =
            AUKOLLI_ALTERNATIV_Q.mandant_id AND MM.art_id = AUKOLLI_ALTERNATIV_Q.art_id AND AV_Q.ausg_menge_einh_id =
            AUKOLLI_ALTERNATIV_Q.altnv_menge_einh_id AND AUKOLLI_ALTERNATIV_Q.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN
        dbp_data.best_belegfluss
            AS BBF
        ON
            MM.mandant_id = BBF.mandant_id AND MM.lagerbew_beleg_id =
            BBF.folge_beleg_id AND MM.lagerbew_beleg_pos_id = BBF.folge_beleg_pos_id AND MM.dat_buch = BBF.dat_buch AND
            MM.kj = BBF.kj AND MM.best_beleg_id = BBF.best_beleg_id AND MM.best_beleg_pos_id = BBF.best_beleg_pos_id AND MM.wg_art_fg = 1 AND BBF.best_entw_typ_id = 'E' AND BBF.mandant_id > 1
);


DROP TABLE IF EXISTS dbp_etl.kmo_lagerbew_det_vk_anr;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_lagerbew_det_vk_anr (
    mandant_id INTEGER,
    lagerbew_beleg_id INTEGER,
    lagerbew_beleg_pos_id INTEGER,
    dat_buch DATE NOT NULL,
    kj INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    menge_lagerbew_bme NUMERIC(29, 3),
    vk_netto NUMERIC(29, 4)
);


INSERT INTO dbp_etl.kmo_lagerbew_det_vk_anr (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id,
    dat_buch, kj, art_id, wup_id, nb_id, menge_lagerbew_bme, vk_netto
)
(
    SELECT
        KMW.mandant_id,
        KMW.lagerbew_beleg_id,
        KMW.lagerbew_beleg_pos_id,
        KMW.dat_buch,
        KMW.kj,
        KMW.art_id,
        KMW.wup_id,
        KMW.nb_id,
        KMW.menge_lagerbew_bme,
        CAST(AP.vk_brutto / CAST(1 + KMW.mwst / 100 AS BIGNUMERIC) AS NUMERIC) AS vk_netto
    FROM dbp_etl.kmo_mseg_work AS KMW
    LEFT JOIN dbp_data.art_pm_vw_zu_per AS AP
        ON
            KMW.mandant_id = AP.mandant_id AND KMW.art_id = AP.art_id
            AND KMW.dat_buch BETWEEN AP.dat_von AND AP.dat_bis AND AP.preistyp_id = 0 AND AP.pm_id = 1 AND AP.vw_id IN (
                10,
                90
            ) AND AP.vk_brutto <> 0
    WHERE KMW.nb_id = -111
);


UPDATE dbp_etl.kmo_mseg_work SET
    betrag_vk_netto_vz = t0.betrag_vk_vz_netto_ FROM (
    SELECT
        mandant_id AS mandant_id_,
        lagerbew_beleg_id AS lagerbew_beleg_id_,
        lagerbew_beleg_pos_id AS lagerbew_beleg_pos_id_,
        dat_buch AS dat_buch_,
        kj AS kj_,
        art_id AS art_id_,
        wup_id AS wup_id_,
        nb_id AS nb_id_,
        COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 2), 0) AS betrag_vk_vz_netto_
    FROM dbp_etl.kmo_lagerbew_det_vk_anr
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, dat_buch, art_id,
            wup_id, nb_id ORDER BY
            ABS(
                COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 2), 0
                )
            ) IS NULL, ABS(COALESCE(ROUND(CAST(menge_lagerbew_bme * CAST(vk_netto AS FLOAT64) AS NUMERIC), 2), 0)
            )
    )) = 1
) AS t0
WHERE
    kmo_mseg_work.mandant_id = t0.mandant_id_ AND kmo_mseg_work.lagerbew_beleg_id = t0.lagerbew_beleg_id_ AND
    kmo_mseg_work.lagerbew_beleg_pos_id = t0.lagerbew_beleg_pos_id_ AND kmo_mseg_work.dat_buch = t0.dat_buch_ AND
    kmo_mseg_work.kj = t0.kj_ AND kmo_mseg_work.art_id = t0.art_id_ AND kmo_mseg_work.wup_id = t0.wup_id_ AND
    kmo_mseg_work.nb_id = t0.nb_id_;


DELETE FROM dbp_data.lagerbew_delta
WHERE (
    mandant_id, lagerbew_beleg_id, kj) IN (
    SELECT (mandant_id, lagerbew_beleg_id, kj)
    FROM dbp_etl.kmo_mseg_work
);


INSERT INTO dbp_data.lagerbew_delta (
    mandant_id, lagerbew_beleg_id, kj, vorgangsart_id, dat_buch,
    beleg_user_name, ref_lagerbew_beleg_id, dat_beleg, dat_erfasst, belegart_id, belegkopftext, waren_begl_schein_id,
    system_id, ref_lagerbew_beleg_id_num, lief_gp_id, zeit_erfasst, transaktion_code
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    kj,
    vorgangsart_id,
    dat_buch,
    beleg_user_name,
    ref_lagerbew_beleg_id,
    dat_beleg,
    dat_erfasst,
    belegart_id,
    belegkopftext,
    waren_begl_schein_id,
    system_id,
    ref_lagerbew_beleg_id_num,
    lief_gp_id,
    zeit_erfasst,
    transaktion_code
FROM dbp_etl.kmo_mseg_work
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, lagerbew_beleg_id, kj ORDER BY
        lagerbew_beleg_pos_id IS NULL DESC,
        lagerbew_beleg_pos_id DESC
)) = 1);


DELETE FROM dbp_data.lagerbew_det_delta
WHERE (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) IN (SELECT (
    mandant_id, lagerbew_beleg_id,
    lagerbew_beleg_pos_id, kj
)
FROM dbp_etl.kmo_mseg_work);


INSERT INTO dbp_data.lagerbew_det_delta (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj,
    grund_id, lager_bewart_id, art_id, wup_id, nb_id, auto_fg, lagerort_id, gp_id, einkaufsorganisation_id, soll_haben_kz,
    wrg_id, best_beleg_id, best_beleg_pos_id, betrag_lagerbew, betrag_verkauf, erfsngs_menge_einh_id, lagerplatz_id,
    kunde_id, menge_lagerbew_kolli, menge_lagerbew_bme, menge_lagerbew_palette, menge_lieferschein, menge_lief, menge_erf,
    empfaenger_id, dat_buch, lagerbew_beleg_storno_id, lagerbew_beleg_pos_storno_id, lagerbew_beleg_storno_kj,
    betrag_vk_netto, betrag_belegfluss_wg_art, mandant_id_kunde, mandant_id_empfaenger, bw_vorgang_id, betrag_verkauf_ist,
    betrag_vk_netto_vz, betrag_verkauf_ist_netto, menge_bestand_bme, wert_bestand, system_id, buchungskreis_id, shkum,
    kostenstelle_id, sachkonto_id, art_id_empfaenger, lagerort_id_empfaenger, art_id_bf, lagerbew_beleg_pos_mutter_id,
    line_id, display_art_id, endlief_fg, xruem_fg, betrag_exbwr, betrag_bnk, betrag_umbewertung
)
(SELECT
    mandant_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    kj,
    grund_id,
    lager_bewart_id,
    art_id,
    wup_id,
    nb_id,
    auto_fg,
    lagerort_id,
    gp_id,
    einkaufsorganisation_id,
    soll_haben_kz,
    wrg_id,
    best_beleg_id,
    best_beleg_pos_id,
    betrag_lagerbew,
    betrag_verkauf,
    erfsngs_menge_einh_id,
    lagerplatz_id,
    kunde_id,
    menge_lagerbew_kolli,
    menge_lagerbew_bme,
    menge_lagerbew_palette,
    menge_lieferschein,
    menge_lief,
    menge_erf,
    empfaenger_id,
    dat_buch,
    lagerbew_beleg_storno_id,
    lagerbew_beleg_pos_storno_id,
    lagerbew_beleg_storno_kj,
    betrag_vk_netto,
    betrag_belegfluss_wg_art,
    mandant_id_kunde,
    mandant_id_empfaenger,
    bw_vorgang_id,
    betrag_verkauf_ist,
    betrag_vk_netto_vz,
    betrag_verkauf_ist_netto,
    menge_bestand_bme,
    wert_bestand,
    system_id,
    buchungskreis_id,
    shkum,
    kostenstelle_id,
    sachkonto_id,
    art_id_empfaenger,
    lagerort_id_empfaenger,
    art_id_bf,
    lagerbew_beleg_parent_pos_sort_id AS lagerbew_beleg_pos_mutter_id,
    lagerbew_beleg_pos_sort_id AS line_id,
    display_art_id,
    endlief_fg,
    xruem_fg,
    betrag_exbwr,
    betrag_bnk,
    betrag_umbewertung
FROM dbp_etl.kmo_mseg_work);


INSERT INTO dbp_data.l_vorgangsart (mandant_id, vorgangsart_id)
(
    SELECT
        mandant_id,
        vorgangsart_id
    FROM dbp_etl.kmo_mseg_work
    WHERE
        vorgangsart_id IS NOT NULL
        AND (
            mandant_id, vorgangsart_id) NOT IN (
            SELECT (mandant_id, vorgangsart_id)
            FROM dbp_data.l_vorgangsart
        )
    GROUP BY
        mandant_id,
        vorgangsart_id
);


INSERT INTO dbp_data.vorgangsart_spr_zu (mandant_id, vorgangsart_id, spr_id, vorgangsart_bez)
(
    SELECT
        MM.mandant_id,
        MM.vorgangsart_id,
        S.spr_id,
        'system generated' AS vorgangsart_bez
    FROM dbp_etl.kmo_mseg_work AS MM
    INNER JOIN dbp_data.mandant_spr_zu AS MAN ON MM.mandant_id = MAN.mandant_id
    INNER JOIN dbp_data.spr AS S ON S.dwh_spr = 1 AND (MAN.spr_id = S.spr_id OR S.spr_id = 22)
    WHERE (
        MM.mandant_id, MM.vorgangsart_id, S.spr_id) NOT IN (
        SELECT (mandant_id, vorgangsart_id, spr_id)
        FROM dbp_data.vorgangsart_spr_zu
    )
    GROUP BY
        MM.mandant_id,
        MM.vorgangsart_id,
        S.spr_id,
        vorgangsart_bez
);
