CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_aktion_relevant (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    anz_aktion INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.artbew_kmo_tmp (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    bewart_det_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg STRING(3) COLLATE 'und:ci',
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
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    posten_id STRING(2) COLLATE 'und:ci',
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4),
    pv_aktion NUMERIC(29, 4),
    pv_bby NUMERIC(29, 4),
    pv_kdn_bby NUMERIC(29, 4),
    pv_kdp_bby NUMERIC(29, 4),
    pv_aktion_bby NUMERIC(29, 4),
    pv_aktion_kdn_bby NUMERIC(29, 4),
    pv_aktion_kdp_bby NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.artbew_kmo_tmp_crm (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg STRING(3) COLLATE 'und:ci',
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
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    posten_id STRING(2) COLLATE 'und:ci',
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4),
    kundenkarte_id STRING(255) COLLATE 'und:ci',
    bon_id STRING(25)
);


-- ekorg nach bezugsquellenfindung
-- warengruppe für zugriff auf vz_wup_wg_zu_per

-- regel ekorg aus einkaufsinfosatz
-- regel gp aus einkaufsinfosatz
-- ausstiegspunkt der bezugsquellenfindung

-- kurs für die umrechnung von landeswährung in euro

-- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina und eord

-- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina und eord

-- anzahl infosätze (1 wenn nur ungültige vorhanden sind)
-- gp nach bezugsquellenfindung

-- anzahl orderbuch gepflegt
-- kreistyp_gruppe aus marktstamm.
CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu
(
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);


TRUNCATE TABLE dbp_etl_process.artbew_pv_subset;


INSERT INTO dbp_etl_process.artbew_pv_subset (
    mandant_id, wup_id, lkp_nb_id, lkp_art_id, lkp_posten_id,
    dat_booking, lkp_mwst, lkp_mwst_id, lkp_wrg, lkp_umrechnungskurs, promo_fg, ean_kasse, aktion_id, kundenkarte_id,
    kundenkarte_typ_id, bonuskauf_id, aktion_typ_id, konditionsart_id, vk_aktion_brutto, vk_brutto, bonuskauf_id_lb,
    bde_kundenkarte_id, bewart_det_id, customer_promotion_fg, promotion_art, betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp, betrag_promo_brutto_null, umsatz_brutto_, menge_, umsatz_promotion_brutto_, pv_aktion, pv_bby,
    pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.lkp_nb_id,
        Z.lkp_art_id,
        Z.lkp_posten_id,
        Z.dat_booking,
        Z.lkp_mwst,
        Z.lkp_mwst_id,
        Z.lkp_wrg,
        Z.lkp_umrechnungskurs,
        CASE
            WHEN COALESCE(p.promotion_brutto, 0) <> 0 AND CAST(Z.bonuskauf_id AS FLOAT64) <> 0
                THEN 1
            ELSE 0
        END AS promo_fg,
        Z.ean_kasse,
        CASE
            WHEN Z.dat_booking >= CAST(X.dat AS DATE) AND p.aktion_id <> ''
                THEN p.aktion_id
            ELSE Z.aktion_id
        END AS aktion_id,
        Z.kundenkarte_id,
        Z.kundenkarte_typ_id,
        Z.bonuskauf_id,
        Z.aktion_typ_id,
        Z.konditionsart_id,
        Z.vk_aktion_brutto,
        Z.vk_brutto,
        Z.bonuskauf_id_lb,
        Z.bde_kundenkarte_id,
        888888 AS bewart_det_id,
        0 AS customer_promotion_fg,
        '' AS promotion_art,
        SUM(Z.betrag_promo_brutto_kdn) AS betrag_promo_brutto_kdn,
        SUM(Z.betrag_promo_brutto_kdp) AS betrag_promo_brutto_kdp,
        SUM(Z.betrag_promo_brutto_null) AS betrag_promo_brutto_null,
        SUM(Z.umsatz_brutto) AS umsatz_brutto_,
        SUM(Z.menge) AS menge_,
        SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_,
        SUM(0) AS pv_aktion,
        SUM(0) AS pv_bby,
        SUM(0) AS pv_kdn_bby,
        SUM(0) AS pv_kdp_bby,
        SUM(0) AS pv_aktion_bby,
        SUM(0) AS pv_aktion_kdn_bby,
        SUM(0) AS pv_aktion_kdp_bby
    FROM dbp_etl.kmo_artbew_bon AS Z
    INNER JOIN dbp_etl_process.kpos_bon_bby_dates AS X ON Z.mandant_id = X.mandant_id
    LEFT JOIN (
        SELECT
            A.mandant_id,
            A.bon_id,
            A.dat_booking,
            A.bon_zeile,
            MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
            SUM(A.umsatz_brutto) AS promotion_brutto
        FROM dbp_etl.kmo_artbew_bon_promotion AS A
        LEFT JOIN dbp_data.l_bonuskauf AS B
            ON
                A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
                AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
        GROUP BY
            A.mandant_id,
            A.bon_id,
            A.dat_booking,
            A.bon_zeile
    ) AS p
        ON
            Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
            = p.bon_zeile
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.lkp_nb_id,
        Z.lkp_art_id,
        Z.lkp_posten_id,
        Z.dat_booking,
        Z.lkp_mwst,
        Z.lkp_mwst_id,
        Z.lkp_wrg,
        Z.lkp_umrechnungskurs,
        promo_fg,
        Z.ean_kasse,
        aktion_id,
        Z.kundenkarte_id,
        Z.kundenkarte_typ_id,
        Z.bonuskauf_id,
        Z.aktion_typ_id,
        Z.konditionsart_id,
        Z.vk_aktion_brutto,
        Z.vk_brutto,
        Z.bonuskauf_id_lb,
        Z.bde_kundenkarte_id
);


