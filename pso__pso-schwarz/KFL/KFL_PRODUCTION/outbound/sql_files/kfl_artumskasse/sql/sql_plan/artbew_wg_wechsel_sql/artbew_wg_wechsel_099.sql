-- 14.08.2025, -dba-
--
-- Taegliches Update fuer loyalty_berechtigt_fg.


UPDATE dbp_ods.ods_bon_kopf SET
    loyalty_berechtigt_fg = 0
WHERE bon_dat >= DATE '2025-03-01' AND loyalty_berechtigt_fg IS NULL;


UPDATE dbp_ods.ods_bon_kopf SET
    loyalty_berechtigt_fg = 1
WHERE bon_dat >= DATE '2025-03-01' AND kundenkarte_typ_id = 2 AND (
    kundenkarte_status_bez IS NULL OR
    kundenkarte_status_bez = '') AND (kundenkarte_fehler_txt IS NULL OR kundenkarte_fehler_txt = '') AND (
    loyalty_berechtigt_fg
    IS NULL OR loyalty_berechtigt_fg = 0
);


UPDATE dbp_ods.ods_promotion SET
    betrag_promo_brutto = ods_promotion.betrag_promo_brutto * -1
WHERE betrag_promo_brutto < 0 AND umsatz_promo_brutto > 0 AND menge_promo > 0 AND bon_dat BETWEEN DATE_SUB(
    CURRENT_DATE("Europe/Berlin"),
    INTERVAL 180 DAY
) AND (CURRENT_DATE("Europe/Berlin")
);


TRUNCATE TABLE dbp_etl_process.wup_fg;


INSERT INTO dbp_etl_process.wup_fg (mandant_id, wup_id, nb_id, dat, wup_bereinigt_fg)
(
    SELECT
        B.mandant_id AS mandant_id,
        B.wup_id AS wup_id,
        B.nb_id AS nb_id,
        A.dat,
        CASE
            WHEN (COALESCE(
                B.dat_eroeffnung_alt, DATE '9999-12-31') < DATE_SUB(A.kjwo_kl_dat_von, INTERVAL 364 DAY) OR COALESCE(
                B.dat_eroeffnung, DATE '9999-12-31'
            ) < DATE_SUB(A.kjwo_kl_dat_von, INTERVAL 364 DAY
            )) AND A.kjwo_kl_dat_bis < B.dat_bis OR B.umzugsfiliale_fg = 1
                THEN 1
            ELSE 0
        END AS wup_bereinigt_fg
    FROM dbp_data.tag AS A
    INNER JOIN dbp_data.wup AS B ON TRUE
    WHERE A.dat <= CURRENT_DATE("Europe/Berlin")
);


CREATE OR REPLACE TABLE dbp_etl.artbew_wg_wechsel_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    wg_art_fg INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_bestand_wg_wechsel_log (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_best_wg_wechsel_log (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.artbew_wg_wechsel_join (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    wg_art_fg INTEGER
);


CREATE OR REPLACE TABLE dbp_etl.artbew_wg_sum_tmp (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE,
    bewart_id INTEGER NOT NULL,
    posten_id STRING(2) DEFAULT '  ' NOT NULL,
    menge NUMERIC(29, 4),
    menge_ohne_wg_erf_art NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4)
);


INSERT INTO dbp_etl.artbew_wg_wechsel_tmp (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id,
    wg_art_fg
)
(SELECT
    mandant_id,
    art_id,
    arthiertyp_id,
    -1,
    wg_id,
    wg_art_fg
FROM dbp_etl_process.artbew_wg_wechsel);


INSERT INTO dbp_etl.artbew_wg_wechsel_tmp (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id,
    wg_art_fg
)
(
    SELECT
        T01.mandant_id AS mandant_id,
        T01.art_id AS art_id,
        T01.arthiertyp_id AS arthiertyp_id,
        1,
        T01.wg_id AS wg_id,
        T02.wg_art_fg
    FROM dbp_data.art_wg_zu_per AS T01
    INNER JOIN dbp_data.art AS T02 ON T01.mandant_id = T02.mandant_id AND T01.art_id = T02.art_id
    WHERE T01.dat_bis = DATE '9999-12-31'
);


INSERT INTO dbp_etl.artbew_wg_wechsel_join (
    mandant_id, art_id, arthiertyp_id, dat, alt_neu_kz, wg_id,
    wg_art_fg
)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        T.dat,
        W1.alt_neu_kz,
        W1.wg_id,
        W1.wg_art_fg
    FROM dbp_etl.artbew_wg_wechsel_tmp AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id AND (
                W1.alt_neu_kz = 1 AND W2.alt_neu_kz = -1 OR W1.alt_neu_kz = -1 AND
                W2.alt_neu_kz = 1
            )
    INNER JOIN dbp_data.tag AS T ON T.dat <= CURRENT_DATE("Europe/Berlin") AND T.dat >= DATE '2000-01-01'
    WHERE
        W1.wg_id <> W2.wg_id
        OR W1.wg_art_fg <> W2.wg_art_fg
);


