----------------
---PREPARATION--
----------------
---kfl_ais<<SEP>>sql<<SEP>>sql_plan<<SEP>>ais_sal_kmo_sql<<FILE>>ais_sal_kmo_001

CREATE OR REPLACE TABLE dbp_etl.sal_wochen_2 AS
SELECT
    mandant_id,
    kjwo
FROM (
    SELECT
        B.mandant_id,
        C.kjwo,
        (RANK() OVER (
            PARTITION BY
                B.mandant_id ORDER BY
                B.mandant_id IS NULL, B.mandant_id, C.kjwo IS NULL DESC, C.kjwo
                DESC
        )) * -1 AS akt_wo
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 AS A
    INNER JOIN (SELECT
        mandant_id,
        MAX(kjmo) AS kjmo
    FROM dbp_data.art_nielsen_fakten_kjmo_2
    WHERE mandant_id > 1
    GROUP BY mandant_id) AS B ON A.kjmo_sort = B.kjmo
    INNER JOIN dbp_data.woche_2 AS C ON A.kjwo_bis >= C.kjwo
    QUALIFY ((RANK() OVER (
        PARTITION BY
            B.mandant_id ORDER BY
            B.mandant_id IS NULL, B.mandant_id, C.kjwo IS NULL DESC, C.kjwo
            DESC
    )) * -1) BETWEEN -52 AND (-1)
) AS t2
GROUP BY
    mandant_id,
    kjwo;


CREATE OR REPLACE TABLE dbp_etl.sal_monat_2 AS
SELECT
    mandant_id,
    MAX(kjmo) AS kjmo
FROM dbp_data.art_nielsen_fakten_kjmo_2
WHERE mandant_id > 1
GROUP BY mandant_id;


CREATE OR REPLACE TABLE dbp_etl.st_ab_wg_art_wo_sum_kmo_2 AS
SELECT
    A.mandant_id,
    C.kjwo,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id,
    A.menge,
    A.umsatz_netto,
    A.ek_mep,
    A.einstandspreis
FROM dbp_data.artbew_wo_sum_2 AS A
INNER JOIN dbp_data.woche_kj_kl_2 AS C ON A.kjwo_kl = C.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_etl.sal_wochen_2 AS D ON A.mandant_id = D.mandant_id AND C.kjwo = D.kjwo;


CREATE OR REPLACE TABLE dbp_etl.st_listung_kw_kmo_2 AS
SELECT
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo,
    IFNULL(SUM(V01.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(V01.menge), 0) > 0
            THEN COUNT(DISTINCT V01.kjwo)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.st_ab_wg_art_wo_sum_kmo_2 AS V01
INNER JOIN dbp_data.wup_2 AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
        V04.mandant_id
GROUP BY
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo;


CREATE OR REPLACE TABLE dbp_etl.st_listung_sm_kw_kmo_2 AS
SELECT
    A.mandant_id,
    C.kjwo,
    S.sm_id,
    S.ksm_id,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id,
    SUM(A.menge) AS menge,
    SUM(A.umsatz_netto) AS umsatz_netto,
    SUM(A.ek_mep) AS ek_mep,
    SUM(A.einstandspreis) AS einstandspreis,
    IFNULL(SUM(A.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1002
            THEN A.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN A.bewart_id = 1001
            THEN A.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(A.menge), 0) > 0
            THEN COUNT(DISTINCT C.kjwo)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN A.bewart_id = 1002
                    THEN A.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN A.bewart_id = 1002
                    THEN A.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN A.bewart_id = 1002
                    THEN C.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN A.bewart_id = 1001
                    THEN A.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN A.bewart_id = 1001
                    THEN A.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN A.bewart_id = 1001
                    THEN C.kjwo
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anz_wo_mit_absatz_af
FROM dbp_data.artbew_wo_sum_2 AS A
INNER JOIN dbp_data.woche_kj_kl_2 AS C ON A.kjwo_kl = C.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_etl_process.sm_wup_wg_zu_per_2 AS S
    ON
        A.mandant_id = S.mandant_id AND B.wg_id = S.wg_id
        AND A.wup_id = S.wup_id AND A.nb_id = S.nb_id AND S.nb_id <> 99 AND S.arthiertyp_id = 2 AND S.dat_bis = PARSE_DATE(
            '%F',
            '9999-12-31'
        )
INNER JOIN dbp_etl.sal_wochen_2 AS D ON A.mandant_id = D.mandant_id AND C.kjwo = D.kjwo
WHERE
    S.sm_id BETWEEN 1 AND 5
    OR S.ksm_id IN ('K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8', 'K9')
GROUP BY
    A.mandant_id,
    C.kjwo,
    S.sm_id,
    S.ksm_id,
    B.wg_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.bewart_id;


CREATE OR REPLACE TABLE dbp_etl.st_listung_markt_tag_kmo_2 AS
SELECT
    V01.mandant_id,
    V03.wg_id,
    V01.art_id,
    V01.dat,
    V02.kjwo,
    V01.wup_id,
    IFNULL(SUM(V01.menge), 0) AS absatz,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1002
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_sa,
    IFNULL(SUM(CASE
        WHEN V01.bewart_id = 1001
            THEN V01.menge
        ELSE NULL
    END), 0) AS absatz_af,
    IFNULL(CASE
        WHEN IFNULL(SUM(V01.menge), 0) > 0
            THEN COUNT(DISTINCT V02.dat)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1002
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1002
                    THEN V02.dat
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz_sa,
    IFNULL(CASE
        WHEN
            IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) > 0 AND IFNULL(SUM(CASE
                WHEN V01.bewart_id = 1001
                    THEN V01.menge
                ELSE NULL
            END), 0) IS NOT NULL
            THEN COUNT(DISTINCT CASE
                WHEN V01.bewart_id = 1001
                    THEN V02.dat
                ELSE NULL
            END)
        ELSE NULL
    END, 0) AS anzahl_tage_mit_absatz_af
FROM dbp_data.artbew_2 AS V01
INNER JOIN dbp_data.tag_2 AS V02 ON V01.dat = V02.dat
INNER JOIN dbp_data.art_wg_zu_per_2 AS V03
    ON
        V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
        AND V03.arthiertyp_id = 2 AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wup_2 AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id =
        V04.mandant_id
INNER JOIN dbp_etl.sal_wochen_2 AS D ON V01.mandant_id = D.mandant_id AND V02.kjwo = D.kjwo
GROUP BY
    V01.mandant_id,
    V03.wg_id,
    V01.art_id,
    V01.dat,
    V02.kjwo,
    V01.wup_id;


CREATE OR REPLACE TABLE dbp_etl.anz_wo_absatz_pre_2 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wup_id INTEGER,
    anz_maerkte INTEGER,
    absatz_gesamt FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_tot_sk1_bis6 FLOAT64
);


CREATE OR REPLACE TABLE dbp_etl.anz_wo_listung_pre_2 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    wup_id INTEGER,
    anz_wo_listung_2 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_absatz_pre_2 (
    art_id, mandant_id, kjwo, wup_id, anz_maerkte, absatz_gesamt,
    anz_wo_mit_absatz, absatz_af_sk1_bis6, anz_wo_mit_abs_af_sk1_bis6, anz_wo_mit_abs_tot_sk1_bis6
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        COUNT(DISTINCT A.wup_id) AS anz_maerkte,
        SUM(A.absatz) AS absatz_gesamt,
        SUM(A.anzahl_wochen_mit_absatz) AS anz_wo_mit_absatz,
        SUM(A.absatz_af) AS absatz_af_sk1_bis6,
        SUM(A.anzahl_wochen_mit_absatz_af) AS anz_wo_mit_abs_af_sk1_bis6,
        SUM(A.anzahl_wochen_mit_absatz) AS anz_wo_mit_abs_tot_sk1_bis6
    FROM dbp_etl.st_listung_kw_kmo_2 AS A
    INNER JOIN dbp_etl.sal_wochen_2 AS B ON A.mandant_id = B.mandant_id AND A.kjwo = B.kjwo
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.kjwo
);


INSERT INTO dbp_etl.anz_wo_listung_pre_2 (art_id, mandant_id, kjwo, wup_id, anz_wo_listung_2)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.kjwo,
        A.wup_id,
        SUM(A.listung_id) AS anz_wo_listung_2
    FROM dbp_data.art_wup_listung_kjwo_2 AS A
    INNER JOIN dbp_etl.sal_wochen_2 AS B ON A.mandant_id = B.mandant_id AND A.kjwo = B.kjwo
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.kjwo
);