-- start bewart_det_id --

--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE max_cnt INT64;
    DECLARE counter INT64 default 0;
    DECLARE i INT64 default 1;
    DECLARE statement string;

    SET max_cnt = (
        select count(*) from dbp_etl_process.artbew_pv_logic
        where key_field = 'bewart_det_id' and logic = 'old'
    );

    WHILE i <= max_cnt DO
        SET statement = """(select statement from dbp_etl_process.artbew_pv_logic where key_field = 'bewart_det_id' and logic = 'old' and key_value = {i})""";
        set statement = replace(statement, '{i}', cast(i AS STRING));
        execute immediate statement;
        SET counter = counter + 1;
        SET i = i + 1;
    end WHILE;
    SELECT counter;
end;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END

-- start pv-bbys values --

--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    DECLARE max_cnt INT64;
    DECLARE counter INT64 default 0;
    DECLARE i INT64 default 1;
    DECLARE statement string;

    SET max_cnt = (
        select count(*) from dbp_etl_process.artbew_pv_logic
        where key_field = 'pv_values' and logic = 'old'
    );
    set counter = 0;
    set i = 1;

    WHILE i <= max_cnt DO
        set statement = """(select statement from dbp_etl_process.artbew_pv_logic where key_field = 'pv_values' and logic = 'old' and key_value = {i})""";
        set statement = replace(statement, '{i}', cast(i AS STRING));
        execute immediate statement;
        SET counter = counter + 1;
    end WHILE;
    SELECT counter;
end;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


CREATE OR REPLACE TABLE dbp_etl.artbew_subset2 AS
SELECT
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    SUM(umsatz_brutto_) AS umsatz_brutto,
    SUM(menge_) AS menge,
    SUM(umsatz_promotion_brutto_) AS umsatz_promotion_brutto,
    bewart_det_id,
    SUM(pv_aktion) AS pv_aktion,
    SUM(pv_bby) AS pv_bby,
    SUM(pv_kdn_bby) AS pv_kdn_bby,
    SUM(pv_kdp_bby) AS pv_kdp_bby,
    SUM(pv_aktion_bby) AS pv_aktion_bby,
    SUM(pv_aktion_kdn_bby) AS pv_aktion_kdn_bby,
    SUM(pv_aktion_kdp_bby) AS pv_aktion_kdp_bby
FROM dbp_etl_process.artbew_pv_subset AS L
GROUP BY
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    bewart_det_id;


