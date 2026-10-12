DROP TABLE IF EXISTS dbp_etl.mseg_likp_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.mseg_likp_tmp (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    vorgangsart_id STRING(2) COLLATE 'und:ci' NOT NULL,
    dat_buch DATE NOT NULL,
    ref_lagerbew_beleg_id INTEGER,
    lief_pal_typ_id STRING(1)
);


INSERT INTO dbp_etl.mseg_likp_tmp (
    mandant_id, lagerbew_beleg_id, kj, vorgangsart_id, dat_buch,
    ref_lagerbew_beleg_id
)
(
    SELECT
        T.mandant_id,
        T.lagerbew_beleg_id,
        T.kj,
        T.vorgangsart_id,
        T.dat_buch,
        CASE
            WHEN T.ref_lagerbew_beleg_id_num = -2
                THEN NULL
            ELSE T.ref_lagerbew_beleg_id_num
        END AS ref_lagerbew_beleg_id
    FROM dbp_data.lagerbew AS T
    INNER JOIN (
        SELECT
            mandant_id,
            dat_buch
        FROM dbp_etl.kmo_mseg_dat
        GROUP BY
            dat_buch,
            mandant_id
    ) AS d ON T.dat_buch = d.dat_buch AND T.mandant_id = d.mandant_id
);


UPDATE dbp_etl.mseg_likp_tmp SET
    lief_pal_typ_id = x.lief_pal_typ_id_ FROM (
    SELECT
        M.mandant_id AS mandant_id_,
        M.dat_buch AS dat_buch_,
        M.kj AS kj_,
        M.vorgangsart_id AS vorgangsart_id_,
        M.lagerbew_beleg_id AS lagerbew_beleg_id_,
        COALESCE(L.lief_pal_typ_id, '0') AS lief_pal_typ_id_,
        M.ref_lagerbew_beleg_id AS ref_lagerbew_beleg_id_
    FROM dbp_etl.mseg_likp_tmp AS M
    LEFT JOIN dbp_data.besch_lief AS L
        ON
            M.mandant_id = L.mandant_id
            AND M.ref_lagerbew_beleg_id = L.lief_beleg_id
            AND L.dat_lief_soll > DATE_SUB(M.dat_buch, INTERVAL 500 DAY)
    WHERE M.ref_lagerbew_beleg_id IS NOT NULL
    GROUP BY
        mandant_id_,
        dat_buch_,
        kj_,
        vorgangsart_id_,
        lagerbew_beleg_id_,
        lief_pal_typ_id_,
        ref_lagerbew_beleg_id_
) AS x
WHERE
    mseg_likp_tmp.mandant_id = x.mandant_id_
    AND mseg_likp_tmp.dat_buch = x.dat_buch_
    AND mseg_likp_tmp.kj = x.kj_
    AND mseg_likp_tmp.vorgangsart_id = x.vorgangsart_id_ AND mseg_likp_tmp.lagerbew_beleg_id = x.lagerbew_beleg_id_
    AND mseg_likp_tmp.ref_lagerbew_beleg_id = x.ref_lagerbew_beleg_id_;


DELETE FROM dbp_data.lagerbew_lgort_grund_wup
WHERE (
    dat_buch, mandant_id) IN (
    SELECT (dat_buch, mandant_id)
    FROM dbp_etl.kmo_mseg_dat
);


INSERT INTO dbp_data.lagerbew_lgort_grund_wup (
    mandant_id, lagerort_id, grund_id, wup_id, nb_id, auto_fg,
    vorgangsart_id,
    lager_bewart_id,
    wg_id,
    arthiertyp_id,
    lief_pal_typ_id,
    dat_buch,
    empfaenger_id,
    betrag_lagerbew,
    betrag_verkauf,
    menge_lagerbew_bme,
    menge_lief,
    menge_lieferschein,
    menge_lagerbew_kolli,
    menge_lagerbew_palette,
    menge_erf, wrg_id, mandant_id_empfaenger, betrag_vk_netto_vz
)
(SELECT
    t2.mandant_id,
    t2.lagerort_id,
    t2.grund_id,
    t2.wup_id,
    t2.nb_id,
    t2.auto_fg,
    t2.vorgangsart_id,
    t2.lager_bewart_id,
    t2.wg_id,
    t2.arthiertyp_id,
    t2.b14,
    t2.dat_buch,
    t2.empfaenger_id,
    t2.betrag_lagerbew,
    t2.betrag_verkauf,
    t2.menge_lagerbew_bme,
    t2.menge_lief,
    t2.menge_lieferschein,
    t2.menge_lagerbew_kolli,
    t2.menge_lagerbew_palette,
    t2.menge_erf,
    t2.wrg_id,
    t2.mandant_id_empfaenger -- , SUM(betrag_lagerbew) AS betrag_lagerbew
    ,
    t2.betrag_vk_netto_vz
FROM (
    SELECT
        D.mandant_id,
        D.lagerort_id,
        D.grund_id,
        D.wup_id,
        D.nb_id,
        D.auto_fg,
        D.dat_buch,
        K.vorgangsart_id,
        D.lager_bewart_id,
        AWZP.wg_id,
        AWZP.arthiertyp_id,
        D.empfaenger_id,
        D.mandant_id_empfaenger,
        D.wrg_id,
        COALESCE(K.lief_pal_typ_id, '0') AS b14,
        SUM(ROUND(CAST(D.betrag_lagerbew AS NUMERIC), 2)) AS betrag_lagerbew,
        SUM(D.betrag_verkauf) AS betrag_verkauf,
        SUM(D.menge_lagerbew_bme) AS menge_lagerbew_bme,
        SUM(D.menge_lief) AS menge_lief,
        SUM(D.menge_lieferschein) AS menge_lieferschein,
        SUM(D.menge_lagerbew_kolli) AS menge_lagerbew_kolli,
        SUM(D.menge_lagerbew_palette) AS menge_lagerbew_palette,
        SUM(D.menge_erf) AS menge_erf,
        SUM(D.betrag_vk_netto_vz) AS betrag_vk_netto_vz
    FROM dbp_data.lagerbew_det AS D
    INNER JOIN dbp_etl.mseg_likp_tmp AS K
        ON
            D.mandant_id = K.mandant_id
            AND D.lagerbew_beleg_id = K.lagerbew_beleg_id
            AND D.kj = K.kj
    INNER JOIN dbp_data.art_wg_zu_per AS AWZP
        ON
            D.art_id = AWZP.art_id AND AWZP.arthiertyp_id = 2 AND D
            .mandant_id = AWZP.mandant_id
            AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE (
        D.mandant_id, D.dat_buch) IN (
        SELECT (mandant_id, dat_buch)
        FROM dbp_etl.kmo_mseg_dat
    )
    AND D.lager_bewart_id NOT IN ('251', '252')
    GROUP BY
        D.mandant_id,
        D.lagerort_id,
        D.grund_id,
        D.wup_id,
        D.nb_id,
        D.auto_fg,
        D.dat_buch,
        K.vorgangsart_id,
        D.lager_bewart_id,
        AWZP.wg_id,
        AWZP.arthiertyp_id,
        D.empfaenger_id,
        D.mandant_id_empfaenger,
        D.wrg_id,
        b14
) AS t2);


DROP TABLE IF EXISTS dbp_etl.kmo_mseg_dat;
