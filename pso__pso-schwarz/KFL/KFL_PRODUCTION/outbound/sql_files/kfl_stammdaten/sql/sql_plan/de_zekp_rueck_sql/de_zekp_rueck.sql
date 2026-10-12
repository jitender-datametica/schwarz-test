-- Sichern der ZEKP.


TRUNCATE TABLE dbp_etl_process.zekp_rueck;


INSERT INTO dbp_etl_process.zekp_rueck
(
    SELECT *
    FROM dbp_data.art_gp_wup_zu_per
);


DELETE FROM dbp_etl.de_zekp
WHERE datab > CURRENT_DATE("Europe/Berlin");


UPDATE dbp_etl.de_zekp SET
    werks = -1
WHERE werks = 0;


UPDATE dbp_etl.de_zekp SET
    zollba = 99999.9999
WHERE ABS(zollba / 100) > 99999.9999;


UPDATE dbp_etl.de_zekp SET
    kompmeng = b.komponentenmenge FROM (
    SELECT
        A.mandant_id,
        A.kl_art_id,
        SUM(C.komponentenmenge) AS komponentenmenge
    FROM dbp_data.art AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            MAX(stueckliste_id) AS stueckliste_id
        FROM dbp_data.stueckliste
        WHERE
            stueckliste_verwendung_id = 3
            AND dat_bis = DATE '9999-12-31'
        GROUP BY
            mandant_id,
            art_id
    ) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
    INNER JOIN dbp_data.stueckliste_det AS C
        ON
            b.mandant_id = C.mandant_id AND b.stueckliste_id = C.stueckliste_id
            AND C.stueckliste_typ_id = 'M' AND C.komponentenmenge_einh_id = 'ST' AND C.dat_bis = DATE '9999-12-31'
    WHERE
        A.artikeltyp_id = 12
        AND A.display_id IN (1, 2)
    GROUP BY
        A.mandant_id,
        A.kl_art_id
) AS b
WHERE de_zekp.matnr = b.kl_art_id;


CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    wrg_id STRING(3),
    komponentenmenge NUMERIC(29, 4),
    ek_brutto_nrfb_rab NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    bezugsnebenkosten NUMERIC(29, 4),
    zollwert NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    cycle_id INTEGER
);


INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp (
    mandant_id, art_id, gp_id, wup_id, nb_id,
    einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
    zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id
)
(
    SELECT
        t3.mandant_id,
        t3.art_id,
        t0.lifnr AS gp_id_,
        CASE
            WHEN t0.werks IS NULL
                THEN -1
            ELSE t0.werks
        END AS wup_id_,
        CASE
            WHEN t0.werks IS NULL OR t0.werks = -1
                THEN NULL
            ELSE wp.nb_id
        END AS nb_id_,
        COALESCE(t5.einkaufsorganisation_id, 1000) AS einkaufsorganisation_id_,
        DATE(t0.datab) AS dat_von,
        DATE('9999-12-31') AS dat_bis,
        t0.abrut / 100 AS ek_brutto,
        t0.aknet / 100 AS ek_netto,
        t0.aknne / 100 AS ek_nettonetto,
        t0.ekkba / 100 AS ek_kal_basis,
        t0.mepre / 100 AS ek_mep,
        t0.lsein / 100 AS einstandspreis,
        CAST(COALESCE(CASE
            WHEN
                CASE
                    WHEN t0.werks IS NULL
                        THEN -1
                    ELSE t0.werks
                END = -1 OR t0.abrut = 0 AND t0.aknet = 0 AND t0.aknne = 0 AND t0.ekkba = 0 AND t0.mepre = 0 AND t0.lsein = 0
                THEN 0
            ELSE t0.lokau / 100
        END, 0) AS NUMERIC) AS logistikkostenzuschlag,
        CASE
            WHEN
                CASE
                    WHEN t0.werks IS NULL
                        THEN -1
                    ELSE t0.werks
                END = -1
                THEN 1
            ELSE 4
        END AS bezugsweg_id,
        t0.konwa AS wrg_id,
        CAST(t0.kompmeng AS NUMERIC) AS komponentenmenge,
        t0.abrna / 100 AS ek_brutto_nrfb_rab,
        t0.abonba / 100 AS bonusbasis,
        t0.bnk / 100 AS bezugsnebenkosten,
        t0.zollba / 100 AS zollwert,
        t0.aknb / 100 AS ek_netto_bnk,
        t0.aknbs / 100 AS ek_netto_bnk_sachk,
        t0.cycle_id
    FROM (SELECT
        1 AS cycle_id,
        matnr,
        lifnr,
        werks,
        datab,
        abrut,
        aknet,
        aknne,
        ekkba,
        mepre,
        lsein,
        konwa,
        CASE
            WHEN kompmeng IS NULL OR kompmeng = 0
                THEN 1
            ELSE kompmeng
        END AS kompmeng,
        lokau,
        abrna,
        abonba,
        bnk,
        zollba,
        aknb,
        aknbs
    FROM dbp_etl.de_zekp
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY matnr, lifnr, werks, datab ORDER BY 1 IS NULL, 1)) = 1) AS t0
    INNER JOIN (SELECT
        kl_art_id,
        art_id,
        mandant_id
    FROM dbp_data.art
    WHERE mandant_id = 1
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t3
        ON
            t0.matnr
            = t3.kl_art_id AND t3.mandant_id = 1
    INNER JOIN (
        SELECT
            gp_id,
            einkaufsorganisation_id,
            mandant_id
        FROM dbp_data.gp
        QUALIFY
            (ROW_NUMBER() OVER (PARTITION BY gp_id ORDER BY einkaufsorganisation_id IS NULL, einkaufsorganisation_id)) =
            1
    ) AS t5 ON t0.lifnr = t5.gp_id AND t5.mandant_id = 1
    LEFT JOIN (SELECT
        wup_id,
        mandant_id,
        nb_id
    FROM dbp_data.wup) AS wp ON t0.werks = wp.wup_id AND wp.mandant_id = 1
);