INSERT INTO dbp_etl.vis_tag_bestand_wg_wechsel_log (mandant_id, art_id, arthiertyp_id, wg_id)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        W1.wg_id
    FROM dbp_etl.artbew_wg_wechsel_tmp AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id AND W1.alt_neu_kz = -1 AND W2.alt_neu_kz = 1
    WHERE
        W1.wg_id <> W2.wg_id
        AND W1.arthiertyp_id = 2
        AND (
            W1.mandant_id, W1.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl.vis_tag_bestand_wg_wechsel_log
        )
);


INSERT INTO dbp_etl.vis_monat_best_wg_wechsel_log (mandant_id, art_id, arthiertyp_id, wg_id)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        W1.wg_id
    FROM dbp_etl.artbew_wg_wechsel_tmp AS W1
    INNER JOIN dbp_etl.artbew_wg_wechsel_tmp AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND W1.arthiertyp_id = W2.arthiertyp_id AND W1.alt_neu_kz = -1 AND W2.alt_neu_kz = 1
    WHERE
        W1.wg_id <> W2.wg_id
        AND W1.arthiertyp_id = 2
        AND (
            W1.mandant_id, W1.art_id) NOT IN (
            SELECT (mandant_id, art_id)
            FROM dbp_etl.vis_monat_best_wg_wechsel_log
        )
);


CREATE OR REPLACE TEMPORARY TABLE _wg_change AS
SELECT
    mandant_id,
    wg_id
FROM dbp_etl.artbew_wg_wechsel_join
GROUP BY
    mandant_id,
    wg_id;


-- AIS


DELETE FROM dbp_data.artbew_wg_tp2_sum
WHERE (
    mandant_id, wg_id) IN (
    SELECT (mandant_id, wg_id)
    FROM `_wg_change`
);