CREATE OR REPLACE TABLE dbp_etl.mm_2 AS
SELECT
    A.art_id,
    A.mandant_id,
    A.kjwo,
    A.wup_id,
    A.anz_wo_listung_2,
    B.anz_maerkte,
    B.absatz_gesamt,
    B.anz_wo_mit_absatz,
    B.absatz_af_sk1_bis6,
    B.anz_wo_mit_abs_af_sk1_bis6,
    B.anz_wo_mit_abs_tot_sk1_bis6
FROM dbp_etl.anz_wo_listung_pre_2 AS A
INNER JOIN dbp_etl.anz_wo_absatz_pre_2
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id
= B.wup_id AND A.kjwo = B.kjwo;


INSERT INTO dbp_etl.mm_2
(SELECT
    art_id,
    mandant_id,
    kjwo,
    wup_id,
    anz_wo_listung_2,
    0,
    0,
    0,
    0,
    0,
    0
FROM dbp_etl.anz_wo_listung_pre_2
WHERE (
    art_id, mandant_id, kjwo, wup_id) NOT IN (
    SELECT (art_id, mandant_id, kjwo, wup_id)
    FROM dbp_etl.mm_2
));


CREATE OR REPLACE TABLE dbp_etl.anz_wo_absatz_2 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_maerkte INTEGER,
    absatz_gesamt FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_tot_sk1_bis6 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_absatz_2 (
    art_id, mandant_id, kjwo, anz_maerkte, absatz_gesamt,
    anz_wo_mit_absatz, absatz_af_sk1_bis6, anz_wo_mit_abs_af_sk1_bis6, anz_wo_mit_abs_tot_sk1_bis6
)
(
    SELECT
        art_id,
        mandant_id,
        kjwo,
        COUNT(DISTINCT wup_id) AS anz_maerkte,
        SUM(absatz_gesamt) AS absatz_gesamt,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
        SUM(absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
        SUM(anz_wo_mit_abs_af_sk1_bis6) AS anz_wo_mit_abs_af_sk1_bis6,
        SUM(anz_wo_mit_abs_tot_sk1_bis6) AS anz_wo_mit_abs_tot_sk1_bis6
    FROM dbp_etl.mm_2 AS A11
    WHERE anz_wo_mit_absatz <> 0
    GROUP BY
        art_id,
        mandant_id,
        kjwo
);


CREATE OR REPLACE TABLE dbp_etl.anz_wo_listung_2 (
    art_id INTEGER,
    mandant_id INTEGER,
    kjwo INTEGER,
    anz_wo_listung_2 FLOAT64
);


INSERT INTO dbp_etl.anz_wo_listung_2
(
    SELECT
        art_id,
        mandant_id,
        kjwo,
        SUM(anz_wo_listung_2) AS anz_wo_listung_2
    FROM dbp_etl.mm_2 AS A11
    GROUP BY
        art_id,
        mandant_id,
        kjwo
);


CREATE OR REPLACE TEMPORARY TABLE _lkp_lieferant AS
SELECT
    V01.mandant_id,
    V01.art_id,
    V01.gp_id,
    V02.gp_name,
    COUNT(*) AS anz_lief
FROM dbp_data.art_gp_nm_zu_per_2 AS V01
INNER JOIN dbp_data.gp_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id = V02.gp_id
WHERE
    V01.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND V01.gp_id <> -1
    AND V01.mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    V01.mandant_id,
    V01.art_id,
    V01.gp_id,
    V02.gp_name
QUALIFY (ROW_NUMBER() OVER (PARTITION BY V01.mandant_id, V01.art_id ORDER BY anz_lief IS NULL DESC, anz_lief DESC)) = 1;


CREATE OR REPLACE TEMPORARY TABLE _lkp_wg AS
SELECT DISTINCT
    A1.mandant_id,
    A1.art_id,
    A1.wg_id,
    A1.wug_id,
    W1.owg_id
FROM dbp_data.art_wg_zu_per_2 AS A1
INNER JOIN dbp_data.wg_per_2 AS W1
    ON
        A1.wg_id = W1.wg_id AND A1.mandant_id = W1.mandant_id AND W1.arthiertyp_id
        = 2 AND W1.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
    A1.dat_bis = PARSE_DATE('%F', '9999-12-31')
    AND A1.mandant_id IN (2, 3, 5, 6, 7, 8);


CREATE OR REPLACE TEMPORARY TABLE _lkp_kol AS
SELECT
    v02.mandant_id,
    v02.art_id,
    COALESCE(v03.umrech_faktor, 1) AS kolli_faktor,
    v02.bezugsweg_id
FROM (
    SELECT
        art_id,
        mandant_id,
        best_menge_einh_id AS menge_einh_id,
        1 AS bezugsweg_id
    FROM dbp_data.art_2
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id IN (2, 3, 5, 6, 7, 8)
) AS v02
LEFT JOIN (SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per_2
WHERE dat_bis = DATE '9999-12-31') AS v03
    ON
        v02.art_id = v03.art_id AND v02.mandant_id = v03.mandant_id AND v02.menge_einh_id
        = v03.altnv_menge_einh_id AND v02.mandant_id IN (2, 3, 5, 6, 7, 8)
UNION DISTINCT
SELECT
    v02.mandant_id,
    v02.art_id,
    COALESCE(v03.umrech_faktor, 1) AS kolli_faktor,
    v02.bezugsweg_id
FROM (
    SELECT
        art_id,
        mandant_id,
        ausg_menge_einh_id AS menge_einh_id,
        4 AS bezugsweg_id
    FROM dbp_data.art_vorschlagswert_per_2
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id IN (2, 3, 5, 6, 7, 8)
) AS v02
LEFT JOIN (SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per_2
WHERE dat_bis = DATE '9999-12-31') AS v03 ON v02.art_id = v03.art_id AND v02.mandant_id = v03.mandant_id AND v02.menge_einh_id
= v03.altnv_menge_einh_id AND v02.mandant_id IN (2, 3, 5, 6, 7, 8);


CREATE OR REPLACE TEMPORARY TABLE _lkp_durchg_listung AS
SELECT
    art_id,
    mandant_id,
    MIN(sm_id) AS min_durchg_gelistet_sst
FROM (
    SELECT
        V01.mandant_id,
        V01.art_id,
        V01.sm_id,
        V01.list_durchg_fg
    FROM dbp_data.sternchen_logik_2 AS V01
    INNER JOIN
        dbp_data.l_sternchen_2
            AS V02
        ON
            V01.mandant_id = V02.mandant_id AND V01.list_durchg_fg = V02.list_durchg_fg AND V01.bezugsweg1_fg = V02.bezugsweg1_fg AND V01.bezugsweg4_fg = V02.bezugsweg4_fg AND V01.kdis0_fg
            = V02.kdis0_fg AND V01.kdis1_fg = V02.kdis1_fg
) AS a
WHERE
    list_durchg_fg = 1
    AND mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_vk_pk AS
SELECT
    art_id,
    mandant_id,
    MAX(CASE
        WHEN pm_id = 1
            THEN vk_brutto
        ELSE NULL
    END) AS vkpk1,
    MAX(CASE
        WHEN pm_id = 4
            THEN vk_brutto
        ELSE NULL
    END) AS vkpk4
FROM dbp_data.art_pm_vw_zu_per_2
WHERE
    CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    AND preistyp_id = 0
    AND mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_stk_ek_kb_stamm AS
SELECT
    mandant_id,
    art_id,
    MAX(CAST(einstandspreis AS NUMERIC)) AS einstandspreis
FROM dbp_msi_view_ais_kmo.tbl_mv_einkaufspreisstamm_akt_2
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_spanne AS
SELECT
    A.mandant_id,
    A.art_id,
    MAX(CASE
        WHEN b.einstandspreis IS NULL
            THEN NULL
        ELSE 1.0 - IFNULL(b.einstandspreis / IF(c.vkpk1 / IF(
            d.mwst = 0, NULL, d.mwst) = 0, NULL, c.vkpk1 / IF(
            d.mwst = 0,
            NULL, d.mwst
        )), 0)
    END) AS sp_ekkb_01,
    MAX(CASE
        WHEN b.einstandspreis IS NULL
            THEN NULL
        ELSE 1.0 - IFNULL(b.einstandspreis / IF(c.vkpk4 / IF(
            d.mwst = 0, NULL, d.mwst) = 0, NULL, c.vkpk4 / IF(
            d.mwst = 0,
            NULL, d.mwst
        )), 0)
    END) AS sp_ekkb_04
FROM dbp_data.art_2 AS A
LEFT JOIN (
    SELECT
        A0.mandant_id,
        A0.art_id,
        MAX(CAST(A0.einstandspreis AS NUMERIC)) AS einstandspreis
    FROM dbp_data.art_gp_wup_zu_per_2 AS A0
    INNER JOIN (SELECT
        mandant_id,
        art_id,
        gp_id,
        COUNT(*) AS anz_wup
    FROM dbp_data.art_gp_nm_zu_per_2
    WHERE dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        mandant_id,
        art_id,
        gp_id
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, art_id ORDER BY anz_wup IS NULL DESC, anz_wup DESC)) = 1) AS b
        ON A0.art_id = b.art_id AND A0.mandant_id = b.mandant_id AND A0.gp_id = b.gp_id
    WHERE
        A0.wup_id = -1
        AND A0.dat_bis = PARSE_DATE('%F', '9999-12-31')
    GROUP BY
        A0.mandant_id,
        A0.art_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id