INSERT INTO dbp_etl.artbew_kmo_tmp (
    wup_id, mandant_id, bewart_id, bewart_det_id, gp_id, nb_id, art_id,
    dat, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id, pv_aktion, pv_bby,
    pv_kdn_bby, pv_kdp_bby, pv_aktion_bby, pv_aktion_kdn_bby, pv_aktion_kdp_bby
)
(
    SELECT
        L.wup_id,
        L.mandant_id,
        CASE
            WHEN L.dat_booking >= CAST(X.dat AS DATE)
                THEN CASE
                    WHEN TRIM(L.aktion_id) <> ''
                        THEN 1002
                    ELSE 1001
                END
            ELSE COALESCE(R.bewart_id, 1001)
        END AS bewart_id,
        L.bewart_det_id,
        -1 AS gp_id,
        L.lkp_nb_id AS nb_id,
        L.lkp_art_id AS art_id,
        L.dat_booking AS dat,
        CASE
            WHEN L.dat_booking >= CAST(X.dat AS DATE)
                THEN TRIM(L.aktion_id)
            ELSE COALESCE(R.aktion_id, '')
        END AS aktion_id,
        L.promo_fg,
        CAST(L.ean_kasse AS INTEGER) AS ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        L.lkp_mwst_id AS mwst_id,
        L.menge,
        L.lkp_wrg AS wrg,
        CAST(ROUND(CAST(L.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        ROUND(CAST(L.umsatz_brutto / (1 + L.lkp_mwst / 100) * L.lkp_umrechnungskurs AS NUMERIC), 8) AS diff_umsatz_netto_konz
        ,
        CAST(ROUND(CAST(L.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) - CAST(ROUND(CAST(L.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST(ROUND(
            CAST(L.umsatz_brutto * L.lkp_umrechnungskurs AS NUMERIC), 8) - ROUND(
            CAST(L.umsatz_brutto / (1 + L.lkp_mwst / 100) * L.lkp_umrechnungskurs AS NUMERIC),
            8
        ) AS NUMERIC) AS diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(L.lkp_posten_id, ' ') AS posten_id,
        ROUND(CAST(L.pv_aktion AS NUMERIC), 8) AS pv_aktion,
        ROUND(CAST(L.pv_bby * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) AS pv_bby,
        ROUND(CAST(L.pv_kdn_bby * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) AS pv_kdn_bby,
        ROUND(CAST(L.pv_kdp_bby * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) AS pv_kdp_bby,
        ROUND(CAST(L.pv_aktion_bby AS NUMERIC), 8) AS pv_aktion_bby,
        ROUND(CAST(L.pv_aktion_kdn_bby AS NUMERIC), 8) AS pv_aktion_kdn_bby,
        ROUND(CAST(L.pv_aktion_kdp_bby AS NUMERIC), 8) AS pv_aktion_kdp_bby
    FROM dbp_etl.artbew_subset2 AS L
    INNER JOIN dbp_etl_process.kpos_bon_bby_dates AS X ON L.mandant_id = X.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 AS conv_fg
        FROM dbp_data.mandant_wrg_zu_per AS A
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS y ON L.mandant_id = y.mandant_id AND L.lkp_wrg = y.wrg_id
    LEFT JOIN
        dbp_etl_process.marktabschriften_stamm
            AS R
        ON
            L.mandant_id = R.mandant_id AND L.lkp_art_id =
            R.art_id AND L.wup_id = R.wup_id AND L.lkp_nb_id = R.nb_id AND L.dat_booking = R.dat
);


DELETE FROM dbp_data.artbew AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp
) AND bewart_id <> 1010;


DELETE FROM dbp_data.artbew_promotion_zu AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp
    WHERE promo_fg = 1
) AND konditionsart_id <> 'RB19';


INSERT INTO dbp_data.artbew (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep,
    ek_mep_vor_fwu, ek_mep_vor_fwu_konz, einstandspreis, logkostenzuschlag, bezugsweg_id, ek_netto_bnk, ek_netto_bnk_sachk,
    posten_id, bonusbasis, bonusbasis_konz, bewart_det_id, pv_aktion, pv_bby, pv_kdn_bby, pv_kdp_bby, pv_aktion_bby,
    pv_aktion_kdn_bby, pv_aktion_kdp_bby, td_update, td_insert
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    ean_kasse,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge_sum,
    wrg,
    umsatz_netto_sum,
    diff_umsatz_netto_konz,
    umsatz_mwst_betrag_sum,
    diff_umsatz_mwst_betrag_konz,
    zero_enc AS ek_brutto,
    zero_enc AS ek_netto,
    zero_enc AS ek_nettonetto,
    zero_enc AS ek_kal_basis,
    zero_enc AS ek_mep,
    0 AS ek_mep_vor_fwu,
    NULL AS ek_mep_vor_fwu_konz,
    zero_enc AS einstandspreis,
    0 AS logkostenzuschlag,
    bezugsweg_id,
    zero_enc AS ek_netto_bnk,
    zero_enc AS ek_netto_bnk_sachk,
    posten_id,
    0 AS bonusbasis,
    NULL AS bonusbasis_konz,
    bewart_det_id,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg,
        posten_id,
        bezugsweg_id,
        0 AS zero_enc,
        ean_kasse,
        bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby,
        SUM(menge) AS menge_sum,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum,
        SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz,
        SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz
    FROM dbp_etl.artbew_kmo_tmp
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg,
        posten_id,
        bezugsweg_id,
        zero_enc,
        ean_kasse,
        bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby
) AS t0);


DELETE FROM dbp_etl.kmo_artbew_bon_promotion
WHERE COALESCE(umsatz_brutto, 0) = 0;


INSERT INTO dbp_data.artbew_promotion_zu (
    art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id,
    konditionsart_id, ean_kasse, wrg_id, betrag_promo_netto, betrag_mwst, umrechnungskurs, system_id, menge_promo,
    umsatz_promo_netto, umsatz_mwst
)
(
    SELECT
        L.lkp_art_id AS art_id,
        L.mandant_id,
        L.wup_id,
        L.lkp_nb_id AS nb_id,
        L.dat_booking AS dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        L.ean_kasse,
        L.lkp_wrg AS wrg_id,
        SUM(COALESCE(CAST(ROUND(CAST(P.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC), 0)),
        SUM(CAST(ROUND(CAST(P.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) - CAST(ROUND(CAST(P.umsatz_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS NUMERIC)),
        ROUND(CAST(L.lkp_umrechnungskurs AS NUMERIC), 5) AS umrechnungskurs,
        COALESCE(K.system_id, 0) AS system_id,
        SUM(COALESCE(P.menge_promo, 0)),
        SUM(COALESCE(CAST(ROUND(CAST(P.umsatz_promo_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC), 0)),
        SUM(COALESCE(CAST(ROUND(CAST(P.umsatz_promo_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) - CAST(ROUND(CAST(P.umsatz_promo_brutto * CASE
            WHEN y.conv_fg = 1
                THEN L.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS NUMERIC), 0))
    FROM dbp_etl.kmo_artbew_bon AS L
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 AS conv_fg
        FROM dbp_data.mandant_wrg_zu_per AS A
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS y ON L.mandant_id = y.mandant_id AND L.lkp_wrg = y.wrg_id
    INNER JOIN dbp_etl.kmo_artbew_bon_promotion AS P
        ON
            L.mandant_id = P.mandant_id AND L.bon_id = P.bon_id
            AND L.dat_booking = P.dat_booking AND L.bon_zeile = P.bon_zeile
    LEFT JOIN dbp_data.l_konditionsart AS K ON P.mandant_id = K.mandant_id AND P.konditionsart_id = K.konditionsart_id

    GROUP BY
        L.mandant_id,
        L.wup_id,
        nb_id,
        art_id,
        dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        wrg_id,
        umrechnungskurs,
        system_id,
        L.ean_kasse
);


INSERT INTO dbp_data.artbew_agg_wt (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt
    )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);


INSERT INTO dbp_etl_process.uapc_artbew_delta (mandant_id, wup_id, dat, row_id, td_insert, td_update)
(SELECT
    mandant_id,
    wup_id,
    dat,
    (ROW_NUMBER()
        OVER (ORDER BY mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, dat IS NULL, dat)) + COALESCE((
        SELECT MAX(row_id)
        FROM dbp_etl_process.uapc_artbew_delta
    ), 0) AS row_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM (
    SELECT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp
    GROUP BY
        wup_id,
        mandant_id,
        dat
) AS t0);


UPDATE dbp_data.wupcal SET
    datenlieferung_artbew = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
    umsatz_brutto_ods_verkauf = x1.umsatz_netto_sum + x1.umsatz_mwst_betrag_sum,
    wrg_id = x1.wrg_,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id AS mandant_id_,
        wup_id AS wup_id_,
        nb_id AS nb_id_,
        dat AS dat_,
        wrg AS wrg_,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
    FROM dbp_etl.artbew_kmo_tmp
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_,
        wrg_
) AS x1
WHERE
    wupcal.mandant_id = x1.mandant_id_ AND wupcal.wup_id = x1.wup_id_ AND wupcal.nb_id = x1.nb_id_ AND wupcal.dat = x1.dat_;


UPDATE dbp_data.wupcal SET
    bonanzahl = s.anz_kunden_,
    bonanzahl_imbiss = s.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = CAST(s.umsatz_brutto_ods_kassenabschluss_ AS NUMERIC),
    datenlieferung_bonanzahl = 1,
    wrg_id = s.wrg_id_ FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto * COALESCE(x.umrech, 1)) AS umsatz_brutto_ods_kassenabschluss_,
        MIN(x.wrg_id) AS wrg_id_
    FROM dbp_ods.ods_bon_kassenabschluss AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS WRG
        ON
            K.mandant_id = WRG.mandant_id AND K.bon_dat BETWEEN
            WRG.dat_von AND WRG.dat_bis
    INNER JOIN dbp_data.mandant AS Y ON K.mandant_id = Y.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 / CAST(umrechnungskurs AS FLOAT64) AS umrech
        FROM dbp_data.mandant_wrg_zu_per
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS x ON K.mandant_id = x.mandant_id AND WRG.wrg_id = x.von_wrg_id
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat
        FROM dbp_etl.artbew_kmo_tmp
        GROUP BY
            wup_id,
            mandant_id,
            dat
    ) AS a ON K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat = a.dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS s
WHERE wupcal.mandant_id = s.mandant_id_ AND wupcal.wup_id = s.wup_id_ AND wupcal.dat = s.dat_;


/*
Jetzt kann nachträglich noch eine Kassenabschluss kommen.
Wir benötigen dann die Summe der beiden Werte in der wupcal Spalte.
*/


CREATE OR REPLACE TABLE dbp_etl.wupcal_correction AS
-- sum(umsatz_brutto) AS
-- umsatz_brutto
-- group by all
SELECT DISTINCT
    mandant_id,
    wup_id,
    bon_dat
FROM dbp_ods.ods_bon_kassenabschluss
WHERE (
    mandant_id, wup_id, bon_dat) IN (
    SELECT (mandant_id, wup_id, bon_dat)
    FROM dbp_ods.ods_bon_kassenabschluss
    WHERE
        mandant_id > 1
        AND bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 7 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat
    HAVING COUNT(*) > 1
)
ORDER BY
    mandant_id NULLS LAST,
    wup_id NULLS LAST,
    bon_dat DESC NULLS FIRST;


UPDATE dbp_data.wupcal SET
    bonanzahl = s.anz_kunden_,
    bonanzahl_imbiss = s.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = CAST(s.umsatz_brutto_ods_kassenabschluss_ AS NUMERIC),
    datenlieferung_bonanzahl = 1,
    wrg_id = s.wrg_id_ FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto * COALESCE(x.umrech, 1)) AS umsatz_brutto_ods_kassenabschluss_,
        MIN(x.wrg_id) AS wrg_id_
    FROM dbp_ods.ods_bon_kassenabschluss AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per AS WRG
        ON
            K.mandant_id = WRG.mandant_id AND K.bon_dat BETWEEN
            WRG.dat_von AND WRG.dat_bis
    INNER JOIN dbp_data.mandant AS Y ON K.mandant_id = Y.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 / CAST(umrechnungskurs AS FLOAT64) AS umrech
        FROM dbp_data.mandant_wrg_zu_per
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS x ON K.mandant_id = x.mandant_id AND WRG.wrg_id = x.von_wrg_id
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat
        FROM dbp_etl.wupcal_correction
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat
    ) AS a ON K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat = a.bon_dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS s
WHERE wupcal.mandant_id = s.mandant_id_ AND wupcal.wup_id = s.wup_id_ AND wupcal.dat = s.dat_;


UPDATE dbp_data.wup SET
    kassentyp = 'KPO'
WHERE (
    mandant_id, nb_id, wup_id) IN (
    SELECT (mandant_id, nb_id, wup_id)
    FROM dbp_etl.artbew_kmo_tmp
);


INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu (
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id,
    anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg, bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id,
    kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        mandant_id,
        lkp_art_id,
        wup_id,
        lkp_nb_id,
        dat_booking,
        0 AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        '' AS kreistyp_gruppe_id,
        0 AS wg_id,
        MAX(lkp_umrechnungskurs)
    FROM dbp_etl.kmo_artbew_bon AS A
    WHERE (
        mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, art_id, dat)
        FROM dbp_etl.kmo_wpuums_art_gp_wup_zu
    )
    GROUP BY
        mandant_id,
        dat_booking,
        wup_id,
        lkp_art_id,
        lkp_nb_id
);


UPDATE dbp_ods.bon_load_status SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.kmo_artbew_bon_delta
);


-- crm_kartebew


INSERT INTO dbp_etl.artbew_kmo_tmp_crm (
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat,
    aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto,
    diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id, kundenkarte_id,
    bon_id
)
(
    SELECT
        l.wup_id,
        l.mandant_id,
        CASE
            WHEN l.dat_booking >= CAST(X0.dat AS DATE)
                THEN CASE
                    WHEN TRIM(l.aktion_id) <> ''
                        THEN 1002
                    ELSE 1001
                END
            ELSE COALESCE(R.bewart_id, 1001)
        END AS bewart_id,
        -1 AS gp_id,
        l.lkp_nb_id AS nb_id,
        l.lkp_art_id AS art_id,
        l.dat_booking AS dat,
        CASE
            WHEN l.dat_booking >= CAST(X0.dat AS DATE)
                THEN TRIM(l.aktion_id)
            ELSE COALESCE(R.aktion_id, '')
        END AS aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge_ AS menge,
        l.lkp_wrg AS wrg,
        CAST(ROUND(CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        ROUND(
            CAST(CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC) * l.lkp_umrechnungskurs AS NUMERIC), 8) AS
        diff_umsatz_netto_konz,
        CAST(ROUND(CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) - CAST(ROUND(CAST(l.umsatz_brutto_ * CASE
            WHEN y.conv_fg = 1
                THEN l.lkp_umrechnungskurs
            ELSE 1
        END AS NUMERIC), 8) / (1 + l.lkp_mwst / 100) AS NUMERIC) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST(ROUND(CAST(
            l.umsatz_brutto_ * l.lkp_umrechnungskurs AS NUMERIC), 8) - ROUND(CAST(
            CAST(l.umsatz_brutto_ / (1 + l.lkp_mwst / 100) AS NUMERIC)
            * l.lkp_umrechnungskurs AS NUMERIC
        ), 8) AS NUMERIC) AS diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(l.lkp_posten_id, ' ') AS posten_id,
        l.kundenkarte_id,
        l.bon_id
    FROM (
        SELECT
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            CASE
                WHEN COALESCE(p.promotion_brutto, 0) <> 0
                    THEN 1
                ELSE 0
            END AS promo_fg,
            Z.ean_kasse,
            CASE
                WHEN Z.dat_booking >= CAST(X.dat AS DATE) AND p.aktion_id <> ''
                    THEN p.aktion_id
                ELSE Z.aktion_id
            END AS aktion_id,
            Z.kundenkarte_id,
            Z.bon_id,
            SUM(Z.umsatz_brutto) AS umsatz_brutto_,
            SUM(Z.menge) AS menge_,
            SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_
        FROM dbp_etl.kmo_artbew_bon AS Z
        INNER JOIN dbp_etl_process.kpos_bon_bby_dates AS X ON Z.mandant_id = X.mandant_id
        LEFT JOIN (
            SELECT
                A.mandant_id,
                A.bon_id,
                A.dat_booking,
                A.bon_zeile,
                MAX(COALESCE(B.aktion_id, '')) AS aktion_id,
                SUM(A.umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.kmo_artbew_bon_promotion AS A
            LEFT JOIN dbp_data.l_bonuskauf AS B
                ON
                    A.mandant_id = B.mandant_id AND A.bonuskauf_id = B.bonuskauf_id
                    AND A.dat_booking BETWEEN B.dat_von AND B.dat_bis
            GROUP BY
                A.mandant_id,
                A.bon_id,
                A.dat_booking,
                A.bon_zeile
        ) AS p
            ON
                Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
                = p.bon_zeile
        WHERE
            Z.mandant_id IN (2, 4, 7, 6, 5, 8)
            OR Z.mandant_id IN (3) AND Z.kundenkarte_typ_id = 2
        GROUP BY
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            promo_fg,
            Z.ean_kasse,
            aktion_id,
            Z.kundenkarte_id,
            Z.bon_id
    ) AS l
    INNER JOIN dbp_etl_process.kpos_bon_bby_dates AS X0 ON l.mandant_id = X0.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 AS conv_fg
        FROM dbp_data.mandant_wrg_zu_per
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS y ON l.mandant_id = y.mandant_id AND l.lkp_wrg = y.wrg_id
    LEFT JOIN dbp_etl_process.marktabschriften_stamm AS R
        ON
            l.mandant_id = R.mandant_id AND l.lkp_art_id =
            R.art_id AND l.wup_id = R.wup_id AND l.lkp_nb_id = R.nb_id AND l.dat_booking = R.dat
    GROUP BY
        l.mandant_id,
        l.wup_id,
        nb_id,
        art_id,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg,
        posten_id,
        bezugsweg_id,
        menge,
        umsatz_netto,
        umsatz_mwst_betrag,
        l.promo_fg,
        l.ean_kasse,
        diff_umsatz_netto_konz,
        diff_umsatz_mwst_betrag_konz,
        l.kundenkarte_id,
        l.bon_id
);


DELETE FROM dbp_data.crm_kartebew AS A
WHERE dat IN (
    SELECT DISTINCT *
    FROM dbp_etl.kmo_artbew_bon_dat) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM (SELECT DISTINCT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_crm) AS t3
);


INSERT INTO dbp_data.crm_kartebew (
    mandant_id, wup_id, nb_id, kundenkarte_id, dat, wrg_id,
    umsatz_netto_sa, umsatz_netto_af, umsatz_brutto_sa, umsatz_brutto_af, anz_bons
)
(
    SELECT
        AKTC.mandant_id,
        AKTC.wup_id,
        AKTC.nb_id,
        AKTC.kundenkarte_id,
        AKTC.dat,
        AKTC.wrg,
        CAST(SUM(CASE
            WHEN AKTC.bewart_id = 1002
                THEN AKTC.umsatz_netto
            ELSE 0
        END) AS NUMERIC) AS umsatz_netto_sa,
        CAST(SUM(CASE
            WHEN AKTC.bewart_id = 1001
                THEN AKTC.umsatz_netto
            ELSE 0
        END) AS NUMERIC) AS umsatz_netto_af,
        CAST(SUM(CASE
            WHEN AKTC.bewart_id = 1002
                THEN AKTC.umsatz_netto + AKTC.umsatz_mwst_betrag
            ELSE 0
        END) AS NUMERIC) AS umsatz_brutto_sa,
        CAST(SUM(CASE
            WHEN AKTC.bewart_id = 1001
                THEN AKTC.umsatz_netto + AKTC.umsatz_mwst_betrag
            ELSE 0
        END) AS NUMERIC) AS umsatz_brutto_af,
        COUNT(DISTINCT AKTC.bon_id) AS anz_bons
    FROM dbp_etl.artbew_kmo_tmp_crm AS AKTC
    LEFT JOIN dbp_data.bewart_det_ecommerce AS BDE
        ON
            AKTC.mandant_id = BDE.mandant_id AND AKTC.kundenkarte_id
            = BDE.kundenkarte_id
    WHERE
        AKTC.kundenkarte_id IS NOT NULL
        AND BDE.kundenkarte_id IS NULL
    GROUP BY
        AKTC.mandant_id,
        AKTC.wup_id,
        AKTC.nb_id,
        AKTC.kundenkarte_id,
        AKTC.dat,
        AKTC.wrg
);


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp;


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_crm;


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant;