INSERT INTO dbp_data.artbew_wg_tp2_sum (
    mandant_id, dat, wg_id, wup_id, nb_id, arthiertyp_id, bewart_id,
    posten_id, menge, menge_ohne_wg_erf_art, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz, ek_nettonetto,
    diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis,
    diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz, ek_netto_bnk, diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, diff_ek_gld_konz, ek_gld, bewart_det_id, pv_aktion, pv_bby,
    pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby, td_update, td_insert, wrg_id,
    ek_mep_vor_fwu, ek_mep_vor_fwu_konz, bonusbasis, bonusbasis_konz, pv_bonrabatt_bby, wup_bereinigt_fg, pv_aktion_konz,
    pv_bby_konz, pv_kdn_bby_konz, pv_kdp_bby_konz, pv_aktion_bby_konz, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby_konz, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt, aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
)
(
    SELECT
        AB.mandant_id,
        AB.dat,
        A.wg_id AS wg_id,
        AB.wup_id,
        AB.nb_id,
        A.arthiertyp_id AS arthiertyp_id,
        AB.bewart_id,
        AB.posten_id,
        SUM(AB.menge),
        SUM(CASE
            WHEN ART.wg_art_fg = 0
                THEN AB.menge
            ELSE 0
        END),
        SUM(AB.umsatz_netto),
        SUM(AB.diff_umsatz_netto_konz),
        SUM(AB.umsatz_mwst_betrag),
        SUM(AB.diff_umsatz_mwst_betrag_konz),
        SUM(AB.ek_brutto),
        SUM(AB.diff_ek_brutto_konz),
        SUM(AB.ek_netto),
        SUM(AB.diff_ek_netto_konz),
        SUM(AB.ek_nettonetto),
        SUM(AB.diff_ek_nettonetto_konz),
        SUM(AB.ek_kal_basis),
        SUM(AB.diff_ek_kal_basis_konz),
        SUM(AB.ek_mep),
        SUM(AB.diff_ek_mep_konz),
        SUM(AB.einstandspreis),
        SUM(AB.diff_einstandspreis_konz),
        SUM(AB.logkostenzuschlag),
        SUM(AB.diff_logkostenzuschlag_konz),
        SUM(AB.ek_netto_bnk),
        SUM(AB.diff_ek_netto_bnk_konz),
        SUM(AB.ek_netto_bnk_sachk),
        SUM(AB.diff_ek_netto_bnk_sachk_konz),
        SUM(AB.diff_ek_gld_konz),
        SUM(AB.ek_gld),
        AB.bewart_det_id,
        SUM(AB.pv_aktion),
        SUM(AB.pv_bby),
        SUM(AB.pv_kdn_bby),
        SUM(AB.pv_kdp_bby),
        SUM(AB.pv_aktion_bby),
        SUM(AB.pv_aktion_kdn_bby),
        SUM(AB.pv_aktion_kdp_bby),
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP(),
        AB.wrg,
        SUM(AB.ek_mep_vor_fwu),
        SUM(AB.ek_mep_vor_fwu_konz),
        SUM(AB.bonusbasis),
        SUM(AB.bonusbasis_konz),
        SUM(AB.pv_bonrabatt_bby),
        AB.wup_bereinigt_fg,
        SUM(AB.pv_aktion_konz),
        SUM(AB.pv_bby_konz),
        SUM(AB.pv_kdn_bby_konz),
        SUM(AB.pv_kdp_bby_konz),
        SUM(AB.pv_aktion_bby_konz),
        SUM(AB.pv_aktion_kdn_bby_konz),
        SUM(AB.pv_aktion_kdp_bby_konz),
        SUM(AB.pv_bonrabatt_bby_konz),
        MAX(AB.umrechnungskurs_hist),
        AB.aktionsart_id_liste_txt,
        AB.aktionsart_bez_liste_txt,
        AB.aktion_typ_id_liste_txt,
        AB.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew AS AB
    INNER JOIN dbp_data.art AS ART ON AB.art_id = ART.art_id AND AB.mandant_id = ART.mandant_id
    INNER JOIN dbp_data.art_wg_zu_per AS A
        ON
            AB.art_id = A.art_id AND AB.mandant_id = A.mandant_id AND A.dat_bis
            = DATE '9999-12-31' AND A.arthiertyp_id = 2
    INNER JOIN dbp_data.kurs AS K
        ON
            AB.wrg = K.von_wrg_id AND AB.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE (
        AB.mandant_id, A.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM `_wg_change`
    )
    GROUP BY
        AB.mandant_id,
        AB.dat,
        A.wg_id,
        AB.wup_id,
        AB.nb_id,
        A.arthiertyp_id,
        AB.bewart_id,
        AB.posten_id,
        AB.bewart_det_id,
        CURRENT_TIMESTAMP(),
        AB.wrg,
        AB.wup_bereinigt_fg,
        AB.aktionsart_id_liste_txt,
        AB.aktionsart_bez_liste_txt,
        AB.aktion_typ_id_liste_txt,
        AB.aktion_typ_bez_liste_txt
);


DELETE FROM dbp_data.artbew_wg_mo_sum
WHERE (
    mandant_id, wg_id) IN (
    SELECT (mandant_id, wg_id)
    FROM `_wg_change`
);