LEFT JOIN (
    SELECT
        art_id,
        mandant_id,
        MAX(CASE
            WHEN pm_id = 1
                THEN vk_brutto
            ELSE NULL
        END) AS vkpk1,
        MAX(CASE
            WHEN pm_id = 4
                THEN vk_brutto
            ELSE NULL
        END) AS vkpk4
    FROM dbp_data.art_pm_vw_zu_per_2
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND preistyp_id = 0
    GROUP BY
        art_id,
        mandant_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
LEFT JOIN (
    SELECT
        B.art_id,
        B.mandant_id,
        IFNULL(MAX(a.mwst) / 100.0, 0) + 1.0 AS mwst
    FROM (SELECT
        mandant_id,
        mwst_id,
        mwst
    FROM dbp_data.mwst_per_2
    WHERE CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis) AS a
    INNER JOIN dbp_data.art_2 AS B ON a.mandant_id = B.mandant_id AND a.mwst_id = B.mwst_id
    GROUP BY
        B.art_id,
        B.mandant_id
) AS d ON A.mandant_id = d.mandant_id AND A.art_id = d.art_id
WHERE A.mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_absatz_listung_woche AS
SELECT
    a.art_id,
    a.mandant_id,
    B.absatz_gesamt,
    C.anz_wo_listung_2,
    B.anz_wo_mit_absatz,
    B.anz_maerkte,
    B.absatz_af_sk1_bis6,
    B.anz_wo_mit_abs_af_sk1_bis6,
    B.anz_wo_mit_abs_tot_sk1_bis6
FROM (
    SELECT *
    FROM (
        SELECT
            art_id,
            mandant_id,
            kjwo
        FROM dbp_etl.anz_wo_absatz_2
        GROUP BY
            art_id,
            mandant_id,
            kjwo
        UNION DISTINCT
        SELECT
            anz_wo_listung.art_id,
            anz_wo_listung.mandant_id,
            anz_wo_listung.kjwo
        FROM dbp_etl.anz_wo_listung_2 AS anz_wo_listung_2
        GROUP BY
            anz_wo_listung.art_id,
            anz_wo_listung.mandant_id,
            anz_wo_listung.kjwo
    ) AS t1_2
) AS a
LEFT JOIN dbp_etl.anz_wo_absatz_2 AS B
    ON
        a.art_id = B.art_id AND a.mandant_id = B.mandant_id AND a.kjwo =
        B.kjwo
LEFT JOIN dbp_etl.anz_wo_listung_2 AS C
    ON
        a.art_id = C.art_id AND a.mandant_id = C.mandant_id AND a.kjwo
        = C.kjwo
WHERE a.mandant_id IN (2, 3, 5, 6, 7, 8);


CREATE OR REPLACE TEMPORARY TABLE _lkp_abschriften AS
SELECT
    A.mandant_id,
    A.art_id,
    SUM(A.abschriftbetrag_netto) AS abschriftbetrag_netto
FROM dbp_data.marktabschriften_2 AS A
INNER JOIN dbp_data.tag_2 AS B ON A.dat = B.dat
INNER JOIN dbp_etl.sal_wochen_2 AS D ON A.mandant_id = D.mandant_id AND B.kjwo = D.kjwo
INNER JOIN (
    SELECT
        mandant_id,
        art_id
    FROM dbp_etl.st_listung_sm_kw_kmo_2
    GROUP BY
        mandant_id,
        art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
WHERE
    A.abschriftart_id BETWEEN 905 AND 994
    AND A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND (A.abschriftart_id <> 955 OR A.mandant_id <> 2)
GROUP BY
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_absatz_sa_tag AS
SELECT
    art_id,
    mandant_id,
    SUM(absatz_sa) AS absatz_sa_sk1_bis6,
    SUM(anzahl_tage_mit_absatz_sa) AS anz_tage_mit_abs_sa_sk1_bis6
FROM dbp_etl.st_listung_markt_tag_kmo_2 AS A11
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_absatz_vj AS
SELECT
    A11.art_id,
    A11.mandant_id,
    SUM(A11.absatz) AS absatz_vj_sk1_bis_6
FROM dbp_etl.st_listung_kw_kmo_2 AS A11
INNER JOIN dbp_data.woche_2 AS A12 ON A11.kjwo = A12.kjwo_vj
WHERE A11.mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    A11.art_id,
    A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_kassenumsatz1 AS
SELECT
    art_id,
    mandant_id,
    SUM(umsatz_netto) AS kassenumsatz_sk_1_bis_6,
    SUM(ek_mep) AS ek_mep_ums_sk1_bis_6,
    SUM(einstandspreis) AS einstandspreis_ums_sk1_bis_6,
    SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END) AS kassenumsatz_af_sk_1_bis_6,
    SUM(CASE
        WHEN bewart_id = 1002
            THEN ek_mep
        ELSE NULL
    END) AS ek_mep_ums_sa_sk1_bis_6,
    SUM(CASE
        WHEN bewart_id = 1002
            THEN einstandspreis
        ELSE NULL
    END) AS einstandspreis_ums_sa_sk1_bis_6,
    SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END) AS kassenumsatz_sa_sk_1_bis_6
