UPDATE dbp_etl.de_ekbe SET
    dat_buch_orig = BBD.dat_buch
FROM dbp_data.best_belegfluss_1 AS BBD
WHERE
    1 = BBD.mandant_id
    AND de_ekbe.best_beleg_pos_id = BBD.best_beleg_pos_id
    AND de_ekbe.best_beleg_id = BBD.best_beleg_id
    AND de_ekbe.kontierung_pos_id = BBD.kontierung_pos_id
    AND de_ekbe.vorgart_best_entw_id = BBD.vorgart_best_entw_id
    AND de_ekbe.folge_beleg_id = BBD.folge_beleg_id
    AND de_ekbe.folge_beleg_pos_id = BBD.folge_beleg_pos_id
    AND de_ekbe.kj = BBD.kj;


DELETE FROM dbp_data.best_belegfluss_1
WHERE (
    mandant_id,
    best_beleg_pos_id,
    best_beleg_id,
    kontierung_pos_id,
    vorgart_best_entw_id,
    folge_beleg_id,
    folge_beleg_pos_id, kj, dat_buch) IN (
    SELECT (
        mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id,
        vorgart_best_entw_id,
        folge_beleg_id,
        folge_beleg_pos_id,
        kj,
        dat_buch_orig
    )
    FROM dbp_etl.de_ekbe
    WHERE dat_buch_orig IS NOT NULL
);


INSERT INTO dbp_data.best_belegfluss_1 (
    mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id,
    vorgart_best_entw_id,
    folge_beleg_id,
    folge_beleg_pos_id,
    kj,
    wup_id,
    nb_id,
    bestaetigung_lfd_nr,
    best_entw_typ_id,
    menge_anteil,
    menge_best,
    lager_bewart_id,
    dat_buch,
    menge_basis,
    betrag_ek_netto,
    wrg_id,
    soll_haben_kz,
    ref_beleg_id,
    ref_beleg_pos_id,
    ref_gj,
    system_id,
    betrag_wrbtr,
    wrg_id_beleg,
    td_update,
    td_insert
)
(SELECT
    mandant_id,
    best_beleg_pos_id,
    best_beleg_id,
    kontierung_pos_id,
    vorgart_best_entw_id,
    folge_beleg_id,
    folge_beleg_pos_id,
    kj,
    wup_id,
    nb_id,
    bestaetigung_lfd_nr,
    best_entw_typ_id,
    menge_anteil,
    menge_best,
    lager_bewart_id,
    dat_buch,
    menge_basis,
    betrag,
    wrg_id,
    soll_haben_kz,
    ref_beleg_id,
    ref_beleg_pos_id,
    ref_gj,
    system_id,
    betrag_wrbtr,
    wrg_id_beleg,
    td_update,
    td_insert
FROM dbp_etl.de_ekbe);


INSERT INTO dbp_data.l_vorgart_best_entw_1 (mandant_id, vorgart_best_entw_id)
(SELECT DISTINCT
    mandant_id,
    vorgart_best_entw_id
FROM dbp_etl.de_ekbe
WHERE vorgart_best_entw_id NOT IN (
    SELECT DISTINCT vorgart_best_entw_id
    FROM dbp_data.l_vorgart_best_entw_1
    WHERE mandant_id = 1
));


INSERT INTO dbp_data.vorgart_best_entw_spr_zu_1 (
    mandant_id, vorgart_best_entw_id, spr_id,
    vorgart_best_entw_bez
)
(SELECT DISTINCT
    1,
    vorgart_best_entw_id,
    22,
    'system generated'
FROM dbp_data.l_vorgart_best_entw_1 AS A
WHERE (
    1, vorgart_best_entw_id, 22) NOT IN (
    SELECT (a591029334, vorgart_best_entw_id, spr_id)
    FROM (SELECT DISTINCT
        1 AS a591029334,
        vorgart_best_entw_id,
        spr_id
    FROM dbp_data.vorgart_best_entw_spr_zu_1
    WHERE mandant_id = 1) AS t1_1
));