INSERT INTO dbp_data.artbew_wg_mo_sum (
    mandant_id, wup_id, nb_id, kjmo, bewart_id, posten_id, wg_id,
    arthiertyp_id, bewart_det_id, wrg_id, umrechnungskurs_hist, menge, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz,
    ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz,
    ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, ek_gld, diff_ek_gld_konz,
    bonusbasis, bonusbasis_konz, pv_aktion, pv_aktion_konz, pv_bby, pv_bby_konz, pv_kdn_bby, pv_kdn_bby_konz, pv_kdp_bby,
    pv_kdp_bby_konz, pv_aktion_bby, pv_aktion_bby_konz, pv_aktion_kdn_bby, pv_aktion_kdn_bby_konz, pv_aktion_kdp_bby,
    pv_aktion_kdp_bby_konz, pv_bonrabatt_bby, pv_bonrabatt_bby_konz, td_update, td_insert
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', dat) AS BIGNUMERIC), 0) AS INTEGER),
        bewart_id,
        posten_id,
        wg_id,
        arthiertyp_id,
        bewart_det_id,
        wrg_id,
        MAX(umrechnungskurs_hist),
        SUM(menge),
        SUM(umsatz_netto),
        SUM(diff_umsatz_netto_konz),
        SUM(umsatz_mwst_betrag),
        SUM(diff_umsatz_mwst_betrag_konz),
        SUM(ek_brutto),
        SUM(diff_ek_brutto_konz),
        SUM(ek_netto),
        SUM(diff_ek_netto_konz),
        SUM(ek_nettonetto),
        SUM(diff_ek_nettonetto_konz),
        SUM(ek_kal_basis),
        SUM(diff_ek_kal_basis_konz),
        SUM(ek_mep),
        SUM(diff_ek_mep_konz),
        SUM(ek_mep_vor_fwu),
        SUM(ek_mep_vor_fwu_konz),
        SUM(einstandspreis),
        SUM(diff_einstandspreis_konz),
        SUM(logkostenzuschlag),
        SUM(diff_logkostenzuschlag_konz),
        SUM(ek_netto_bnk),
        SUM(diff_ek_netto_bnk_konz),
        SUM(ek_netto_bnk_sachk),
        SUM(diff_ek_netto_bnk_sachk_konz),
        SUM(ek_gld),
        SUM(diff_ek_gld_konz),
        SUM(bonusbasis),
        SUM(bonusbasis_konz),
        SUM(pv_aktion),
        SUM(pv_aktion_konz),
        SUM(pv_bby),
        SUM(pv_bby_konz),
        SUM(pv_kdn_bby),
        SUM(pv_kdn_bby_konz),
        SUM(pv_kdp_bby),
        SUM(pv_kdp_bby_konz),
        SUM(pv_aktion_bby),
        SUM(pv_aktion_bby_konz),
        SUM(pv_aktion_kdn_bby),
        SUM(pv_aktion_kdn_bby_konz),
        SUM(pv_aktion_kdp_bby),
        SUM(pv_aktion_kdp_bby_konz),
        SUM(pv_bonrabatt_bby),
        SUM(pv_bonrabatt_bby_konz),
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.artbew_wg_tp2_sum
    WHERE (
        mandant_id, wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM `_wg_change`
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', dat) AS BIGNUMERIC), 0) AS INTEGER),
        bewart_id,
        posten_id,
        wg_id,
        arthiertyp_id,
        bewart_det_id,
        wrg_id,
        CURRENT_TIMESTAMP()
);


-- VIS


CREATE OR REPLACE TABLE dbp_etl.wpuums_build_tmp (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    nb_id INTEGER NOT NULL,
    arthiertyp_id INTEGER,
    umsatz_brutto NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_wrg STRING(3) COLLATE 'und:ci',
    umsatz_brutto_konz NUMERIC(29, 4),
    umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    kjmo INTEGER,
    menge NUMERIC(29, 3) DEFAULT 0.000,
    quelle INTEGER DEFAULT 0
);


INSERT INTO dbp_etl.wpuums_build_tmp (
    mandant_id, wup_id, wg_id, bewart_id, dat, nb_id, arthiertyp_id,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, umsatz_mwst_betrag, kjmo, menge, quelle
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        W.wg_id AS wg_id,
        1001 AS bewart_id,
        A.dat,
        A.nb_id,
        2 AS arthiertyp_id,
        SUM(A.umsatz_netto + A.umsatz_mwst_betrag) AS umsatz_brutto,
        SUM(A.umsatz_netto),
        A.wrg,
        0,
        0,
        SUM(A.umsatz_mwst_betrag) AS umsatz_mwst_betrag,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', A.dat) AS BIGNUMERIC), 0) AS INTEGER) AS kjmo,
        SUM(A.menge) AS menge,
        1
    FROM dbp_etl_process.artbew_archiv AS A
    INNER JOIN dbp_data.art_wg_zu_per AS W
        ON
            A.mandant_id = W.mandant_id AND A.art_id = W.art_id AND W.dat_bis
            = DATE '9999-12-31' AND W.arthiertyp_id = 2
    WHERE
        CASE
            WHEN A.mandant_id = 1 AND A.dat >= DATE '2017-03-01' AND A.art_id IN (590006700, 590006900)
                THEN 0
            WHEN
                A.mandant_id = 6 AND A.art_id / 10 IN (9800130, 9800131, 9800132) OR A.mandant_id = 7 AND A.dat >=
                DATE '2019-03-01' AND W.wg_id = 969 AND W.wug_id = 6
                THEN 0
            ELSE 1
        END = 1
        AND (
            W.mandant_id, W.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM `_wg_change`
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        W.wg_id,
        bewart_id,
        A.dat,
        A.nb_id,
        arthiertyp_id,
        A.wrg,
        11,
        kjmo,
        16
);


INSERT INTO dbp_etl.wpuums_build_tmp (
    mandant_id, wup_id, wg_id, bewart_id, dat, nb_id, arthiertyp_id,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, umsatz_mwst_betrag, kjmo, menge, quelle
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        W.wg_id AS wg_id,
        1001 AS bewart_id,
        A.dat,
        A.nb_id,
        2 AS arthiertyp_id,
        SUM(A.umsatz_netto + A.umsatz_mwst_betrag) AS umsatz_brutto,
        SUM(A.umsatz_netto),
        A.wrg,
        0,
        0,
        SUM(A.umsatz_mwst_betrag) AS umsatz_mwst_betrag,
        CAST(ROUND(CAST(FORMAT_DATE('%Y%m', A.dat) AS BIGNUMERIC), 0) AS INTEGER) AS kjmo,
        SUM(A.menge) AS menge,
        1
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_data.art_wg_zu_per AS W
        ON
            A.mandant_id = W.mandant_id AND A.art_id = W.art_id AND W.dat_bis
            = DATE '9999-12-31' AND W.arthiertyp_id = 2
    WHERE
        CASE
            WHEN A.mandant_id = 1 AND A.dat >= DATE '2017-03-01' AND A.art_id IN (590006700, 590006900)
                THEN 0
            WHEN
                A.mandant_id = 6 AND A.art_id / 10 IN (9800130, 9800131, 9800132) OR A.mandant_id = 7 AND A.dat >=
                DATE '2019-03-01' AND W.wg_id = 969 AND W.wug_id = 6
                THEN 0
            ELSE 1
        END = 1
        AND (
            W.mandant_id, W.wg_id) IN (
            SELECT (mandant_id, wg_id)
            FROM `_wg_change`
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        W.wg_id,
        bewart_id,
        A.dat,
        A.nb_id,
        arthiertyp_id,
        A.wrg,
        11,
        kjmo,
        16
);


UPDATE dbp_etl.wpuums_build_tmp SET
    umsatz_brutto_konz = ROUND(CAST(wpuums_build_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4),
    umsatz_netto_konz = ROUND(CAST(wpuums_build_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4) FROM
    dbp_data.kurs AS K
WHERE
    wpuums_build_tmp.umsatz_wrg = K.von_wrg_id AND K.dat_bis = DATE '9999-12-31' AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id
    = 3;


DELETE FROM dbp_data.artbew_wg_sum
WHERE bewart_id = 1001 AND quelle = 1 AND (
    mandant_id, wg_id) IN (
    SELECT (mandant_id, wg_id)

    FROM `_wg_change`
);


INSERT INTO dbp_data.artbew_wg_sum (
    mandant_id, nb_id, arthiertyp_id, wg_id, umrechnungskurs_hist, dat,
    wup_id, bewart_id, kjmo, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(
    SELECT
        A.mandant_id,
        A.nb_id,
        A.arthiertyp_id,
        A.wg_id,
        K.umrechnungskurs,
        A.dat,
        A.wup_id,
        A.bewart_id,
        A.kjmo,
        A.umsatz_brutto,
        A.umsatz_netto,
        A.umsatz_wrg,
        A.umsatz_brutto_konz,
        A.umsatz_netto_konz,
        A.quelle,
        A.menge
    FROM dbp_etl.wpuums_build_tmp AS A
    INNER JOIN
        dbp_data.kurs
            AS K
        ON
            A.umsatz_wrg = K.von_wrg_id AND A.dat BETWEEN K.dat_von AND K.dat_bis
            AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
);


DROP TABLE IF EXISTS dbp_etl.maabs_build_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.maabs_build_tmp (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    abschriftart_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    abschriftbetrag_netto NUMERIC(29, 2) NOT NULL,
    abschriftbetrag_brutto NUMERIC(29, 2) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL
);


INSERT INTO dbp_etl.maabs_build_tmp (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id, arthiertyp_id,
    dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id AS mandant_id,
        T1.wup_id AS wup_id,
        T1.nb_id AS nb_id,
        T1.preis_aend_grund_id AS preis_aend_grund_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat_umbew,
        SUM(T1.diff_wert_bestand_netto * T2.alt_neu_kz),
        SUM(T1.diff_wert_bestand_brutto * T2.alt_neu_kz),
        T1.wrg_id
    FROM dbp_data.art_umbewertung AS T1
    INNER JOIN dbp_etl.artbew_wg_wechsel_join AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat_umbew = T2.dat
    INNER JOIN dbp_data.abschriftart_abschriftgrp_zu AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.preis_aend_grund_id
            = T3.abschriftart_id AND T3.abschriftgruppe_id = 400
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat_umbew,
        T1.mandant_id,
        T2.wg_id,
        T1.preis_aend_grund_id,
        T1.wrg_id,
        T2.arthiertyp_id
);


INSERT INTO dbp_etl.maabs_build_tmp (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id, arthiertyp_id,
    dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        T1.mandant_id AS mandant_id,
        T1.wup_id AS wup_id,
        T1.nb_id AS nb_id,
        T1.abschriftart_id AS abschriftart_id,
        T2.wg_id,
        T2.arthiertyp_id,
        T1.dat,
        SUM(T1.abschriftbetrag_netto * T2.alt_neu_kz),
        SUM(T1.abschriftbetrag_brutto * T2.alt_neu_kz),
        T1.wrg_id
    FROM dbp_data.marktabschriften AS T1
    INNER JOIN dbp_etl.artbew_wg_wechsel_join AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id
            AND T1.dat = T2.dat
    GROUP BY
        T1.wup_id,
        T1.nb_id,
        T1.dat,
        T1.mandant_id,
        T2.wg_id,
        T1.abschriftart_id,
        T1.wrg_id,
        T2.arthiertyp_id
);


UPDATE dbp_data.marktabschriften_wg_sum AS MWS SET
    abschriftbetrag_netto = MWS.abschriftbetrag_netto + b.abschriftbetrag_netto,
    abschriftbetrag_brutto = MWS.abschriftbetrag_brutto + b.abschriftbetrag_brutto FROM (SELECT
    wup_id,
    nb_id,
    dat,
    mandant_id,
    wg_id,
    abschriftart_id,
    wrg_id,
    arthiertyp_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto
FROM dbp_etl.maabs_build_tmp) AS b
WHERE
    MWS.wup_id = b.wup_id AND MWS.nb_id = b.nb_id AND MWS.dat = b.dat AND MWS.mandant_id = b.mandant_id AND MWS.wg_id
    = b.wg_id AND MWS.abschriftart_id = b.abschriftart_id AND MWS.wrg_id = b.wrg_id AND MWS.arthiertyp_id = b.arthiertyp_id;


INSERT INTO dbp_data.marktabschriften_wg_sum (
    mandant_id, wup_id, nb_id, abschriftart_id, wg_id,
    arthiertyp_id, dat, abschriftbetrag_netto, abschriftbetrag_brutto, wrg_id
)
(
    SELECT
        t0.mandant_id,
        t0.wup_id,
        t0.nb_id,
        t0.abschriftart_id,
        t0.wg_id,
        t0.arthiertyp_id,
        t0.dat,
        t0.abschriftbetrag_netto,
        t0.abschriftbetrag_brutto,
        t0.wrg_id
    FROM (
        SELECT
            wup_id,
            nb_id,
            dat,
            mandant_id,
            wg_id,
            abschriftart_id,
            wrg_id,
            arthiertyp_id,
            SUM(abschriftbetrag_netto) AS abschriftbetrag_netto,
            SUM(abschriftbetrag_brutto) AS abschriftbetrag_brutto
        FROM dbp_etl.maabs_build_tmp
        GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            abschriftart_id,
            wg_id,
            arthiertyp_id,
            dat,
            wrg_id
    ) AS t0
    LEFT JOIN dbp_data.marktabschriften_wg_sum AS B
        ON
            t0.wup_id = B.wup_id AND t0.nb_id = B.nb_id AND t0.dat
            = B.dat AND t0.mandant_id = B.mandant_id AND t0.wg_id = B.wg_id AND t0.abschriftart_id = B.abschriftart_id AND
            t0.wrg_id = B.wrg_id AND t0.arthiertyp_id = B.arthiertyp_id
    WHERE B.mandant_id IS NULL
);


/*2021-09-22 mfialkiewicz adding missing delete statement*/


TRUNCATE TABLE dbp_etl_process.artbew_wg_wechsel;


INSERT INTO dbp_etl_process.artbew_wg_wechsel (mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg)
(SELECT
    mandant_id,
    art_id,
    arthiertyp_id,
    wg_id,
    wg_art_fg
FROM dbp_etl.artbew_wg_wechsel_tmp
WHERE alt_neu_kz = 1);


DELETE FROM dbp_data.artbew_wg_mo_sum AS AWMS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.artbew_wg_sum_tmp AS AWST
    WHERE
        AWMS.wg_id = wg_id
        AND AWMS.wup_id = wup_id
        AND AWMS.nb_id = nb_id
        AND AWMS.arthiertyp_id = arthiertyp_id
        AND AWMS.bewart_id = bewart_id
        AND AWMS.posten_id = posten_id
        AND AWMS.mandant_id = mandant_id
        AND AWMS.menge = 0
        AND AWMS.umsatz_netto = 0
        AND AWMS.diff_umsatz_netto_konz = 0
        AND AWMS.umsatz_mwst_betrag = 0
        AND AWMS.diff_umsatz_mwst_betrag_konz = 0
        AND AWMS.ek_brutto = 0
        AND AWMS.diff_ek_brutto_konz = 0
        AND AWMS.ek_netto = 0
        AND AWMS.diff_ek_netto_konz = 0
        AND AWMS.ek_nettonetto = 0
        AND AWMS.diff_ek_nettonetto_konz = 0
        AND AWMS.ek_kal_basis = 0
        AND AWMS.diff_ek_kal_basis_konz = 0
        AND AWMS.ek_mep = 0
        AND AWMS.diff_ek_mep_konz = 0
        AND AWMS.einstandspreis = 0
        AND AWMS.diff_einstandspreis_konz = 0
        AND AWMS.logkostenzuschlag = 0
        AND AWMS.diff_logkostenzuschlag_konz = 0
        AND AWMS.ek_netto_bnk = 0
        AND AWMS.diff_ek_netto_bnk_konz = 0
        AND AWMS.ek_netto_bnk_sachk = 0
        AND AWMS.diff_ek_netto_bnk_sachk_konz = 0
);


DELETE FROM dbp_data.artbew_wg_tp2_sum AS AWTS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.artbew_wg_sum_tmp AS ABWSTMP
    WHERE
        AWTS.menge = 0
        AND AWTS.menge_ohne_wg_erf_art = 0
        AND AWTS.umsatz_netto = 0
        AND AWTS.diff_umsatz_netto_konz = 0
        AND AWTS.umsatz_mwst_betrag = 0
        AND AWTS.diff_umsatz_mwst_betrag_konz = 0
        AND AWTS.ek_brutto = 0
        AND AWTS.diff_ek_brutto_konz = 0
        AND AWTS.ek_netto = 0
        AND AWTS.diff_ek_netto_konz = 0
        AND AWTS.ek_nettonetto = 0
        AND AWTS.diff_ek_nettonetto_konz = 0
        AND AWTS.ek_kal_basis = 0
        AND AWTS.diff_ek_kal_basis_konz = 0
        AND AWTS.ek_mep = 0
        AND AWTS.diff_ek_mep_konz = 0
        AND AWTS.einstandspreis = 0
        AND AWTS.diff_einstandspreis_konz = 0
        AND AWTS.logkostenzuschlag = 0
        AND AWTS.diff_logkostenzuschlag_konz = 0
        AND AWTS.ek_netto_bnk = 0
        AND AWTS.diff_ek_netto_bnk_konz = 0
        AND AWTS.ek_netto_bnk_sachk = 0
        AND AWTS.diff_ek_netto_bnk_sachk_konz = 0
        AND AWTS.wg_id = wg_id
        AND AWTS.wup_id = wup_id
        AND AWTS.nb_id = nb_id
        AND AWTS.arthiertyp_id = arthiertyp_id
        AND AWTS.dat = dat
        AND AWTS.bewart_id = bewart_id
        AND AWTS.posten_id = COLLATE(posten_id, 'und:ci')
        AND AWTS.mandant_id = mandant_id
);


DELETE FROM dbp_data.artbew_wg_sum AS AWS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.wpuums_build_tmp AS WBT
    WHERE
        AWS.menge = 0
        AND AWS.umsatz_netto = 0
        AND AWS.umsatz_brutto = 0
        AND AWS.umsatz_brutto_konz = 0
        AND AWS.umsatz_netto_konz = 0
        AND AWS.wg_id = wg_id
        AND AWS.wup_id = wup_id
        AND AWS.nb_id = nb_id
        AND AWS.arthiertyp_id = arthiertyp_id
        AND AWS.bewart_id = bewart_id
        AND AWS.mandant_id = mandant_id
        AND AWS.dat = dat
        AND AWS.umsatz_wrg = umsatz_wrg
        AND AWS.quelle = quelle
);


DELETE FROM dbp_data.marktabschriften_wg_sum AS MWS
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.maabs_build_tmp AS MBT
    WHERE
        MWS.abschriftbetrag_netto = 0
        AND MWS.abschriftbetrag_brutto = 0
        AND MWS.wup_id = wup_id
        AND MWS.nb_id = nb_id
        AND MWS.dat = dat
        AND MWS.mandant_id = mandant_id
        AND MWS.wg_id = wg_id
        AND MWS.abschriftart_id = abschriftart_id
        AND MWS.wrg_id = wrg_id
        AND MWS.arthiertyp_id = arthiertyp_id
);


DROP TABLE IF EXISTS dbp_etl.artbew_wg_wechsel_tmp;


DROP TABLE IF EXISTS dbp_etl.artbew_wg_sum_tmp;
