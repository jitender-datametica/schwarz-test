CREATE OR REPLACE TABLE dbp_etl.artbew_zek_wechsel_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    zek_id STRING(3) NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.artbew_zek_wechsel_join_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    zek_id STRING(3) NOT NULL
);


INSERT INTO dbp_etl.artbew_zek_wechsel_tmp_2 (mandant_id, art_id, alt_neu_kz, zek_id)
(SELECT
    mandant_id,
    art_id,
    -1,
    SUBSTR(CAST(zek_id AS STRING), 1, 3) AS zek_id
FROM dbp_process.artbew_zek_wechsel_2);


INSERT INTO dbp_etl.artbew_zek_wechsel_tmp_2 (mandant_id, art_id, alt_neu_kz, zek_id)
(SELECT
    mandant_id,
    art_id,
    1,
    zek_id
FROM dbp_data.art_2);


INSERT INTO dbp_etl.artbew_zek_wechsel_join_2 (mandant_id, art_id, kjmo, alt_neu_kz, zek_id)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        M.kjmo AS kjmo,
        W1.alt_neu_kz,
        W1.zek_id
    FROM dbp_etl.artbew_zek_wechsel_tmp_2 AS W1
    INNER JOIN dbp_etl.artbew_zek_wechsel_tmp_2 AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id = W2.art_id
            AND (W1.alt_neu_kz = 1 AND W2.alt_neu_kz = -1 OR W1.alt_neu_kz = -1 AND W2.alt_neu_kz = 1)
    INNER JOIN dbp_data.monat_2 AS M ON M.akt_mo <= 0 AND M.kjmo >= 200001
    WHERE W1.zek_id <> W2.zek_id
);


CREATE OR REPLACE TEMPORARY TABLE _zek_change AS
SELECT
    mandant_id,
    zek_id
FROM dbp_etl.artbew_zek_wechsel_join_2
GROUP BY
    mandant_id,
    zek_id;


DELETE FROM dbp_data.artbew_zek_mo_sum_2
WHERE (
    mandant_id, zek_id) IN (
    SELECT (mandant_id, zek_id)
    FROM `_zek_change`
);