FROM dbp_etl.st_listung_sm_kw_kmo_2 AS A
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_absatz AS
SELECT
    art_id,
    mandant_id,
    SUM(CASE
        WHEN sm_id = 1
            THEN absatz
        ELSE NULL
    END) AS absatz_sk1,
    SUM(CASE
        WHEN sm_id = 1
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk1,
    SUM(CASE
        WHEN sm_id = 2
            THEN absatz
        ELSE NULL
    END) AS absatz_sk2,
    SUM(CASE
        WHEN sm_id = 2
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk2,
    SUM(CASE
        WHEN sm_id = 3
            THEN absatz
        ELSE NULL
    END) AS absatz_sk3,
    SUM(CASE
        WHEN sm_id = 3
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk3,
    SUM(CASE
        WHEN sm_id = 4
            THEN absatz
        ELSE NULL
    END) AS absatz_sk4,
    SUM(CASE
        WHEN sm_id = 4
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk4,
    SUM(CASE
        WHEN sm_id = 5
            THEN absatz
        ELSE NULL
    END) AS absatz_sk5,
    SUM(CASE
        WHEN sm_id = 5
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk5,
    SUM(absatz_af) AS absatz_af_sk1_bis6,
    SUM(absatz_sa) AS absatz_sa_sk1_bis6,
    SUM(absatz) AS absatz_gesamt
FROM dbp_etl.st_listung_sm_kw_kmo_2 AS A11
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_umsatz_vj AS
SELECT
    A11.art_id,
    A11.mandant_id,
    SUM(A11.ek_mep) AS ek_mep_ums_sk1_bis_6_vj,
    SUM(A11.einstandspreis) AS einstandspreis_ums_sk1_bis_6_vj,
    SUM(A11.umsatz_netto) AS kassenumsatz_sk_1_bis_6_vj
FROM dbp_etl.st_listung_sm_kw_kmo_2 AS A11
INNER JOIN dbp_data.woche_2 AS A12 ON A11.kjwo = A12.kjwo_vj
WHERE A11.mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    A11.art_id,
    A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _lkp_ek_mep AS
SELECT
    art_id,
    mandant_id,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN ek_mep
        ELSE NULL
    END), 0) AS mep_af,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN ek_mep
        ELSE NULL
    END), 0) AS mep_sa,
    IFNULL(SUM(umsatz_netto), 0) - IFNULL(SUM(ek_mep), 0) AS mep_tot,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN einstandspreis
        ELSE NULL
    END), 0) AS einstandspreis_af,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN einstandspreis
        ELSE NULL
    END), 0) AS einstandspreis_sa,
    IFNULL(SUM(umsatz_netto), 0) - IFNULL(SUM(einstandspreis), 0) AS einstandspreis_tot,
    IFNULL(SUM(umsatz_netto), 0) AS umsatz_brutto_tot,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END), 0) AS umsatz_brutto_af,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END), 0) AS umsatz_brutto_sa
FROM dbp_etl.st_ab_wg_art_wo_sum_kmo_2 AS A11
WHERE mandant_id IN (2, 3, 5, 6, 7, 8)
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TABLE dbp_etl.sal_aggregat_kmo_2 (
    wg_id INTEGER,
    temp_wg_id INTEGER,
    temp_owg_id INTEGER,
    temp_wug_id INTEGER,
    mandant_id INTEGER,
    wg_bez STRING(100),
    wug_id INTEGER,
    wug_bez STRING(40),
    art_nr STRING(10),
    art_id INTEGER,
    art_bez STRING(50),
    loesch_id STRING(2),
    zek_2 STRING(3),
    zek_lang_bez STRING(36),
    eigenmarke_id STRING(2),
    bio_fg STRING(1),
    tierwohl_kz STRING(9),
    vegan_fg STRING(1),
    posten_food STRING(1),
    posten_nonfood STRING(1),
    gluten_fg STRING(1),
    mwst NUMERIC(29, 2),
    aldi_id INTEGER,
    discount_id INTEGER,
    discount_bez STRING(40),
    kol_bst FLOAT64,
    kol_la FLOAT64,
    mhd_zeitraum_dz INTEGER,
    mhd_zeitraum INTEGER,
    vkpk1 NUMERIC(29, 4),
    akt_gp_id INTEGER,
    akt_gp_name STRING(40),
    lactose_fg STRING(1),
    vkpk4 NUMERIC(29, 4),
    kreistyp_gruppe_id STRING(2),
    typ_ost_basis STRING(2),
    typ_ost_gross STRING(2),
    typ_sued_ost STRING(2),
    typ_sued_west STRING(2),
    typ_west STRING(2),
    typ_nord STRING(2),
    sp_ekkb_01 NUMERIC(29, 4),
    stk_ek_kb_stamm NUMERIC(29, 4),
    wjxbfs1 FLOAT64,
    absatz_gesamt FLOAT64,
    max_kjwo INTEGER,
    min_kjwo INTEGER,
    min_durchg_gelistet_sst INTEGER,
    sp_ekkb_04 NUMERIC(29, 4),
    kassenumsatz_sk_1_bis_6 FLOAT64,
    absatz_sk1 FLOAT64,
    absatz_sk2 FLOAT64,
    absatz_sk3 FLOAT64,
    absatz_sk4 FLOAT64,
    absatz_sk5 FLOAT64,
    absatz_af_sk1_bis6 FLOAT64,
    anz_wo_mit_abs_af_sk1_bis6 FLOAT64,
    abschr_vk_o_werbung FLOAT64,
    absatz_nord FLOAT64,
    absatz_ost_basis FLOAT64,
    absatz_ost_gross FLOAT64,
    absatz_sued_ost FLOAT64,
    absatz_sued_west FLOAT64,
    absatz_west FLOAT64,
    absatz_sa_sk1_bis6 FLOAT64,
    anz_tage_mit_abs_sa_sk1_bis6 FLOAT64,
    kassenumsatz_af_sk_1_bis_6 FLOAT64,
    anz_wo_mit_abs_ost_basis FLOAT64,
    anz_wo_mit_abs_sued_west FLOAT64,
    ek_mep_ums_sa_sk1_bis_6 FLOAT64,
    einstandspreis_ums_sa_sk1_bis_6 FLOAT64,
    anz_wo_listung_2 FLOAT64,
    ek_mep_ums_sk1_bis_6_vj FLOAT64,
    einstandspreis_ums_sk1_bis_6_vj FLOAT64,
    anz_wo_mit_abs_west FLOAT64,
    absatz_vj_sk1_bis_6 FLOAT64,
    anz_wo_mit_abs_sk2 FLOAT64,
    kassenumsatz_sk_1_bis_6_vj FLOAT64,
    anz_wo_mit_abs_nord FLOAT64,
    mep_tot FLOAT64,
    mep_af FLOAT64,
    mep_sa FLOAT64,
    einstandspreis_tot FLOAT64,
    einstandspreis_af FLOAT64,
    einstandspreis_sa FLOAT64,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_abs_sk4 FLOAT64,
    anz_wo_mit_abs_sk1 FLOAT64,
    ek_mep_ums_sk1_bis_6 FLOAT64,
    einstandspreis_ums_sk1_bis_6 FLOAT64,
    kassenumsatz_sa_sk_1_bis_6 FLOAT64,
    anz_wo_mit_abs_sk3 FLOAT64,
    anz_wo_mit_abs_sued_ost FLOAT64,
    anz_wo_mit_abs_sk5 FLOAT64,
    anz_wo_mit_abs_ost_gross FLOAT64,
    umsatz_brutto_tot FLOAT64,
    umsatz_brutto_af FLOAT64,
    umsatz_brutto_sa FLOAT64,
    anz_wo_mit_abs_tot_sk1_bis6 FLOAT64,
    anz_maerkte INTEGER
);


CREATE OR REPLACE TABLE dbp_etl.prep_sal_aggregat_kmo_2 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.kl_art_id,
    A.zek_id,
    A.eigenmarke_id,
    A.bio_fg,
    A.loesch_id,
    A.vegan_fg,
    A.posten_id,
    A.gluten_fg,
    A.mhd_zeitraum,
    A.tierwohl_kz,
    A.aldi_id,
    COALESCE(c.wug_bez, 'k.A.') AS wug_bez,
    COALESCE(d.wg_bez, 'k.A.') AS wg_bez,
    COALESCE(e.zek_name, 'k.A.') AS zek_name,
    COALESCE(f.art_bez, 'k.A.') AS art_bez,
    A.discount_id AS disc_marke,
    COALESCE(h.mhd_zeitraum_dz, 0) AS mhd_zeitraum_dz,
    A.lactose_fg,
    COALESCE(g.mwst, 0.00) AS mwst,
    COALESCE(CASE
        WHEN SUM(V022.anzahl_markt_listung) = 0
            THEN ' '
        WHEN SUM(V022.anzahl_markt_listung) > 0
            THEN 'X'
        ELSE NULL
    END, 'k.A') AS aktiv_kz
