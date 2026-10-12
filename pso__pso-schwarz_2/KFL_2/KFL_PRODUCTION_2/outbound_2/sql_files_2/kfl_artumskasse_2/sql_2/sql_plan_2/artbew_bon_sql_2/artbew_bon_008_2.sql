--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_artbew_dat_2 (mandant_id, dat)
(
    SELECT
        mandant_id,
        dat
    FROM dbp_etl.artbew_agg_tmp_2
    WHERE (
        mandant_id, dat) NOT IN (
        SELECT (mandant_id, dat)
        FROM dbp_etl.art_bestand_vw_sum_artbew_dat_2
    )
    GROUP BY
        mandant_id,
        dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.artbew_mis_2
WHERE (
    mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_agg_tmp_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.artbew_mis_2 (
    mandant_id, art_id, wup_id, nb_id, bewart_id, dat, menge, wrg_2,
    umsatz_netto,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz
)
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        1001,
        dat,
        SUM(menge),
        wrg_2,
        SUM(umsatz_netto),
        0 AS diff_umsatz_netto_konz,
        SUM(umsatz_mwst_betrag),
        0 AS diff_umsatz_mwst_betrag_konz
    FROM dbp_etl.`_artbew_tmp`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        5,
        dat,
        wrg_2,
        diff_umsatz_netto_konz,
        diff_umsatz_mwst_betrag_konz
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.artbew_mis_2 SET
    wg_id = dt.wg_id,
    arthiertyp_id = dt.arthiertyp_id FROM (
    SELECT
        mandant_id,
        art_id,
        wg_id,
        arthiertyp_id
    FROM dbp_data.art_wg_zu_per_2
    WHERE
        arthiertyp_id = 2
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        mandant_id,
        art_id,
        arthiertyp_id,
        wg_id
) AS dt
WHERE artbew_mis.mandant_id = dt.mandant_id AND artbew_mis.art_id = dt.art_id;


--2021-09-22 mfialkiewicz switched to bon_artbew_tmp_talon_2 as in TD BTEQ


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
    umsatz_brutto_ods_verkauf = x1.umsatz_brutto,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.wup_id AS wup_id_,
        W.nb_id AS nb_id_,
        A.dat AS dat_,
        SUM(A.umsatz_brutto) AS umsatz_brutto
    FROM dbp_etl.bon_artbew_tmp_talon_2 AS A
    INNER JOIN
        dbp_data.wup_2 AS W
        ON A.mandant_id = W.mandant_id AND A.wup_id = W.wup_id
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_
) AS x1
WHERE
    wupcal.mandant_id = x1.mandant_id_
    AND wupcal.wup_id = x1.wup_id_
    AND wupcal.nb_id = x1.nb_id_
    AND wupcal.dat = x1
    .dat_; -- AND nb_id IN (0, 2, 7)


UPDATE dbp_data.wupcal_2 SET
    bonanzahl = S.anz_kunden_,
    bonanzahl_imbiss = S.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = S.umsatz_brutto_ods_kassenabschluss_,
    datenlieferung_bonanzahl = 1,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto) AS umsatz_brutto_ods_kassenabschluss_
    FROM dbp_ods.ods_bon_kassenabschluss_2 AS K
    INNER JOIN (SELECT DISTINCT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_agg_tmp_2) AS a
        ON
            K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat
            = a.dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS S
WHERE
    wupcal.mandant_id = S.mandant_id_ AND wupcal.wup_id = S.wup_id_ AND wupcal.dat = S.dat_;


/*2021-09-22 mfialkiewicz*/


DROP TABLE IF EXISTS dbp_etl.bon_artbew_tmp_talon_2;


/*2021-09-22 mfialkiewicz*/


DROP TABLE IF EXISTS dbp_etl.artbew_coupon_zu_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bon_artbew_dat_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.bon_artbew_tag_2;