INSERT INTO dbp_data.artbew_zek_mo_sum_2 (
    mandant_id, kjmo, bewart_id, wup_id, nb_id, posten_id, menge,
    umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz,
    ek_netto, diff_ek_netto_konz, ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep,
    diff_ek_mep_konz, einstandspreis, diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz,
    ek_netto_bnk, diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, diff_ek_gld_konz, ek_gld,
    bewart_det_id, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby,
    td_update, td_insert, ek_mep_vor_fwu, ek_mep_vor_fwu_konz, bonusbasis, bonusbasis_konz, pv_bonrabatt_bby, zek_id,
    wrg_id, pv_aktion_konz, pv_bby_konz, pv_kdn_bby_konz, pv_kdp_bby_konz, pv_aktion_bby_konz, pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby_konz, pv_bonrabatt_bby_konz, umrechnungskurs_hist, aktionsart_id_liste_txt, aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt, aktion_typ_bez_liste_txt
)
(
    SELECT
        A.mandant_id AS mandant_id,
        A.kjmo AS kjmo,
        A.bewart_id AS bewart_id,
        A.wup_id AS wup_id,
        A.nb_id AS nb_id,
        A.posten_id,
        SUM(A.menge),
        SUM(A.umsatz_netto),
        SUM(A.diff_umsatz_netto_konz),
        SUM(A.umsatz_mwst_betrag),
        SUM(A.diff_umsatz_mwst_betrag_konz),
        SUM(A.ek_brutto),
        SUM(A.diff_ek_brutto_konz),
        SUM(A.ek_netto),
        SUM(A.diff_ek_netto_konz),
        SUM(A.ek_nettonetto),
        SUM(A.diff_ek_nettonetto_konz),
        SUM(A.ek_kal_basis),
        SUM(A.diff_ek_kal_basis_konz),
        SUM(A.ek_mep),
        SUM(A.diff_ek_mep_konz),
        SUM(A.einstandspreis),
        SUM(A.diff_einstandspreis_konz),
        SUM(A.logkostenzuschlag),
        SUM(A.diff_logkostenzuschlag_konz),
        SUM(A.ek_netto_bnk),
        SUM(A.diff_ek_netto_bnk_konz),
        SUM(A.ek_netto_bnk_sachk),
        SUM(A.diff_ek_netto_bnk_sachk_konz),
        SUM(A.diff_ek_gld_konz),
        SUM(A.ek_gld),
        A.bewart_det_id AS bewart_det_id,
        SUM(A.pv_aktion),
        SUM(A.pv_bby),
        SUM(A.pv_kdn_bby),
        SUM(A.pv_kdp_bby),
        SUM(A.pv_aktion_bby),
        SUM(A.pv_aktion_kdn_bby),
        SUM(A.pv_aktion_kdp_bby),
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP(),
        SUM(A.ek_mep_vor_fwu),
        SUM(A.ek_mep_vor_fwu_konz),
        SUM(A.bonusbasis),
        SUM(A.bonusbasis_konz),
        SUM(A.pv_bonrabatt_bby),
        B.zek_id,
        A.wrg_id,
        MAX(K.umrechnungskurs),
        SUM(A.pv_aktion_konz),
        SUM(A.pv_bby_konz),
        SUM(A.pv_kdn_bby_konz),
        SUM(A.pv_kdp_bby_konz),
        SUM(A.pv_aktion_bby_konz),
        SUM(A.pv_aktion_kdn_bby_konz),
        SUM(A.pv_aktion_kdp_bby_konz),
        SUM(A.pv_bonrabatt_bby_konz),
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
    FROM dbp_data.artbew_mo_sum_2 AS A
    INNER JOIN dbp_data.art_2 AS B
        ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND CASE
            WHEN
                A.mandant_id = 2 AND A.art_id = 208124500 OR A.mandant_id = 3 AND A.art_id = 208113690 OR A.mandant_id = 5 AND
                A.art_id = 206731500 OR A.mandant_id = 6 AND A.art_id = 208131570 OR A.mandant_id IN (4, 7) AND A.art_id =
                208114740 OR A.mandant_id = 8 AND A.art_id = 208131640
                THEN 0
            ELSE 1
        END = 1
    INNER JOIN dbp_data.monat_2 AS X ON A.kjmo = X.kjmo
    INNER JOIN dbp_data.kurs_2 AS K
        ON
            A.wrg_id = K.von_wrg_id AND X.min_dat BETWEEN K.dat_von AND K.dat_bis
            AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE (
        A.mandant_id, B.zek_id) IN (
        SELECT (mandant_id, zek_id)
        FROM `_zek_change`
    )
    GROUP BY
        A.mandant_id,
        A.kjmo,
        A.bewart_id,
        A.wup_id,
        A.nb_id,
        A.posten_id,
        A.bewart_det_id,
        CURRENT_TIMESTAMP(),
        B.zek_id,
        A.wrg_id,
        A.aktionsart_id_liste_txt,
        A.aktionsart_bez_liste_txt,
        A.aktion_typ_id_liste_txt,
        A.aktion_typ_bez_liste_txt
);


TRUNCATE TABLE dbp_process.artbew_zek_wechsel_2;


INSERT INTO dbp_process.artbew_zek_wechsel_2 (mandant_id, art_id, zek_id)
(SELECT
    mandant_id,
    art_id,
    CAST(zek_id AS INTEGER)
FROM dbp_etl.artbew_zek_wechsel_tmp_2
WHERE alt_neu_kz = 1);


DROP TABLE IF EXISTS dbp_etl.artbew_zek_wechsel_tmp_2;


DROP TABLE IF EXISTS dbp_etl.artbew_zek_wechsel_join_2;