FROM dbp_data.art_2 AS A
INNER JOIN dbp_data.art_wg_zu_per_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
LEFT JOIN (
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.wug_id,
        V01.wug_bez
    FROM dbp_data.wug_spr_zu_2 AS V01
    INNER JOIN dbp_data.mandant_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.spr_id = V02.spr_id

    WHERE
        V01.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND V01.arthiertyp_id = 2
) AS c ON A.mandant_id = c.mandant_id AND B.wg_id = c.wg_id AND B.wug_id = c.wug_id
LEFT JOIN (
    SELECT
        V010.mandant_id,
        V010.wg_id,
        V010.wg_bez
    FROM dbp_data.wg_spr_zu_2 AS V010
    INNER JOIN dbp_data.mandant_spr_zu_2 AS V020
        ON
            V010.mandant_id = V020.mandant_id AND V010.spr_id = V020.spr_id
    WHERE
        V010.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND V010.arthiertyp_id = 2
) AS d ON A.mandant_id = d.mandant_id AND B.wg_id = d.wg_id
LEFT JOIN (
    SELECT
        mandant_id,
        zek_id,
        zek_name
    FROM dbp_data.zek_2 AS V01
    WHERE
        mandant_id IN (2, 3, 5, 6, 7, 8)
        AND zek_id <> '-1'
        AND wbl_id > 0
) AS e ON A.mandant_id = e.mandant_id AND A.zek_id = e.zek_id
LEFT JOIN (
    SELECT
        V012.mandant_id,
        V012.art_id,
        V012.art_bez
    FROM dbp_data.art_spr_zu_2 AS V012
    INNER JOIN dbp_data.mandant_spr_zu_2 AS V021
        ON
            V012.mandant_id = V021.mandant_id AND V012.spr_id = V021.spr_id
    WHERE V012.mandant_id IN (2, 3, 5, 6, 7, 8)
) AS f ON A.mandant_id = f.mandant_id AND A.art_id = f.art_id
LEFT JOIN (
    SELECT
        mandant_id,
        mwst_id,
        mwst
    FROM dbp_data.mwst_per_2
    WHERE
        mandant_id IN (2, 3, 5, 6, 7, 8)
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
) AS g ON A.mwst_id = g.mwst_id AND A.mandant_id = g.mandant_id
LEFT JOIN (
    SELECT
        mandant_id,
        art_id,
        mhd_zeitraum_dz
    FROM dbp_data.art_gp_zu_per_2
    WHERE
        mandant_id IN (2, 3, 5, 6, 7, 8)
        AND dat_bis = PARSE_DATE('%F', '9999-12-31')
) AS h ON A.mandant_id = h.mandant_id AND A.art_id = h.art_id
LEFT JOIN dbp_data.sternchen_logik_2 AS V022 ON A.mandant_id = V022.mandant_id AND A.art_id = V022.art_id
WHERE
    A.mandant_id IN (2, 3, 5, 6, 7, 8)
    AND A.art_id > 0
GROUP BY
    A.mandant_id,
    A.art_id,
    A.kl_art_id,
    A.zek_id,
    A.eigenmarke_id,
    A.bio_fg,
    A.loesch_id,
    A.vegan_fg,
    A.posten_id,
    A.gluten_fg,
    A.mhd_zeitraum,
    A.tierwohl_kz,
    A.aldi_id,
    wug_bez,
    wg_bez,
    zek_name,
    art_bez,
    disc_marke,
    mhd_zeitraum_dz,
    A.lactose_fg,
    mwst;