INSERT INTO dbp_data.l_best_entw_typ_1 (
    mandant_id, best_entw_typ_id, nachbelastung_fg, preis_pruefen_fg
)
(SELECT DISTINCT
    mandant_id,
    best_entw_typ_id,
    0,
    0
FROM dbp_etl.de_ekbe
WHERE best_entw_typ_id NOT IN (
    SELECT DISTINCT best_entw_typ_id
    FROM dbp_data.l_best_entw_typ_1
    WHERE mandant_id = 1
));


INSERT INTO dbp_data.best_entw_typ_spr_zu_1 (
    mandant_id, best_entw_typ_id, spr_id, best_entw_typ_kbez,
    best_entw_typ_bez
)
(SELECT DISTINCT
    1,
    best_entw_typ_id,
    22,
    '',
    'system generated'
FROM dbp_data.l_best_entw_typ_1 AS A
WHERE (
    1, best_entw_typ_id, 22) NOT IN (
    SELECT (mandant_id, best_entw_typ_id, spr_id)
    FROM (SELECT DISTINCT
        mandant_id,
        best_entw_typ_id,
        spr_id
    FROM dbp_data.best_entw_typ_spr_zu_1
    WHERE mandant_id = 1) AS t2
));


DROP TABLE IF EXISTS dbp_etl.de_ekbe_betrag_1;


CREATE TABLE IF NOT EXISTS dbp_etl.de_ekbe_betrag_1 (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    betrag_belegfluss_wg_art NUMERIC(29, 2)
);


INSERT INTO dbp_etl.de_ekbe_betrag_1 (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, dat_buch,
    betrag_belegfluss_wg_art
)
(
    SELECT
        A.mandant_id,
        A.folge_beleg_id,
        A.folge_beleg_pos_id,
        A.kj,
        A.dat_buch,
        SUM(
            CAST(A.betrag AS NUMERIC)
            - IFNULL(CAST(BBD.betrag_ek_netto AS NUMERIC), 0)
        )
    FROM dbp_etl.de_ekbe AS A
    LEFT JOIN dbp_data.best_belegfluss_1 AS BBD
        ON
            A.vorgart_best_entw_id = '1' AND A.mandant_id = BBD.mandant_id
            AND A.folge_beleg_id = BBD.folge_beleg_id
            AND A.folge_beleg_pos_id = BBD.folge_beleg_pos_id
            AND A.kj = BBD.kj
            AND A.best_beleg_id = BBD.best_beleg_id
            AND A.dat_buch_orig = BBD.dat_buch
    GROUP BY
        A.mandant_id,
        A.folge_beleg_id,
        A.folge_beleg_pos_id,
        A.kj,
        A.dat_buch
);


UPDATE dbp_data.lagerbew_det_1 SET
    betrag_belegfluss_wg_art
    = IFNULL(lagerbew_det.betrag_belegfluss_wg_art, 0)
    + IFNULL(x.betrag_belegfluss_wg_art, 0)
FROM (
    SELECT
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.lagerbew_beleg_pos_id,
        A.kj,
        A.dat_buch,
        A.betrag_belegfluss_wg_art
    FROM dbp_etl.de_ekbe_betrag_1 AS A
    INNER JOIN dbp_data.lagerbew_det_1 AS C
        ON
            A.mandant_id = C.mandant_id
            AND A.lagerbew_beleg_id = C.lagerbew_beleg_id
            AND A.lagerbew_beleg_pos_id = C.lagerbew_beleg_pos_id
            AND A.dat_buch = C.dat_buch
    INNER JOIN
        dbp_data.art_1
            AS B
        ON
            C.mandant_id = B.mandant_id AND C.art_id = B.art_id AND B.wg_art_fg
            = 1
) AS x
WHERE
    lagerbew_det.mandant_id = x.mandant_id
    AND lagerbew_det.lagerbew_beleg_id = x.lagerbew_beleg_id
    AND lagerbew_det.lagerbew_beleg_pos_id
    = x.lagerbew_beleg_pos_id AND lagerbew_det.dat_buch = x.dat_buch AND lagerbew_det.kj = x.kj;
