UPDATE dbp_etl.kmo_ekbe SET
    dat_buch_orig = BBD.dat_buch
FROM dbp_data.best_belegfluss AS BBD
WHERE
    kmo_ekbe.mandant_id = BBD.mandant_id AND kmo_ekbe.best_beleg_pos_id = BBD.best_beleg_pos_id AND kmo_ekbe.best_beleg_id
    = BBD.best_beleg_id AND kmo_ekbe.kontierung_pos_id = BBD.kontierung_pos_id AND kmo_ekbe.vorgart_best_entw_id =
    BBD.vorgart_best_entw_id AND kmo_ekbe.folge_beleg_id = BBD.folge_beleg_id AND kmo_ekbe.folge_beleg_pos_id = BBD.folge_beleg_pos_id
    AND kmo_ekbe.kj = BBD.kj;


INSERT INTO dbp_data.l_vorgart_best_entw (mandant_id, vorgart_best_entw_id)
(SELECT DISTINCT
    mandant_id,
    vorgart_best_entw_id
FROM dbp_etl.kmo_ekbe
WHERE (
    mandant_id, vorgart_best_entw_id) NOT IN (
    SELECT (mandant_id, vorgart_best_entw_id)
    FROM (SELECT DISTINCT
        mandant_id,
        vorgart_best_entw_id
    FROM dbp_data.l_vorgart_best_entw) AS t1
)
AND vorgart_best_entw_id IS NOT NULL);


INSERT INTO dbp_data.vorgart_best_entw_spr_zu (
    mandant_id, vorgart_best_entw_id, spr_id,
    vorgart_best_entw_bez
)
(
    SELECT
        A.mandant_id,
        A.vorgart_best_entw_id,
        B.spr_id,
        'system generated'
    FROM dbp_data.l_vorgart_best_entw AS A
    INNER JOIN dbp_data.mandant_spr_zu AS MAN ON A.mandant_id = MAN.mandant_id
    INNER JOIN dbp_data.spr AS B ON B.dwh_spr = 1 AND (MAN.spr_id = B.spr_id OR B.spr_id = 22)
    WHERE (
        A.mandant_id, A.vorgart_best_entw_id, B.spr_id) NOT IN (
        SELECT (mandant_id, vorgart_best_entw_id, spr_id)
        FROM dbp_data.vorgart_best_entw_spr_zu
    )
);


INSERT INTO dbp_data.l_best_entw_typ (mandant_id, best_entw_typ_id, nachbelastung_fg, preis_pruefen_fg)
(SELECT DISTINCT
    mandant_id,
    best_entw_typ_id,
    0,
    0
FROM dbp_etl.kmo_ekbe
WHERE (
    mandant_id, best_entw_typ_id) NOT IN (
    SELECT (mandant_id, best_entw_typ_id)
    FROM (SELECT DISTINCT
        mandant_id,
        best_entw_typ_id
    FROM dbp_data.l_best_entw_typ) AS t1
)
AND best_entw_typ_id IS NOT NULL);


INSERT INTO dbp_data.best_entw_typ_spr_zu (
    mandant_id, best_entw_typ_id, spr_id, best_entw_typ_kbez,
    best_entw_typ_bez
)
(
    SELECT
        A.mandant_id,
        A.best_entw_typ_id,
        B.spr_id,
        '' AS best_entw_typ_kbez,
        'system generated' AS best_entw_typ_bez
    FROM dbp_data.l_best_entw_typ AS A
    INNER JOIN dbp_data.mandant_spr_zu AS MAN ON A.mandant_id = MAN.mandant_id
    INNER JOIN dbp_data.spr AS B ON B.dwh_spr = 1 AND (MAN.spr_id = B.spr_id OR B.spr_id = 22)
    WHERE (
        A.mandant_id, A.best_entw_typ_id, B.spr_id) NOT IN (
        SELECT (mandant_id, best_entw_typ_id, spr_id)
        FROM dbp_data.best_entw_typ_spr_zu
    )
);


DROP TABLE IF EXISTS dbp_etl.kmo_ekbe_betrag;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_ekbe_betrag (
    mandant_id INTEGER NOT NULL,
    lagerbew_beleg_id INTEGER NOT NULL,
    lagerbew_beleg_pos_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    dat_buch DATE NOT NULL,
    betrag_belegfluss_wg_art NUMERIC(29, 2)
);


CREATE OR REPLACE TABLE dbp_etl.`_get_dates_99` AS
SELECT
    mandant_id,
    dat_buch_orig
FROM dbp_etl.kmo_ekbe
WHERE dat_buch_orig IS NOT NULL
GROUP BY
    mandant_id,
    dat_buch_orig;