INSERT INTO dbp_etl.sal_aggregat_kmo_2
(SELECT
    -1 AS wg_id,
    -1 AS temp_wg_id,
    -1 AS temp_owg_id,
    -1 AS temp_wug_id,
    mandant_id,
    wg_bez,
    -1 AS wug_id,
    wug_bez,
    SUBSTR(CAST(kl_art_id AS STRING), 1, 10) AS art_nr,
    art_id,
    art_bez,
    loesch_id,
    zek_id AS zek_2,
    zek_name AS zek_lang_bez,
    eigenmarke_id,
    SUBSTR(CAST(bio_fg AS STRING), 1, 1) AS bio_fg,
    tierwohl_kz,
    SUBSTR(CAST(vegan_fg AS STRING), 1, 1) AS vegan_fg,
    CASE
        WHEN posten_id = 'PF'
            THEN 'X'
        ELSE ' '
    END AS posten_food,
    CASE
        WHEN posten_id = 'PN'
            THEN 'X'
        ELSE ' '
    END AS posten_nonfood,
    SUBSTR(CAST(gluten_fg AS STRING), 1, 1) AS gluten_fg,
    mwst,
    aldi_id,
    disc_marke AS discount_id,
    ' ' AS discount_bez,
    -1 AS kol_bst,
    -1 AS kol_la,
    mhd_zeitraum_dz,
    mhd_zeitraum,
    -1 AS vkpk1,
    -1 AS akt_gp_id,
    '' AS akt_gp_name,
    SUBSTR(CAST(lactose_fg AS STRING), 1, 1) AS lactose_fg,
    -1 AS vkpk4,
    ' ' AS kreistyp_gruppe_id,
    ' ' AS typ_ost_basis,
    ' ' AS typ_ost_gross,
    ' ' AS typ_sued_ost,
    ' ' AS typ_sued_west,
    ' ' AS typ_west,
    ' ' AS typ_nord,
    0 AS sp_ekkb_01,
    -1 AS stk_ek_kb_stamm,
    1 AS wjxbfs1,
    0 AS absatz_gesamt,
    0 AS max_kjwo,
    0 AS min_kjwo,
    0 AS min_durchg_gelistet_sst,
    0 AS sp_ekkb_04,
    0 AS kassenumsatz_sk_1_bis_6,
    0 AS absatz_sk1,
    0 AS absatz_sk2,
    0 AS absatz_sk3,
    0 AS absatz_sk4,
    0 AS absatz_sk5,
    0 AS absatz_af_sk1_bis6,
    0 AS anz_wo_mit_abs_af_sk1_bis6,
    0 AS abschr_vk_o_werbung,
    0 AS absatz_nord,
    0 AS absatz_ost_basis,
    0 AS absatz_ost_gross,
    0 AS absatz_sued_ost,
    0 AS absatz_sued_west,
    0 AS absatz_west,
    0 AS absatz_sa_sk1_bis6,
    0 AS anz_tage_mit_abs_sa_sk1_bis6,
    0 AS kassenumsatz_af_sk_1_bis_6,
    0 AS anz_wo_mit_abs_ost_basis,
    0 AS anz_wo_mit_abs_sued_west,
    0 AS ek_mep_ums_sa_sk1_bis_6,
    0 AS einstandspreis_ums_sa_sk1_bis_6,
    0 AS anz_wo_listung_2,
    0 AS ek_mep_ums_sk1_bis_6_vj,
    0 AS einstandspreis_ums_sk1_bis_6_vj,
    0 AS anz_wo_mit_abs_west,
    0 AS absatz_vj_sk1_bis_6,
    0 AS anz_wo_mit_abs_sk2,
    0 AS kassenumsatz_sk_1_bis_6_vj,
    0 AS anz_wo_mit_abs_nord,
    0 AS mep_tot,
    0 AS mep_af,
    0 AS mep_sa,
    0 AS einstandspreis_tot,
    0 AS einstandspreis_af,
    0 AS einstandspreis_sa,
    0 AS anz_wo_mit_absatz,
    0 AS anz_wo_mit_abs_sk4,
    0 AS anz_wo_mit_abs_sk1,
    0 AS ek_mep_ums_sk1_bis_6,
    0 AS einstandspreis_ums_sk1_bis_6,
    0 AS kassenumsatz_sa_sk_1_bis_6,
    0 AS anz_wo_mit_abs_sk3,
    0 AS anz_wo_mit_abs_sued_ost,
    0 AS anz_wo_mit_abs_sk5,
    0 AS anz_wo_mit_abs_ost_gross,
    0 AS umsatz_brutto_tot,
    0 AS umsatz_brutto_af,
    0 AS umsatz_brutto_sa,
    0 AS anz_wo_mit_abs_tot_sk1_bis6,
    0 AS anz_maerkte
FROM dbp_etl.prep_sal_aggregat_kmo_2);


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    akt_gp_id = b.gp_id,
    akt_gp_name = b.gp_name FROM (SELECT
    mandant_id,
    art_id,
    gp_id,
    gp_name
FROM `_lkp_lieferant`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    wg_id = b.wg_id,
    wug_id = b.wug_id,
    temp_wg_id = b.wg_id,
    temp_wug_id = b.wug_id,
    temp_owg_id = b.owg_id
FROM `_lkp_wg` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    kol_bst = b.kolli_faktor
FROM `_lkp_kol` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id AND b.bezugsweg_id = 1;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    kol_la = b.kolli_faktor
FROM `_lkp_kol` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id AND b.bezugsweg_id = 4;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    vkpk1 = CAST(b.vkpk1 AS NUMERIC),
    vkpk4 = CAST(b.vkpk4 AS NUMERIC) FROM (SELECT
    mandant_id,
    art_id,
    vkpk1,
    vkpk4
FROM `_lkp_vk_pk`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    stk_ek_kb_stamm = b.einstandspreis
FROM `_lkp_stk_ek_kb_stamm` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    anz_wo_listung_2 = t0.anz_wo_listung_2,
    anz_wo_mit_absatz = t0.anz_wo_mit_absatz,
    anz_maerkte = t0.anz_maerkte,
    anz_wo_mit_abs_af_sk1_bis6 = t0.anz_wo_mit_abs_af_sk1_bis6,
    anz_wo_mit_abs_tot_sk1_bis6 = t0.anz_wo_mit_abs_tot_sk1_bis6 FROM (
    SELECT
        mandant_id,
        art_id,
        SUM(anz_maerkte) AS anz_maerkte,
        SUM(anz_wo_listung_2) AS anz_wo_listung_2,
        SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
        SUM(anz_wo_mit_abs_af_sk1_bis6) AS anz_wo_mit_abs_af_sk1_bis6,
        SUM(anz_wo_mit_abs_tot_sk1_bis6) AS anz_wo_mit_abs_tot_sk1_bis6
    FROM `_lkp_absatz_listung_woche`
    GROUP BY
        art_id,
        mandant_id
) AS t0
WHERE sal_aggregat_kmo.mandant_id = t0.mandant_id AND sal_aggregat_kmo.art_id = t0.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    kassenumsatz_sk_1_bis_6 = b.kassenumsatz_sk_1_bis_6,
    ek_mep_ums_sk1_bis_6 = b.ek_mep_ums_sk1_bis_6,
    einstandspreis_ums_sk1_bis_6 = b.einstandspreis_ums_sk1_bis_6,
    kassenumsatz_af_sk_1_bis_6 = b.kassenumsatz_af_sk_1_bis_6,
    ek_mep_ums_sa_sk1_bis_6 = b.ek_mep_ums_sa_sk1_bis_6,
    einstandspreis_ums_sa_sk1_bis_6 = b.einstandspreis_ums_sa_sk1_bis_6,
    kassenumsatz_sa_sk_1_bis_6 = b.kassenumsatz_sa_sk_1_bis_6 FROM (SELECT
    mandant_id,
    art_id,
    kassenumsatz_sk_1_bis_6,
    ek_mep_ums_sk1_bis_6,
    einstandspreis_ums_sk1_bis_6,
    kassenumsatz_af_sk_1_bis_6,
    ek_mep_ums_sa_sk1_bis_6,
    einstandspreis_ums_sa_sk1_bis_6,
    kassenumsatz_sa_sk_1_bis_6
FROM `_lkp_kassenumsatz1`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    absatz_gesamt = b.absatz_gesamt,
    absatz_af_sk1_bis6 = b.absatz_af_sk1_bis6,
    absatz_sk1 = b.absatz_sk1,
    absatz_sk2 = b.absatz_sk2,
    absatz_sk3 = b.absatz_sk3,
    absatz_sk4 = b.absatz_sk4,
    absatz_sk5 = b.absatz_sk5,
    anz_wo_mit_abs_sk1 = b.anz_wo_mit_abs_sk1,
    anz_wo_mit_abs_sk2 = b.anz_wo_mit_abs_sk2,
    anz_wo_mit_abs_sk3 = b.anz_wo_mit_abs_sk3,
    anz_wo_mit_abs_sk4 = b.anz_wo_mit_abs_sk4,
    anz_wo_mit_abs_sk5 = b.anz_wo_mit_abs_sk5,
    absatz_sa_sk1_bis6 = b.absatz_sa_sk1_bis6
FROM `_lkp_absatz` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    anz_tage_mit_abs_sa_sk1_bis6 = b.anz_tage_mit_abs_sa_sk1_bis6 FROM (SELECT
    mandant_id,
    art_id,
    anz_tage_mit_abs_sa_sk1_bis6
FROM `_lkp_absatz_sa_tag`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    ek_mep_ums_sk1_bis_6_vj = b.ek_mep_ums_sk1_bis_6_vj,
    einstandspreis_ums_sk1_bis_6_vj = b.einstandspreis_ums_sk1_bis_6_vj,
    kassenumsatz_sk_1_bis_6_vj = b.kassenumsatz_sk_1_bis_6_vj FROM (SELECT
    mandant_id,
    art_id,
    ek_mep_ums_sk1_bis_6_vj,
    einstandspreis_ums_sk1_bis_6_vj,
    kassenumsatz_sk_1_bis_6_vj
FROM `_lkp_umsatz_vj`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    absatz_vj_sk1_bis_6 = b.absatz_vj_sk1_bis_6 FROM (SELECT
    mandant_id,
    art_id,
    absatz_vj_sk1_bis_6
FROM `_lkp_absatz_vj`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    mep_af = b.mep_af,
    mep_sa = b.mep_sa,
    mep_tot = b.mep_tot,
    einstandspreis_af = b.einstandspreis_af,
    einstandspreis_sa = b.einstandspreis_sa,
    einstandspreis_tot = b.einstandspreis_tot,
    umsatz_brutto_af = b.umsatz_brutto_af,
    umsatz_brutto_sa = b.umsatz_brutto_sa,
    umsatz_brutto_tot = b.umsatz_brutto_tot
FROM `_lkp_ek_mep` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    sp_ekkb_01 = CAST(b.sp_ekkb_01 AS NUMERIC),
    sp_ekkb_04 = CAST(b.sp_ekkb_04 AS NUMERIC)
FROM `_lkp_spanne` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    min_durchg_gelistet_sst = b.min_durchg_gelistet_sst FROM (SELECT
    mandant_id,
    art_id,
    min_durchg_gelistet_sst
FROM `_lkp_durchg_listung`) AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


UPDATE dbp_etl.sal_aggregat_kmo_2 SET
    abschr_vk_o_werbung = b.abschriftbetrag_netto
FROM `_lkp_abschriften` AS b
WHERE sal_aggregat_kmo.mandant_id = b.mandant_id AND sal_aggregat_kmo.art_id = b.art_id;


DELETE FROM dbp_data.sal_kmo_2
WHERE (
    mandant_id, kjmo) IN (
    SELECT (mandant_id, kjmo)
    FROM dbp_etl.sal_monat_2
);


INSERT INTO dbp_data.sal_kmo_2 (
    mandant_id, art_id, kjmo, wrg_id, arthiertyp_id, wg_id, wug_id, art_status,
    gp_id, gp_name, zek_id, eigenmarke_id, bio_fg, vegan_fg, posten_food, posten_nonfood, gluten_fg, mwst, disc_pe,
    disc_marke, lactose_fg, k_listung, umrech_faktor_best, umrech_faktor_ausg, mhd_zeitraum, mhd_zeitraum_dz,
    k1_artbew_menge, k1_anz_kjwo_wug_absatz, k2_artbew_menge, k2_anz_kjwo_wug_absatz, k3_artbew_menge,
    k3_anz_kjwo_wug_absatz, k4_artbew_menge, k4_anz_kjwo_wug_absatz, k5_artbew_menge, k5_anz_kjwo_wug_absatz,
    total_artbew_menge, total_anz_kjwo_wug_absatz, total_artbew_menge_vj, total_artbew_menge_sa,
    total_anz_kjwo_wug_absatz_sa, total_anz_tage_wug_absatz_sa, total_artbew_menge_af, total_anz_kjwo_wug_absatz_af,
    schnelldreherquote, prozentual_absatz_sa, total_rohertrag, total_rohertrag_vj, total_rohertrag_af, total_rohertrag_sa,
    rohertrag_einheit, rohertrag_einheit_af, rohertrag_einheit_sa, abschriftbetrag_netto_owerbung, ek_kb_stamm,
    vk_brutto_pk1, vk_brutto_pk4, vk_netto_pk1, vk_netto_pk4, total_umsatz_netto, total_umsatz_netto_af,
    total_umsatz_netto_sa, total_anz_markt, anz_kjwo_wup_listung, anz_wup_listung, lager_prozent, kol_la_bzw, kol_bst_bzw,
    spanne_ek1, spanne_ek4
)
(SELECT
    t0.mandant_id,
    t0.art_id,
    t0.kjmo,
    t0.wrg_id,
    t0.arthiertyp_id,
    t0.wg_id,
    t0.wug_id,
    t0.art_status,
    t0.gp_id,
    t0.gp_name,
    t0.zek_id,
    t0.eigenmarke_id,
    CAST(t0.bio_fg AS INTEGER) AS bio_fg,
    CAST(t0.vegan_fg AS INTEGER) AS vegan_fg,
    t0.posten_food,
    t0.posten_nonfood,
    CAST(t0.gluten_fg AS INTEGER) AS gluten_fg,
    t0.mwst,
    t0.disc_pe,
    t0.disc_marke,
    CAST(t0.lactose_fg AS INTEGER) AS lactose_fg,
    t0.k_listung,
    ROUND(CAST(t0.umrech_faktor_best AS NUMERIC), 5) AS umrech_faktor_best,
    ROUND(CAST(t0.umrech_faktor_ausg AS NUMERIC), 5) AS umrech_faktor_ausg,
    t0.mhd_zeitraum,
    t0.mhd_zeitraum_dz,
    ROUND(CAST(t0.k1_artbew_menge AS NUMERIC), 3) AS k1_artbew_menge,
    CAST(IF(t0.a0 = 0, NULL, t0.a0) AS INTEGER) AS k1_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.k2_artbew_menge AS NUMERIC), 3) AS k2_artbew_menge,
    CAST(IF(t0.a0_0 = 0, NULL, t0.a0_0) AS INTEGER) AS k2_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.k3_artbew_menge AS NUMERIC), 3) AS k3_artbew_menge,
    CAST(IF(t0.a0_1 = 0, NULL, t0.a0_1) AS INTEGER) AS k3_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.k4_artbew_menge AS NUMERIC), 3) AS k4_artbew_menge,
    CAST(IF(t0.a0_2 = 0, NULL, t0.a0_2) AS INTEGER) AS k4_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.k5_artbew_menge AS NUMERIC), 3) AS k5_artbew_menge,
    CAST(IF(t0.a0_3 = 0, NULL, t0.a0_3) AS INTEGER) AS k5_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.total_artbew_menge AS NUMERIC), 3) AS total_artbew_menge,
    CAST(IF(t0.a0_4 = 0, NULL, t0.a0_4) AS INTEGER) AS total_anz_kjwo_wug_absatz,
    ROUND(CAST(t0.total_artbew_menge_vj AS NUMERIC), 3) AS total_artbew_menge_vj,
    ROUND(CAST(t0.total_artbew_menge_sa AS NUMERIC), 3) AS total_artbew_menge_sa,
    CAST(IF(t0.a0_5 = 0, NULL, t0.a0_5) AS INTEGER) AS total_anz_kjwo_wug_absatz_sa,
    CAST(IF(t0.a0_5 = 0, NULL, t0.a0_5) AS INTEGER) AS total_anz_tage_wug_absatz_sa,
    ROUND(CAST(t0.total_artbew_menge_af AS NUMERIC), 3) AS total_artbew_menge_af,
    CAST(IF(t0.a0_6 = 0, NULL, t0.a0_6) AS INTEGER) AS total_anz_kjwo_wug_absatz_af,
    ROUND(CAST(IFNULL(ROUND(t0.a0_7 / IF(t0.a0_8 = 0, NULL, t0.a0_8) * 100, 1), 0) AS NUMERIC), 5) AS schnelldreherquote,
    ROUND(
        CAST(IFNULL(ROUND(t0.total_artbew_menge_sa / IF(t0.total_artbew_menge = 0, NULL, t0.total_artbew_menge) * 100, 1), 0) AS NUMERIC),
        5
    ) AS prozentual_absatz_sa,
    ROUND(CAST(IFNULL(t0.a0_9, 0) AS NUMERIC), 4) AS total_rohertrag,
    ROUND(CAST(IFNULL(t0.a0_10, 0) AS NUMERIC), 4) AS total_rohertrag_vj,
    ROUND(CAST(IFNULL(t0.a0_11, 0) AS NUMERIC), 4) AS total_rohertrag_af,
    ROUND(CAST(IFNULL(t0.a0_12, 0) AS NUMERIC), 4) AS total_rohertrag_sa,
    ROUND(
        CAST(IFNULL(t0.a0_9 / IF(t0.total_artbew_menge = 0, NULL, t0.total_artbew_menge), 0) AS NUMERIC), 4) AS
    rohertrag_einheit,
    ROUND(
        CAST(IFNULL(t0.a0_11 / IF(t0.total_artbew_menge_af = 0, NULL, t0.total_artbew_menge_af), 0) AS NUMERIC), 4) AS
    rohertrag_einheit_af,
    ROUND(
        CAST(IFNULL(t0.a0_12 / IF(t0.total_artbew_menge_sa = 0, NULL, t0.total_artbew_menge_sa), 0) AS NUMERIC), 4) AS
    rohertrag_einheit_sa,
    ROUND(CAST(IFNULL(ROUND(t0.a0_13, 1), 0) AS NUMERIC), 2) AS abschriftbetrag_netto_owerbung,
    IFNULL(ROUND(t0.a0_14, 2), 0) AS ek_kb_stamm,
    ROUND(t0.a0_15, 2) AS vk_brutto_pk1,
    ROUND(t0.a0_16, 2) AS vk_brutto_pk4,
    CAST(ROUND(t0.a0_17, 2) AS NUMERIC) AS vk_netto_pk1, --PE-Review
    CAST(ROUND(t0.a0_18, 2) AS NUMERIC) AS vk_netto_pk4, --PE-Review
    ROUND(CAST(IFNULL(t0.a0_19, 0) AS NUMERIC), 4) AS total_umsatz_netto,
    ROUND(CAST(IFNULL(t0.a0_20, 0) AS NUMERIC), 4) AS total_umsatz_netto_af,
    ROUND(CAST(IFNULL(t0.a0_21, 0) AS NUMERIC), 4) AS total_umsatz_netto_sa,
    t0.total_anz_markt,
    CAST(IFNULL(t0.a0_8, 0) AS INTEGER) AS anz_kjwo_wup_listung,
    t0.total_anz_markt AS anz_wup_listung,
    CAST(t0.a0_22 AS INTEGER) AS lager_prozent,
    ROUND(CAST(COALESCE(t0.a0_23, 0) AS NUMERIC), 5) AS kol_la_bzw,
    ROUND(CAST(COALESCE(t0.a0_24, 0) AS NUMERIC), 5) AS kol_bst_bzw,
    COALESCE(ROUND(t0.a0_25 * 100, 1), 0) AS spanne_ek1,
    COALESCE(ROUND(t0.a0_26 * 100, 1), 0) AS spanne_ek4
FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        X.kjmo,
        D.default_wrg AS wrg_id,
        2 AS arthiertyp_id,
        A.wg_id,
        A.wug_id,
        A.loesch_id AS art_status,
        A.akt_gp_id AS gp_id,
        A.akt_gp_name AS gp_name,
        A.zek_2 AS zek_id,
        COALESCE(A.eigenmarke_id, '') AS eigenmarke_id,
        COALESCE(CAST(A.bio_fg AS BIGNUMERIC), 0) AS bio_fg,
        COALESCE(CAST(A.vegan_fg AS BIGNUMERIC), 0) AS vegan_fg,
        COALESCE(A.posten_food, '') AS posten_food,
        COALESCE(A.posten_nonfood, '') AS posten_nonfood,
        COALESCE(CAST(A.gluten_fg AS BIGNUMERIC), 0) AS gluten_fg,
        COALESCE(A.mwst, 0) AS mwst,
        A.aldi_id AS disc_pe,
        A.discount_id AS disc_marke,
        COALESCE(CAST(A.lactose_fg AS BIGNUMERIC), 0) AS lactose_fg,
        COALESCE(CAST(A.min_durchg_gelistet_sst AS STRING), 'N/A') AS k_listung,
        IFNULL(A.kol_bst, 0) AS umrech_faktor_best,
        IFNULL(A.kol_la, 0) AS umrech_faktor_ausg,
        A.mhd_zeitraum,
        A.mhd_zeitraum_dz,
        SUM(A.absatz_sk1) AS k1_artbew_menge,
        SUM(A.anz_wo_mit_abs_sk1) AS a0,
        SUM(A.absatz_sk2) AS k2_artbew_menge,
        SUM(A.anz_wo_mit_abs_sk2) AS a0_0,
        SUM(A.absatz_sk3) AS k3_artbew_menge,
        SUM(A.anz_wo_mit_abs_sk3) AS a0_1,
        SUM(A.absatz_sk4) AS k4_artbew_menge,
        SUM(A.anz_wo_mit_abs_sk4) AS a0_2,
        SUM(A.absatz_sk5) AS k5_artbew_menge,
        SUM(A.anz_wo_mit_abs_sk5) AS a0_3,
        SUM(A.absatz_gesamt) AS total_artbew_menge,
        SUM(A.anz_wo_mit_abs_tot_sk1_bis6) AS a0_4,
        SUM(A.absatz_vj_sk1_bis_6) AS total_artbew_menge_vj,
        SUM(A.absatz_sa_sk1_bis6) AS total_artbew_menge_sa,
        SUM(A.anz_tage_mit_abs_sa_sk1_bis6) AS a0_5,
        SUM(A.absatz_af_sk1_bis6) AS total_artbew_menge_af,
        SUM(A.anz_wo_mit_abs_af_sk1_bis6) AS a0_6,
        SUM(A.anz_wo_mit_absatz) AS a0_7,
        SUM(A.anz_wo_listung_2) AS a0_8,
        SUM(A.einstandspreis_tot) AS a0_9,
        SUM(A.einstandspreis_ums_sk1_bis_6_vj) AS a0_10,
        SUM(A.einstandspreis_af) AS a0_11,
        SUM(A.einstandspreis_sa) AS a0_12,
        SUM(A.abschr_vk_o_werbung) AS a0_13,
        AVG(A.stk_ek_kb_stamm) AS a0_14,
        AVG(A.vkpk1) AS a0_15,
        AVG(A.vkpk4) AS a0_16,
        AVG(A.vkpk1 / CAST((F.mwst / 100) + 1 AS FLOAT64)) AS a0_17,
        AVG(A.vkpk4 / CAST((F.mwst / 100) + 1 AS FLOAT64)) AS a0_18,
        SUM(A.umsatz_brutto_tot) AS a0_19,
        SUM(A.umsatz_brutto_af) AS a0_20,
        SUM(A.umsatz_brutto_sa) AS a0_21,
        SUM(0) AS total_anz_markt,
        MAX(CAST(C.lager_prozent AS NUMERIC)) AS a0_22,
        MAX(CASE
            WHEN A.mhd_zeitraum <> 0 AND A.mhd_zeitraum_dz = 0
                THEN A.kol_la
            WHEN A.mhd_zeitraum = 0 AND A.mhd_zeitraum_dz <> 0
                THEN NULL
            WHEN A.mhd_zeitraum <> 0 AND A.mhd_zeitraum_dz <> 0 OR A.mhd_zeitraum = 0 AND A.mhd_zeitraum_dz = 0
                THEN A.kol_la
            ELSE NULL
        END) AS a0_23,
        MAX(CASE
            WHEN A.mhd_zeitraum <> 0 AND A.mhd_zeitraum_dz = 0
                THEN NULL
            WHEN A.mhd_zeitraum = 0 AND A.mhd_zeitraum_dz <> 0
                THEN A.kol_bst
            ELSE NULL
        END) AS a0_24,
        AVG(A.sp_ekkb_01) AS a0_25,
        AVG(A.sp_ekkb_04) AS a0_26
    FROM dbp_etl.sal_aggregat_kmo_2 AS A
    INNER JOIN dbp_data.art_2 AS C ON A.art_id = C.art_id AND A.mandant_id = C.mandant_id
    INNER JOIN dbp_data.mandant_2 AS D ON A.mandant_id = D.mandant_id
    INNER JOIN dbp_data.mwst_per_2 AS F
        ON
            A.mandant_id = F.mandant_id AND C.mwst_id = F.mwst_id AND
            CURRENT_DATE("Europe/Berlin") BETWEEN F.dat_von AND F.dat_bis
    INNER JOIN dbp_etl.sal_monat_2 AS X ON A.mandant_id = X.mandant_id
    GROUP BY
        A.mandant_id,
        A.art_id,
        X.kjmo,
        wrg_id,
        arthiertyp_id,
        A.wg_id,
        A.wug_id,
        art_status,
        gp_id,
        gp_name,
        zek_id,
        eigenmarke_id,
        bio_fg,
        vegan_fg,
        posten_food,
        posten_nonfood,
        gluten_fg,
        mwst,
        disc_pe,
        disc_marke,
        lactose_fg,
        k_listung,
        umrech_faktor_best,
        umrech_faktor_ausg,
        A.mhd_zeitraum,
        A.mhd_zeitraum_dz
) AS t0);