CREATE OR REPLACE TABLE dbp_etl.art_gp_wup_zu_per_tmp_xxx LIKE dbp_etl.art_gp_wup_zu_per_tmp;


INSERT INTO dbp_etl.art_gp_wup_zu_per_tmp_xxx (
    mandant_id, art_id, gp_id, wup_id, nb_id,
    einkaufsorganisation_id, dat_von, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, bezugsweg_id, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten,
    zollwert, ek_netto_bnk, ek_netto_bnk_sachk, cycle_id
)
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_tmp
);


UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx SET
    ek_brutto = art_gp_wup_zu_per_tmp_xxx.ek_brutto / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_netto = art_gp_wup_zu_per_tmp_xxx.ek_netto / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_nettonetto = art_gp_wup_zu_per_tmp_xxx.ek_nettonetto / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_kal_basis = art_gp_wup_zu_per_tmp_xxx.ek_kal_basis / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_mep = art_gp_wup_zu_per_tmp_xxx.ek_mep / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    einstandspreis = art_gp_wup_zu_per_tmp_xxx.einstandspreis / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    logistikkostenzuschlag = art_gp_wup_zu_per_tmp_xxx.logistikkostenzuschlag / art_gp_wup_zu_per_tmp_xxx.komponentenmenge
    ,
    ek_brutto_nrfb_rab = art_gp_wup_zu_per_tmp_xxx.ek_brutto_nrfb_rab / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    bonusbasis = art_gp_wup_zu_per_tmp_xxx.bonusbasis / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    bezugsnebenkosten = art_gp_wup_zu_per_tmp_xxx.bezugsnebenkosten / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    zollwert = art_gp_wup_zu_per_tmp_xxx.zollwert / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_netto_bnk = art_gp_wup_zu_per_tmp_xxx.ek_netto_bnk / art_gp_wup_zu_per_tmp_xxx.komponentenmenge,
    ek_netto_bnk_sachk = art_gp_wup_zu_per_tmp_xxx.ek_netto_bnk_sachk / art_gp_wup_zu_per_tmp_xxx.komponentenmenge
WHERE komponentenmenge > 1;


DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx
WHERE ek_brutto = 0;


UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_von,
    gp_id,
    bezugsweg_id,
    einkaufsorganisation_id,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id,
            art_id, gp_id, bezugsweg_id, einkaufsorganisation_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL,
        dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat_von,
        gp_id,
        bezugsweg_id,
        einkaufsorganisation_id
    FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx AS L
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        art_id,
        gp_id,
        wup_id,
        nb_id,
        einkaufsorganisation_id,
        dat_von,
        bezugsweg_id
) AS t1) AS dt1
WHERE
    art_gp_wup_zu_per_tmp_xxx.mandant_id = dt1.mandant_id AND art_gp_wup_zu_per_tmp_xxx.wup_id = dt1.wup_id AND
    COALESCE(art_gp_wup_zu_per_tmp_xxx.nb_id, -999) = COALESCE(dt1.nb_id, -999) AND art_gp_wup_zu_per_tmp_xxx.art_id
    = dt1.art_id AND art_gp_wup_zu_per_tmp_xxx.dat_von = dt1.dat_von AND art_gp_wup_zu_per_tmp_xxx.gp_id = dt1.gp_id
    AND art_gp_wup_zu_per_tmp_xxx.einkaufsorganisation_id = dt1.einkaufsorganisation_id AND art_gp_wup_zu_per_tmp_xxx.bezugsweg_id = dt1.bezugsweg_id AND art_gp_wup_zu_per_tmp_xxx.dat_bis <> dt1.dat_bis;


DELETE FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx
WHERE dat_bis < DATE '2021-09-25';