INSERT INTO dbp_etl.kmo_ekbe_betrag (
    mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj, dat_buch,
    betrag_belegfluss_wg_art
)
(
    SELECT
        KEB.mandant_id,
        KEB.folge_beleg_id,
        KEB.folge_beleg_pos_id,
        KEB.kj,
        KEB.dat_buch,
        SUM(CAST(KEB.betrag AS NUMERIC) - IFNULL(CAST(bbd.betrag_ek_netto AS NUMERIC), 0))
    FROM dbp_etl.kmo_ekbe AS KEB
    LEFT JOIN (
        SELECT
            A.mandant_id,
            A.best_beleg_pos_id,
            A.best_beleg_id,
            A.kontierung_pos_id,
            A.vorgart_best_entw_id,
            A.folge_beleg_id,
            A.folge_beleg_pos_id,
            A.kj,
            A.wup_id,
            A.nb_id,
            A.bestaetigung_lfd_nr,
            A.best_entw_typ_id,
            A.menge_anteil,
            A.menge_best,
            A.lager_bewart_id,
            A.dat_buch,
            A.menge_basis,
            A.betrag_ek_netto,
            A.wrg_id,
            A.soll_haben_kz,
            A.ref_beleg_id,
            A.ref_beleg_pos_id,
            A.ref_gj,
            A.system_id,
            A.betrag_wrbtr,
            A.wrg_id_beleg,
            A.td_update,
            A.td_insert
        FROM dbp_data.best_belegfluss AS A
        INNER JOIN dbp_etl.`_get_dates_99` AS B ON A.mandant_id = B.mandant_id AND A.dat_buch = B.dat_buch_orig
    ) AS bbd
        ON
            KEB.vorgart_best_entw_id = '1' AND KEB.mandant_id = bbd.mandant_id AND KEB.folge_beleg_id = bbd.folge_beleg_id
            AND KEB.folge_beleg_pos_id = bbd.folge_beleg_pos_id AND KEB.kj = bbd.kj AND KEB.best_beleg_id = bbd.best_beleg_id
            AND KEB.dat_buch_orig = bbd.dat_buch
    GROUP BY
        KEB.mandant_id,
        KEB.folge_beleg_id,
        KEB.folge_beleg_pos_id,
        KEB.kj,
        KEB.dat_buch
);


UPDATE dbp_data.lagerbew_det SET
    betrag_belegfluss_wg_art = IFNULL(lagerbew_det.betrag_belegfluss_wg_art, 0) + IFNULL(x.betrag_belegfluss_wg_art, 0)
FROM (
    SELECT
        A.mandant_id,
        A.lagerbew_beleg_id,
        A.lagerbew_beleg_pos_id,
        A.kj,
        A.dat_buch,
        A.betrag_belegfluss_wg_art
    FROM dbp_etl.kmo_ekbe_betrag AS A
    INNER JOIN dbp_data.lagerbew_det AS C
        ON
            A.mandant_id = C.mandant_id AND A.lagerbew_beleg_id = C.lagerbew_beleg_id
            AND A.lagerbew_beleg_pos_id = C.lagerbew_beleg_pos_id AND A.dat_buch = C.dat_buch
    INNER JOIN
        dbp_data.art
            AS B
        ON
            C.mandant_id = B.mandant_id AND C.art_id = B.art_id AND B.wg_art_fg =
            1
) AS x
WHERE
    lagerbew_det.mandant_id = x.mandant_id AND lagerbew_det.lagerbew_beleg_id = x.lagerbew_beleg_id AND lagerbew_det.lagerbew_beleg_pos_id
    = x.lagerbew_beleg_pos_id AND lagerbew_det.dat_buch = x.dat_buch AND lagerbew_det.kj = x.kj;


DELETE FROM dbp_data.best_belegfluss
WHERE (
    mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id, vorgart_best_entw_id, folge_beleg_id,
    folge_beleg_pos_id, kj, dat_buch) IN (SELECT (
    mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id,
    vorgart_best_entw_id, folge_beleg_id, folge_beleg_pos_id, kj, dat_buch_orig
)
FROM dbp_etl.kmo_ekbe
WHERE dat_buch_orig IS NOT NULL) AND (mandant_id, dat_buch) IN (
    SELECT (mandant_id, dat_buch_orig)
    FROM dbp_etl.`_get_dates_99`
);


INSERT INTO dbp_data.best_belegfluss (
    mandant_id, best_beleg_pos_id, best_beleg_id, kontierung_pos_id,
    vorgart_best_entw_id, folge_beleg_id, folge_beleg_pos_id, kj, wup_id, nb_id, bestaetigung_lfd_nr, best_entw_typ_id,
    menge_anteil, menge_best, lager_bewart_id, dat_buch, menge_basis, betrag_ek_netto, wrg_id, soll_haben_kz, ref_beleg_id,
    ref_beleg_pos_id, ref_gj, system_id, betrag_wrbtr, wrg_id_beleg, td_update, td_insert
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
FROM dbp_etl.kmo_ekbe);