UPDATE dbp_data.sal_kmo_2 SET
    anz_wup_listung = b.anz_listung_as_is FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        SUM(A.listung_id) AS anz_listung_as_is
    FROM dbp_data.art_wup_zu_per_2 AS A
    INNER JOIN dbp_data.wup_2 AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND CURRENT_DATE("Europe/Berlin")
            BETWEEN B.dat_von AND B.dat_bis
    INNER JOIN dbp_data.art_wg_zu_per_2 AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.arthiertyp_id
            = 2 AND C.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE
        A.mandant_id IN (2, 3, 5, 6, 7, 8)
        AND A.listung_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_id
) AS b
WHERE sal_kmo.art_id = b.art_id AND sal_kmo.mandant_id = b.mandant_id AND (
    sal_kmo.kjmo, sal_kmo.mandant_id) IN (
    SELECT (kjmo, mandant_id)
    FROM dbp_etl.sal_monat_2
);


UPDATE dbp_data.sal_kmo_2 SET
    total_anz_markt = b.anz_maerkte FROM (
    SELECT
        t0.mandant_id,
        t0.art_id,
        COUNT(DISTINCT t0.wup_id) AS anz_maerkte
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.art_id,
            SUM(A.menge) AS menge
        FROM dbp_data.artbew_2 AS A
        INNER JOIN dbp_data.tag_2 AS V02 ON A.dat = V02.dat
        INNER JOIN dbp_etl.sal_wochen_2 AS D ON A.mandant_id = D.mandant_id AND V02.kjwo = D.kjwo
        INNER JOIN dbp_data.art_wg_zu_per_2 AS B
            ON
                A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
        GROUP BY
            A.mandant_id,
            A.wup_id,
            A.art_id
        HAVING menge > 0
    ) AS t0
    GROUP BY
        t0.mandant_id,
        t0.art_id
) AS b
WHERE sal_kmo.art_id = b.art_id AND sal_kmo.mandant_id = b.mandant_id AND (
    sal_kmo.kjmo, sal_kmo.mandant_id) IN (
    SELECT (kjmo, mandant_id)
    FROM dbp_etl.sal_monat_2
);