UPDATE dbp_etl.art_gp_wup_zu_per_tmp_xxx AS art_gp_wup_zu_per_tmp_xxx0 SET
    dat_von = DATE('2021-09-25') FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        gp_id,
        MIN(dat_von) AS dat_von
    FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx
    WHERE DATE '2021-09-25' BETWEEN dat_von AND dat_bis
    GROUP BY
        mandant_id,
        art_id,
        gp_id,
        wup_id
) AS t1
WHERE
    art_gp_wup_zu_per_tmp_xxx0.mandant_id = t1.mandant_id AND art_gp_wup_zu_per_tmp_xxx0.wup_id = t1.wup_id AND
    art_gp_wup_zu_per_tmp_xxx0.art_id = t1.art_id AND art_gp_wup_zu_per_tmp_xxx0.gp_id = t1.gp_id AND
    art_gp_wup_zu_per_tmp_xxx0.dat_von = t1.dat_von;


DELETE FROM dbp_data.art_gp_wup_zu_per
WHERE (mandant_id, art_id, gp_id, wup_id, einkaufsorganisation_id, dat_von, COALESCE(nb_id, -999), bezugsweg_id) IN (SELECT
    (t0.mandant_id, t0.art_id, t0.gp_id, t0.wup_id, t0.einkaufsorganisation_id, t0.dat_von, t0.a47398834, t0.bezugsweg_id
    )
FROM (
    SELECT
        AGP.mandant_id,
        AGP.art_id,
        AGP.gp_id,
        AGP.wup_id,
        AGP.einkaufsorganisation_id,
        AGP.dat_von,
        COALESCE(AGP.nb_id, -999) AS a47398834,
        AGP.bezugsweg_id
    FROM dbp_data.art_gp_wup_zu_per AS AGP
    INNER JOIN dbp_etl.art_gp_wup_zu_per_tmp_xxx AS AG
        ON
            AGP.mandant_id = AG.mandant_id AND AGP.art_id
            = AG.art_id AND AGP.gp_id = AG.gp_id AND AGP.wup_id = AG.wup_id AND AGP.einkaufsorganisation_id = AG.einkaufsorganisation_id
            AND COALESCE(AGP.nb_id, -999) = COALESCE(AG.nb_id, -999) AND AGP.bezugsweg_id = AG.bezugsweg_id AND AGP.dat_von
            >= AG.dat_von AND AGP.mandant_id = 1
    GROUP BY
        AGP.mandant_id,
        AGP.art_id,
        AGP.gp_id,
        AGP.wup_id,
        AGP.einkaufsorganisation_id,
        AGP.dat_von,
        a47398834,
        AGP.bezugsweg_id
) AS t0) AND mandant_id = 1;


INSERT INTO dbp_data.art_gp_wup_zu_per (
    mandant_id, gp_id, wup_id, nb_id, dat_von, bezugsweg_id, art_id,
    einkaufsorganisation_id, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten, zollwert,
    ek_netto_bnk, ek_netto_bnk_sachk, cycle_id, ek_mep_vor_fwu
)
(
    SELECT
        mandant_id,
        gp_id,
        wup_id,
        nb_id,
        dat_von,
        bezugsweg_id,
        art_id,
        einkaufsorganisation_id,
        dat_bis,
        ek_brutto,
        ek_netto,
        ek_nettonetto,
        ek_kal_basis,
        ek_mep,
        einstandspreis,
        logistikkostenzuschlag,
        wrg_id,
        komponentenmenge,
        ek_brutto_nrfb_rab,
        bonusbasis,
        bezugsnebenkosten,
        zollwert,
        ek_netto_bnk,
        ek_netto_bnk_sachk,
        cycle_id,
        ek_mep AS ek_mep_vor_fwu
    FROM dbp_etl.art_gp_wup_zu_per_tmp_xxx
    WHERE
        dat_von >= DATE '2021-09-25'
        AND dat_von <= dat_bis
);


UPDATE dbp_data.art_gp_wup_zu_per SET
    dat_bis = dt1.dat_bis FROM (SELECT
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_von,
    gp_id,
    bezugsweg_id,
    einkaufsorganisation_id,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id,
            art_id, gp_id, bezugsweg_id, einkaufsorganisation_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1
        PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id, einkaufsorganisation_id ORDER BY dat_von IS NULL,
        dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat_von,
        gp_id,
        bezugsweg_id,
        einkaufsorganisation_id
    FROM dbp_data.art_gp_wup_zu_per AS L
    WHERE mandant_id = 1
    GROUP BY
        mandant_id,
        gp_id,
        wup_id,
        nb_id,
        dat_von,
        bezugsweg_id,
        art_id,
        einkaufsorganisation_id
) AS t1) AS dt1
WHERE
    art_gp_wup_zu_per.mandant_id = dt1.mandant_id AND art_gp_wup_zu_per.wup_id = dt1.wup_id AND COALESCE(art_gp_wup_zu_per.nb_id, -999) = COALESCE(dt1.nb_id, -999) AND art_gp_wup_zu_per.art_id = dt1.art_id AND art_gp_wup_zu_per.dat_von
    = dt1.dat_von AND art_gp_wup_zu_per.gp_id = dt1.gp_id AND art_gp_wup_zu_per.einkaufsorganisation_id = dt1.einkaufsorganisation_id
    AND art_gp_wup_zu_per.bezugsweg_id = dt1.bezugsweg_id AND art_gp_wup_zu_per.dat_bis <> dt1.dat_bis;
