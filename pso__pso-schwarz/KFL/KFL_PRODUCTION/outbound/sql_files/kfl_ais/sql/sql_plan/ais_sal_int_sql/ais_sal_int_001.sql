CREATE OR REPLACE TABLE dbp_etl.sal_final (
    mandant_id INTEGER,
    art_id INTEGER,
    wrg_id STRING(3) COLLATE 'und:ci',
    kjwo INTEGER,
    owg_id INTEGER,
    wg_id INTEGER,
    wug_id INTEGER,
    k1_artbew_menge NUMERIC(18, 3),
    k1_anz_wup_absatz INTEGER,
    k1_anz_wup_listung INTEGER,
    k2_artbew_menge NUMERIC(18, 3),
    k2_anz_wup_absatz INTEGER,
    k2_anz_wup_listung INTEGER,
    k3_artbew_menge NUMERIC(18, 3),
    k3_anz_wup_absatz INTEGER,
    k3_anz_wup_listung INTEGER,
    k4_artbew_menge NUMERIC(18, 3),
    k4_anz_wup_absatz INTEGER,
    k4_anz_wup_listung INTEGER,
    k5_artbew_menge NUMERIC(18, 3),
    k5_anz_wup_absatz INTEGER,
    k5_anz_wup_listung INTEGER,
    ost_basis_artbew_menge NUMERIC(18, 3),
    ost_basis_anz_wup_absatz INTEGER,
    ost_basis_anz_wup_listung INTEGER,
    ost_gross_artbew_menge NUMERIC(18, 3),
    ost_gross_anz_wup_absatz INTEGER,
    ost_gross_anz_wup_listung INTEGER,
    sued_ost_artbew_menge NUMERIC(18, 3),
    sued_ost_anz_wup_absatz INTEGER,
    sued_ost_anz_wup_listung INTEGER,
    sued_west_artbew_menge NUMERIC(18, 3),
    sued_west_anz_wup_absatz INTEGER,
    sued_west_anz_wup_listung INTEGER,
    west_artbew_menge NUMERIC(18, 3),
    west_anz_wup_absatz INTEGER,
    west_anz_wup_listung INTEGER,
    nord_artbew_menge NUMERIC(18, 3),
    nord_anz_wup_absatz INTEGER,
    nord_anz_wup_listung INTEGER,
    total_artbew_menge FLOAT64,
    total_artbew_menge_sa FLOAT64,
    total_artbew_menge_vj FLOAT64,
    total_umsatz_netto FLOAT64,
    total_umsatz_netto_sa FLOAT64,
    total_umsatz_netto_af FLOAT64,
    total_rohertrag FLOAT64,
    total_rohertrag_sa FLOAT64,
    total_rohertrag_af FLOAT64,
    total_rohertrag_vj FLOAT64,
    total_rohertrag_olk FLOAT64,
    total_rohertrag_olk_sa FLOAT64,
    total_rohertrag_olk_af FLOAT64,
    total_rohertrag_olk_vj FLOAT64,
    abschriftsbetrag_ohne_werbung_netto NUMERIC(18, 2),
    anz_wup_absatz INTEGER,
    anz_wup_listung INTEGER,
    anz_akt_wup_listung INTEGER,
    listung_min_1_wup_fg INTEGER,
    listung_min_1_sst_durchg_fg INTEGER,
    listung_min_1_sst_durchg_mvke_fg INTEGER,
    listung_min_1_region_durchg_fg INTEGER,
    listung_min_1_region_durchg_baustein_fg INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_zu_per AS
SELECT
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_von,
    A.mandant_id,
    A.list_quelle_id,
    A.struktur_art_id,
    A.dat_bis,
    A.baustein_id,
    A.list_sap_id,
    A.list_komponente_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.art_list_wup_zu_per AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN dbp_data.wup AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.list_quelle_id IN ('1', '3', '7', 'C')
    AND A.art_id / 100 = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TABLE dbp_etl.sal_artbew_wg_art_wo_sum AS
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
    A.ek_mep
FROM dbp_data.artbew_wo_sum AS A
INNER JOIN dbp_data.woche_kj_kl AS C ON A.kjwo_kl = C.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE A.mandant_id = 1;


CREATE OR REPLACE VIEW dbp_etl.mv_sal_listung_markt_kw (
    mandant_id, wg_id, art_id, wup_id, nb_id,
    kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, anz_wo_mit_absatz, anz_wo_mit_absatz_sa, anz_wo_mit_absatz_af
)
AS SELECT
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
FROM dbp_etl.sal_artbew_wg_art_wo_sum AS V01
INNER JOIN dbp_view.v_art_wg_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

INNER JOIN dbp_view.v_wup AS V04
    ON
        V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
        = V04.mandant_id
WHERE
    V01.mandant_id = 1
    AND V03.arthiertyp_id = 2
    AND V03.dat_bis = PARSE_DATE('%F', '9999-12-31')
GROUP BY
    V01.mandant_id,
    V01.wg_id,
    V01.art_id,
    V01.wup_id,
    V01.nb_id,
    V04.kreistyp_gruppe_id,
    V01.kjwo;


CREATE OR REPLACE VIEW dbp_etl.mv_sal_artbew_wo_sum (
    kjwo, art_id, wg_id, bewart_id, mandant_id, wup_id,
    nb_id, ek_mep_umsatz, umsatz_netto, vk_menge) AS SELECT
    kjwo,
    art_id,
    wg_id,
    bewart_id,
    mandant_id,
    wup_id,
    nb_id,
    CAST(ek_mep AS FLOAT64) AS ek_mep_umsatz,
    CAST(umsatz_netto AS FLOAT64) AS umsatz_netto,
    CAST(menge AS FLOAT64) AS vk_menge
FROM dbp_etl.sal_artbew_wg_art_wo_sum
WHERE mandant_id = 1;


CREATE OR REPLACE TEMPORARY TABLE _step00 AS
SELECT
    B.kjwo,
    A.mandant_id,
    A.art_id
FROM dbp_data.art AS A
INNER JOIN dbp_data.woche AS B ON TRUE
WHERE
    A.mandant_id = 1
    AND B.kjwo BETWEEN 201901 AND (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE akt_wo = -1
    )
GROUP BY
    B.kjwo,
    A.mandant_id,
    A.art_id;


CREATE OR REPLACE TEMPORARY TABLE _step01 AS
SELECT
    A11.kjwo,
    A11.art_id,
    A11.mandant_id,
    SUM(CASE
        WHEN A14.sm_id = 1 AND A14.mandant_id = 1
            THEN A11.absatz
        ELSE NULL
    END) AS absatz_sk1,
    SUM(CASE
        WHEN A14.sm_id = 1 AND A14.mandant_id = 1
            THEN A11.anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk1,
    SUM(CASE
        WHEN A14.sm_id = 2 AND A14.mandant_id = 1
            THEN A11.absatz
        ELSE NULL
    END) AS absatz_sk2,
    SUM(CASE
        WHEN A14.sm_id = 2 AND A14.mandant_id = 1
            THEN A11.anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk2,
    SUM(CASE
        WHEN A14.sm_id = 3 AND A14.mandant_id = 1
            THEN A11.absatz
        ELSE NULL
    END) AS absatz_sk3,
    SUM(CASE
        WHEN A14.sm_id = 3 AND A14.mandant_id = 1
            THEN A11.anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk3,
    SUM(CASE
        WHEN A14.sm_id = 4 AND A14.mandant_id = 1
            THEN A11.absatz
        ELSE NULL
    END) AS absatz_sk4,
    SUM(CASE
        WHEN A14.sm_id = 4 AND A14.mandant_id = 1
            THEN A11.anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk4,
    SUM(CASE
        WHEN A14.sm_id = 5 AND A14.mandant_id = 1
            THEN A11.absatz
        ELSE NULL
    END) AS absatz_sk5,
    SUM(CASE
        WHEN A14.sm_id = 5 AND A14.mandant_id = 1
            THEN A11.anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sk5,
    SUM(CASE
        WHEN A14.mandant_id = 1 AND A14.sm_id IN (1, 2, 3, 4, 5)
            THEN A11.absatz_sa
        ELSE NULL
    END) AS absatz_sa_sk1_bis6
FROM dbp_etl.mv_sal_listung_markt_kw AS A11
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS A14
    ON
        A11.mandant_id = A14.mandant_id AND A11.nb_id =
        A14.nb_id AND A11.wg_id = A14.wg_id AND A11.wup_id = A14.wup_id
WHERE
    A14.sm_id = 1 AND A14.mandant_id = 1
    OR A14.sm_id = 2 AND A14.mandant_id = 1
    OR A14.sm_id = 3 AND A14.mandant_id = 1
    OR A14.sm_id = 4 AND A14.mandant_id = 1
    OR A14.sm_id = 5 AND A14.mandant_id = 1
GROUP BY
    A11.kjwo,
    A11.art_id,
    A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step02 AS
SELECT
    A11.kjwo,
    A11.art_id,
    A11.mandant_id,
    SUM(CASE
        WHEN A14.sm_id = 1 AND A14.mandant_id = 1
            THEN A11.listung
        ELSE 0
    END) AS list_sk1,
    SUM(CASE
        WHEN A14.sm_id = 2 AND A14.mandant_id = 1
            THEN A11.listung
        ELSE 0
    END) AS list_sk2,
    SUM(CASE
        WHEN A14.sm_id = 3 AND A14.mandant_id = 1
            THEN A11.listung
        ELSE 0
    END) AS list_sk3,
    SUM(CASE
        WHEN A14.sm_id = 4 AND A14.mandant_id = 1
            THEN A11.listung
        ELSE 0
    END) AS list_sk4,
    SUM(CASE
        WHEN A14.sm_id = 5 AND A14.mandant_id = 1
            THEN A11.listung
        ELSE 0
    END) AS list_sk5
FROM dbp_msi_view2.mv_max_listung_markt_kw AS A11
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS A14
    ON
        A11.mandant_id = A14.mandant_id AND A11.nb_id =
        A14.nb_id AND A11.wg_id = A14.wg_id AND A11.wup_id = A14.wup_id
WHERE
    A11.mandant_id = 1
    AND (
        A14.sm_id = 1 AND A14.mandant_id = 1 OR A14.sm_id = 2 AND A14.mandant_id = 1 OR A14.sm_id = 3 AND A14.mandant_id =
        1 OR A14.sm_id = 4 AND A14.mandant_id = 1 OR A14.sm_id = 5 AND A14.mandant_id = 1
    )
GROUP BY
    A11.kjwo,
    A11.art_id,
    A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step03 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'N'
            THEN absatz
        ELSE NULL
    END) AS absatz_nord,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'N'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_nord,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'O'
            THEN absatz
        ELSE NULL
    END) AS absatz_ost_basis,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'O'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_ost_basis,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'Q'
            THEN absatz
        ELSE NULL
    END) AS absatz_ost_gross,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'Q'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_ost_gross,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'G'
            THEN absatz
        ELSE NULL
    END) AS absatz_sued_ost,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'G'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sued_ost,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'M'
            THEN absatz
        ELSE NULL
    END) AS absatz_sued_west,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'M'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_sued_west,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'W'
            THEN absatz
        ELSE NULL
    END) AS absatz_west,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'W'
            THEN anz_wo_mit_absatz
        ELSE NULL
    END) AS anz_wo_mit_abs_west
FROM dbp_etl.mv_sal_listung_markt_kw AS A11
WHERE
    mandant_id = 1
    AND (
        kreistyp_gruppe_id = 'G' OR kreistyp_gruppe_id = 'M' OR kreistyp_gruppe_id = 'N' OR kreistyp_gruppe_id = 'O' OR
        kreistyp_gruppe_id = 'Q' OR kreistyp_gruppe_id = 'W'
    )
GROUP BY
    kjwo,
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step04 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'N' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_nord,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'O' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_ost_basis,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'Q' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_ost_gross,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'G' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_sued_ost,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'M' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_sued_west,
    SUM(CASE
        WHEN kreistyp_gruppe_id = 'W' AND mandant_id = 1
            THEN listung
        ELSE 0
    END) AS list_west
FROM dbp_msi_view2.mv_max_listung_markt_kw AS A11
WHERE
    mandant_id = 1
    AND (
        kreistyp_gruppe_id = 'G' OR kreistyp_gruppe_id = 'M' OR kreistyp_gruppe_id = 'N' OR kreistyp_gruppe_id = 'O' OR
        kreistyp_gruppe_id = 'Q' OR kreistyp_gruppe_id = 'W'
    )
GROUP BY
    kjwo,
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step05 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    COUNT(DISTINCT wup_id) AS anz_markt_abv,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN ek_mep_umsatz
        ELSE NULL
    END), 0) AS re_mep_af,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN ek_mep_umsatz
        ELSE NULL
    END), 0) AS re_mep_sa,
    IFNULL(SUM(umsatz_netto), 0) - IFNULL(SUM(ek_mep_umsatz), 0) AS re_mep_tot,
    IFNULL(SUM(umsatz_netto), 0) AS umsatz_netto_tot,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1001
            THEN umsatz_netto
        ELSE NULL
    END), 0) AS umsatz_netto_af,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN umsatz_netto
        ELSE NULL
    END), 0) AS umsatz_netto_sa,
    IFNULL(SUM(vk_menge), 0) AS menge_tot,
    IFNULL(SUM(CASE
        WHEN bewart_id = 1002
            THEN vk_menge
        ELSE NULL
    END), 0) AS menge_sa
FROM dbp_etl.mv_sal_artbew_wo_sum AS A11
WHERE mandant_id = 1
GROUP BY
    kjwo,
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step07 AS
SELECT
    A14.kjwo,
    A16.art_id,
    A16.mandant_id,
    SUM(A11.abschriftenbetrag_netto) AS abschr_vk_o_werbung
FROM dbp_msi_view2.mv_marktabschriften AS A11
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS A16 ON A11.art_id = A16.art_id AND A11.mandant_id = A16.mandant_id

INNER JOIN dbp_data.tag AS A14 ON A11.dat = A14.dat
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS A17
    ON
        A11.mandant_id = A17.mandant_id AND A11.nb_id =
        A17.nb_id AND A11.wup_id = A17.wup_id AND A16.mandant_id = A17.mandant_id AND A16.wg_id = A17.wg_id
WHERE
    A17.mandant_id = 1
    AND A11.abschriftenart_id IN (
        5, 7, 9, 10, 23, 26, 100, 101, 102, 103, 104, 120, 121, 122, 151, 152, 153, 154, 155, 156,
        157, 158
    )
GROUP BY
    A14.kjwo,
    A16.art_id,
    A16.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step08 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    SUM(listung) AS list_gesamt,
    MAX(listung) AS listung_min_1_wup_fg
FROM dbp_msi_view2.mv_max_listung_markt_kw AS A11
WHERE mandant_id = 1
GROUP BY
    mandant_id,
    art_id,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _step09 AS
SELECT
    A12.kjwo,
    A11.art_id,
    A11.mandant_id,
    CASE
        WHEN MIN(A11.sm_id) <> 0
            THEN 1
        ELSE 0
    END AS listung_min_1_sst_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik AS A11
INNER JOIN dbp_data.woche AS A12 ON TRUE
WHERE
    A11.mandant_id = 1
    AND A11.list_durchg_fg = 1
GROUP BY
    A12.kjwo,
    A11.art_id,
    A11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _step10 AS
SELECT
    T2.kjwo,
    T1.art_id,
    T1.mandant_id,
    CASE
        WHEN
            MAX(T1.typ_ost_basis) <> ' OR\n              MAX(typ_ost_gross) <> ' OR MAX(T1.typ_sued_ost) <>
            ' OR\n              MAX(typ_sued_west) <> ' OR MAX(T1.typ_west) <> ' OR\n              MAX(typ_nord)      <> '
            THEN 1
        ELSE 0
    END AS listung_min_1_region_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik_kreistyp AS T1
INNER JOIN dbp_data.woche AS T2 ON TRUE
WHERE T1.mandant_id = 1
GROUP BY
    T2.kjwo,
    T1.art_id,
    T1.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _step11 AS
SELECT
    B.kjwo,
    A.art_id,
    A.mandant_id,
    A.sm_id
FROM dbp_etl_process.art_sm_vw_zu_per AS A
INNER JOIN dbp_data.woche AS B ON CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
WHERE A.mandant_id = 1
GROUP BY
    B.kjwo,
    A.art_id,
    A.mandant_id,
    A.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _step12 AS
SELECT
    A12.kjwo,
    A11.art_id,
    A11.mandant_id,
    IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1001
            THEN A11.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1001
            THEN A11.ek_mep - A11.logkostenzuschlag
        ELSE NULL
    END), 0) AS re_mep_af_olk,
    IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1002
            THEN A11.umsatz_netto
        ELSE NULL
    END), 0) - IFNULL(SUM(CASE
        WHEN A11.bewart_id = 1002
            THEN A11.ek_mep - A11.logkostenzuschlag
        ELSE NULL
    END), 0) AS re_mep_sa_olk,
    IFNULL(SUM(A11.umsatz_netto), 0) - IFNULL(SUM(A11.ek_mep - A11.logkostenzuschlag), 0) AS re_mep_tot_olk
FROM dbp_data.artbew AS A11
INNER JOIN dbp_data.tag AS A12 ON A11.dat = A12.dat
WHERE A11.mandant_id = 1
GROUP BY
    A12.kjwo,
    A11.art_id,
    A11.mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step14 AS
SELECT
    C.kjwo,
    A.mandant_id,
    A.art_id,
    1 AS list_region_teresa
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND B.dat_eroeffnung
        < CURRENT_DATE("Europe/Berlin")
INNER JOIN dbp_data.woche AS C ON TRUE
WHERE
    A.list_quelle_id IN ('3')
    AND A.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu
    )
    AND B.nb_id = 0
GROUP BY
    C.kjwo,
    A.mandant_id,
    A.art_id;


-- 10.01.2022, -dbay-
--
-- SDQ jetzt mit Sortimentstool-Logik.


CREATE OR REPLACE TABLE dbp_etl.sal_int_artbew_wg_art_wo_sum_de (
    mandant_id INTEGER,
    kjwo INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    bewart_id INTEGER,
    menge NUMERIC(18, 3),
    umsatz_netto NUMERIC(18, 4),
    umsatz_brutto NUMERIC(18, 4),
    ek_mep NUMERIC(18, 4)
);


CREATE OR REPLACE TABLE dbp_etl.sal_int_listung_markt_kw (
    mandant_id INTEGER,
    wg_id INTEGER,
    art_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    kreistyp_gruppe_id STRING(4),
    kjwo INTEGER,
    absatz NUMERIC(18, 3),
    absatz_sa NUMERIC(18, 3),
    absatz_af NUMERIC(18, 3),
    umsatz NUMERIC(18, 4),
    umsatz_sa NUMERIC(18, 4),
    umsatz_af NUMERIC(18, 4),
    umsatz_brutto NUMERIC(18, 4),
    umsatz_brutto_af NUMERIC(18, 4),
    umsatz_brutto_sa NUMERIC(18, 4),
    ertrag NUMERIC(18, 4),
    ertrag_sa NUMERIC(18, 4),
    ertrag_af NUMERIC(18, 4),
    anzahl_wochen_mit_absatz INTEGER,
    anzahl_wochen_mit_absatz_sa INTEGER,
    anzahl_wochen_mit_absatz_af INTEGER
);


INSERT INTO dbp_etl.sal_int_artbew_wg_art_wo_sum_de
(
    SELECT
        A.mandant_id,
        CAST(C.kjwo AS INTEGER) AS kjwo,
        CAST(B.wg_id AS INTEGER) AS wg_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.bewart_id,
        A.menge,
        A.umsatz_netto,
        A.umsatz_netto + A.umsatz_mwst_betrag AS umsatz_brutto,
        A.ek_mep
    FROM dbp_data.artbew_wo_sum AS A
    INNER JOIN dbp_data.woche_kj_kl AS C ON A.kjwo_kl = C.kjwo_kl
    INNER JOIN dbp_data.art_wg_zu_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE A.mandant_id = 1
);


INSERT INTO dbp_etl.sal_int_listung_markt_kw (
    mandant_id, wg_id, art_id, wup_id, nb_id,
    kreistyp_gruppe_id, kjwo, absatz, absatz_sa, absatz_af, umsatz, umsatz_sa, umsatz_af, umsatz_brutto, umsatz_brutto_af,
    umsatz_brutto_sa, ertrag, ertrag_sa, ertrag_af, anzahl_wochen_mit_absatz, anzahl_wochen_mit_absatz_sa,
    anzahl_wochen_mit_absatz_af
)
(
    SELECT
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo,
        IFNULL(SUM(V01.menge), 0) AS absatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.menge
            ELSE NULL
        END), 0) AS NUMERIC) AS absatz_af,
        IFNULL(SUM(V01.umsatz_netto), 0) AS umsatz,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_af,
        IFNULL(SUM(V01.umsatz_brutto), 0) AS umsatz_brutto,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_af,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_brutto
            ELSE NULL
        END), 0) AS NUMERIC) AS umsatz_brutto_sa,
        IFNULL(SUM(V01.umsatz_netto - V01.ek_mep), 0) AS ertrag,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1002
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_sa,
        CAST(IFNULL(SUM(CASE
            WHEN V01.bewart_id = 1001
                THEN V01.umsatz_netto - V01.ek_mep
            ELSE NULL
        END), 0) AS NUMERIC) AS ertrag_af,
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
    FROM dbp_etl.sal_int_artbew_wg_art_wo_sum_de AS V01
    INNER JOIN dbp_data.art_wg_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id

    INNER JOIN dbp_data.wup AS V04
        ON
            V01.wup_id = V04.wup_id AND V01.nb_id = V04.nb_id AND V01.mandant_id
            = V04.mandant_id
    WHERE
        V01.mandant_id = 1
        AND V03.arthiertyp_id = 2
        AND V03.dat_bis = DATE '9999-12-31'
    GROUP BY
        V01.mandant_id,
        V01.wg_id,
        V01.art_id,
        V01.wup_id,
        V01.nb_id,
        V04.kreistyp_gruppe_id,
        V01.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre (
    kjwo INTEGER,
    art_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_mit_absatz FLOAT64,
    anz_wo_mit_absatz_af FLOAT64,
    anz_wo_mit_absatz_sa FLOAT64
);


INSERT INTO zzsp07_pre
(
    SELECT
        kjwo,
        art_id,
        mandant_id,
        wup_id,
        CAST(CASE
            WHEN SUM(absatz) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz,
        CAST(CASE
            WHEN SUM(absatz_af) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_af,
        CAST(CASE
            WHEN SUM(absatz_sa) > 0
                THEN 1
            ELSE 0
        END AS FLOAT64) AS anz_wo_mit_absatz_sa
    FROM dbp_etl.sal_int_listung_markt_kw AS A11
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre_xxx AS
SELECT
    mandant_id,
    kjwo,
    art_id,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(anz_wo_mit_absatz_af) AS anz_wo_mit_absatz_af,
    SUM(anz_wo_mit_absatz_sa) AS anz_wo_mit_absatz_sa
FROM zzsp07_pre
GROUP BY
    mandant_id,
    kjwo,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre (
    kjwo INTEGER,
    art_id INTEGER,
    mandant_id INTEGER,
    wup_id INTEGER,
    anz_wo_listung FLOAT64
);


INSERT INTO zzsp08_pre
(
    SELECT
        kjwo,
        art_id,
        mandant_id,
        wup_id,
        CAST(COUNT(DISTINCT kjwo) AS FLOAT64) AS anz_wo_listung
    FROM dbp_data.art_wup_listung_kjwo AS A11
    WHERE mandant_id = 1
    GROUP BY
        A11.mandant_id,
        A11.art_id,
        A11.wup_id,
        A11.kjwo
);


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_xxx AS
SELECT
    mandant_id,
    kjwo,
    art_id,
    SUM(anz_wo_listung) AS anz_wo_listung
FROM zzsp08_pre
GROUP BY
    mandant_id,
    kjwo,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre_akt AS
SELECT
    mandant_id,
    art_id,
    COUNT(DISTINCT wup_id) AS anz_akt_wup_listung
FROM zzsp08_pre
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    A.kjwo,
    A.art_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id AND A.kjwo =
B.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mm_y AS
SELECT
    A.kjwo,
    A.art_id,
    A.mandant_id,
    A.wup_id,
    A.anz_wo_listung,
    B.anz_wo_mit_absatz
FROM zzsp08_pre AS A
INNER JOIN zzsp07_pre
    AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.wup_id = B.wup_id AND A.kjwo =
B.kjwo;


DELETE FROM `_mm_y`
WHERE anz_wo_mit_absatz = 0;


CREATE OR REPLACE TEMPORARY TABLE _mm_y_xxx AS
SELECT
    mandant_id,
    kjwo,
    art_id,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz
FROM `_mm_y`
GROUP BY
    mandant_id,
    kjwo,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_final AS
SELECT
    A.mandant_id,
    A.art_id,
    'EUR' AS wrg_id,
    A.kjwo,
    C.owg_id,
    B.wg_id,
    B.wug_id,
    COALESCE(D.absatz_sk1, 0) AS k1_artbew_menge,
    COALESCE(D.anz_wo_mit_abs_sk1, 0) AS k1_anz_wup_absatz,
    COALESCE(E.list_sk1, 0) AS k1_anz_wup_listung,
    COALESCE(D.absatz_sk2, 0) AS k2_artbew_menge,
    COALESCE(D.anz_wo_mit_abs_sk2, 0) AS k2_anz_wup_absatz,
    COALESCE(E.list_sk2, 0) AS k2_anz_wup_listung,
    COALESCE(D.absatz_sk3, 0) AS k3_artbew_menge,
    COALESCE(D.anz_wo_mit_abs_sk3, 0) AS k3_anz_wup_absatz,
    COALESCE(E.list_sk3, 0) AS k3_anz_wup_listung,
    COALESCE(D.absatz_sk4, 0) AS k4_artbew_menge,
    COALESCE(D.anz_wo_mit_abs_sk4, 0) AS k4_anz_wup_absatz,
    COALESCE(E.list_sk4, 0) AS k4_anz_wup_listung,
    COALESCE(D.absatz_sk5, 0) AS k5_artbew_menge,
    COALESCE(D.anz_wo_mit_abs_sk5, 0) AS k5_anz_wup_absatz,
    COALESCE(E.list_sk5, 0) AS k5_anz_wup_listung,
    COALESCE(F.absatz_ost_basis, 0) AS ost_basis_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_ost_basis, 0) AS ost_basis_anz_wup_absatz,
    COALESCE(G.list_ost_basis, 0) AS ost_basis_anz_wup_listung,
    COALESCE(F.absatz_ost_gross, 0) AS ost_gross_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_ost_gross, 0) AS ost_gross_anz_wup_absatz,
    COALESCE(G.list_ost_gross, 0) AS ost_gross_anz_wup_listung,
    COALESCE(F.absatz_sued_ost, 0) AS sued_ost_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_sued_ost, 0) AS sued_ost_anz_wup_absatz,
    COALESCE(G.list_sued_ost, 0) AS sued_ost_anz_wup_listung,
    COALESCE(F.absatz_sued_west, 0) AS sued_west_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_sued_west, 0) AS sued_west_anz_wup_absatz,
    COALESCE(G.list_sued_west, 0) AS sued_west_anz_wup_listung,
    COALESCE(F.absatz_west, 0) AS west_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_west, 0) AS west_anz_wup_absatz,
    COALESCE(G.list_west, 0) AS west_anz_wup_listung,
    COALESCE(F.absatz_nord, 0) AS nord_artbew_menge,
    COALESCE(F.anz_wo_mit_abs_nord, 0) AS nord_anz_wup_absatz,
    COALESCE(G.list_nord, 0) AS nord_anz_wup_listung,
    COALESCE(H.menge_tot, 0) AS total_artbew_menge,
    COALESCE(H.menge_sa, 0) AS total_artbew_menge_sa,
    0 AS total_artbew_menge_vj,
    COALESCE(H.umsatz_netto_tot, 0) AS total_umsatz_netto,
    COALESCE(H.umsatz_netto_sa, 0) AS total_umsatz_netto_sa,
    COALESCE(H.umsatz_netto_af, 0) AS total_umsatz_netto_af,
    COALESCE(H.re_mep_tot, 0) AS total_rohertrag,
    COALESCE(H.re_mep_sa, 0) AS total_rohertrag_sa,
    COALESCE(H.re_mep_af, 0) AS total_rohertrag_af,
    0 AS total_rohertrag_vj,
    COALESCE(O.re_mep_tot_olk, 0) AS total_rohertrag_olk,
    COALESCE(O.re_mep_sa_olk, 0) AS total_rohertrag_olk_sa,
    COALESCE(O.re_mep_af_olk, 0) AS total_rohertrag_olk_af,
    0 AS total_rohertrag_olk_vj,
    COALESCE(J.abschr_vk_o_werbung, 0) AS abschriftsbetrag_ohne_werbung_netto,
    COALESCE(R.anz_wo_mit_absatz, 0) AS anz_wup_absatz,
    COALESCE(S.anz_wo_listung, 0) AS anz_wup_listung,
    COALESCE(T.anz_akt_wup_listung, 0) AS anz_akt_wup_listung,
    COALESCE(K.listung_min_1_wup_fg, 0) AS listung_min_1_wup_fg,
    COALESCE(L.listung_min_1_sst_durchg_v1, 0) AS listung_min_1_sst_durchg_fg,
    COALESCE(CASE
        WHEN CAST(N.sm_id AS FLOAT64) > 0
            THEN 1
        ELSE 0
    END, 0) AS listung_min_1_sst_durchg_mvke_fg,
    COALESCE(M.listung_min_1_region_durchg_v1, 0) AS listung_min_1_region_durchg_fg,
    COALESCE(Q.list_region_teresa, 0) AS listung_min_1_region_durchg_baustein_fg
FROM `_step00` AS A
INNER JOIN dbp_data.art_wg_zu_per AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wg_per AS C
    ON
        A.mandant_id = C.mandant_id AND B.wg_id = C.wg_id AND C.dat_bis =
        DATE '9999-12-31' AND C.arthiertyp_id = 2
LEFT JOIN `_step01` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND A.kjwo = D.kjwo
LEFT JOIN `_step02` AS E ON A.mandant_id = E.mandant_id AND A.art_id = E.art_id AND A.kjwo = E.kjwo
LEFT JOIN `_step03` AS F ON A.mandant_id = F.mandant_id AND A.art_id = F.art_id AND A.kjwo = F.kjwo
LEFT JOIN `_step04` AS G ON A.mandant_id = G.mandant_id AND A.art_id = G.art_id AND A.kjwo = G.kjwo
LEFT JOIN `_step05` AS H ON A.mandant_id = H.mandant_id AND A.art_id = H.art_id AND A.kjwo = H.kjwo
LEFT JOIN `_step07` AS J ON A.mandant_id = J.mandant_id AND A.art_id = J.art_id AND A.kjwo = J.kjwo
LEFT JOIN `_step08` AS K ON A.mandant_id = K.mandant_id AND A.art_id = K.art_id AND A.kjwo = K.kjwo
LEFT JOIN `_step09` AS L ON A.mandant_id = L.mandant_id AND A.art_id = L.art_id AND A.kjwo = L.kjwo
LEFT JOIN `_step10` AS M ON A.mandant_id = M.mandant_id AND A.art_id = M.art_id AND A.kjwo = M.kjwo
LEFT JOIN `_step11` AS N ON A.mandant_id = N.mandant_id AND A.art_id = N.art_id AND A.kjwo = N.kjwo
LEFT JOIN `_step12` AS O ON A.mandant_id = O.mandant_id AND A.art_id = O.art_id AND A.kjwo = O.kjwo
LEFT JOIN `_step14` AS Q ON A.mandant_id = Q.mandant_id AND A.art_id = Q.art_id AND A.kjwo = Q.kjwo
LEFT JOIN `_mm_y_xxx` AS R ON A.mandant_id = R.mandant_id AND A.art_id = R.art_id AND A.kjwo = R.kjwo
LEFT JOIN zzsp08_pre_xxx AS S ON A.mandant_id = S.mandant_id AND A.art_id = S.art_id AND A.kjwo = S.kjwo
LEFT JOIN zzsp08_pre_akt AS T ON A.mandant_id = T.mandant_id AND A.art_id = T.art_id;


INSERT INTO dbp_etl.sal_final
(SELECT
    mandant_id,
    art_id,
    wrg_id,
    CAST(kjwo AS INTEGER) AS kjwo,
    CAST(owg_id AS INTEGER) AS owg_id,
    CAST(wg_id AS INTEGER) AS wg_id,
    CAST(wug_id AS INTEGER) AS wug_id,
    CAST(k1_artbew_menge AS NUMERIC) AS k1_artbew_menge,
    k1_anz_wup_absatz,
    CAST(k1_anz_wup_listung AS INTEGER) AS k1_anz_wup_listung,
    CAST(k2_artbew_menge AS NUMERIC) AS k2_artbew_menge,
    k2_anz_wup_absatz,
    CAST(k2_anz_wup_listung AS INTEGER) AS k2_anz_wup_listung,
    CAST(k3_artbew_menge AS NUMERIC) AS k3_artbew_menge,
    k3_anz_wup_absatz,
    CAST(k3_anz_wup_listung AS INTEGER) AS k3_anz_wup_listung,
    CAST(k4_artbew_menge AS NUMERIC) AS k4_artbew_menge,
    k4_anz_wup_absatz,
    CAST(k4_anz_wup_listung AS INTEGER) AS k4_anz_wup_listung,
    CAST(k5_artbew_menge AS NUMERIC) AS k5_artbew_menge,
    k5_anz_wup_absatz,
    CAST(k5_anz_wup_listung AS INTEGER) AS k5_anz_wup_listung,
    CAST(ost_basis_artbew_menge AS NUMERIC) AS ost_basis_artbew_menge,
    ost_basis_anz_wup_absatz,
    CAST(ost_basis_anz_wup_listung AS INTEGER) AS ost_basis_anz_wup_listung,
    CAST(ost_gross_artbew_menge AS NUMERIC) AS ost_gross_artbew_menge,
    ost_gross_anz_wup_absatz,
    CAST(ost_gross_anz_wup_listung AS INTEGER) AS ost_gross_anz_wup_listung,
    CAST(sued_ost_artbew_menge AS NUMERIC) AS sued_ost_artbew_menge,
    sued_ost_anz_wup_absatz,
    CAST(sued_ost_anz_wup_listung AS INTEGER) AS sued_ost_anz_wup_listung,
    CAST(sued_west_artbew_menge AS NUMERIC) AS sued_west_artbew_menge,
    sued_west_anz_wup_absatz,
    CAST(sued_west_anz_wup_listung AS INTEGER) AS sued_west_anz_wup_listung,
    CAST(west_artbew_menge AS NUMERIC) AS west_artbew_menge,
    west_anz_wup_absatz,
    CAST(west_anz_wup_listung AS INTEGER) AS west_anz_wup_listung,
    CAST(nord_artbew_menge AS NUMERIC) AS nord_artbew_menge,
    nord_anz_wup_absatz,
    CAST(nord_anz_wup_listung AS INTEGER) AS nord_anz_wup_listung,
    total_artbew_menge,
    total_artbew_menge_sa,
    CAST(total_artbew_menge_vj AS FLOAT64) AS total_artbew_menge_vj,
    total_umsatz_netto,
    total_umsatz_netto_sa,
    total_umsatz_netto_af,
    total_rohertrag,
    total_rohertrag_sa,
    total_rohertrag_af,
    CAST(total_rohertrag_vj AS FLOAT64) AS total_rohertrag_vj,
    CAST(total_rohertrag_olk AS FLOAT64) AS total_rohertrag_olk,
    CAST(total_rohertrag_olk_sa AS FLOAT64) AS total_rohertrag_olk_sa,
    CAST(total_rohertrag_olk_af AS FLOAT64) AS total_rohertrag_olk_af,
    CAST(total_rohertrag_olk_vj AS FLOAT64) AS total_rohertrag_olk_vj,
    CAST(abschriftsbetrag_ohne_werbung_netto AS NUMERIC) AS abschriftsbetrag_ohne_werbung_netto,
    CAST(anz_wup_absatz AS INTEGER) AS anz_wup_absatz,
    CAST(anz_wup_listung AS INTEGER) AS anz_wup_listung,
    anz_akt_wup_listung,
    CAST(listung_min_1_wup_fg AS INTEGER) AS listung_min_1_wup_fg,
    listung_min_1_sst_durchg_fg,
    listung_min_1_sst_durchg_mvke_fg,
    listung_min_1_region_durchg_fg,
    listung_min_1_region_durchg_baustein_fg
FROM `_sal_final`);


UPDATE dbp_etl.sal_final SET
    listung_min_1_wup_fg = 0
WHERE TRUE;


UPDATE dbp_etl.sal_final SET
    listung_min_1_wup_fg = 1 FROM (
    SELECT
        art_id,
        mandant_id
    FROM dbp_data.art_list_wup_zu_per AS A11
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS b
WHERE sal_final.mandant_id = b.mandant_id AND sal_final.art_id = b.art_id;


DELETE FROM dbp_data.sal_int
WHERE (
    mandant_id, kjwo) IN (
    SELECT (mandant_id, kjwo)
    FROM dbp_etl.sal_final
);


INSERT INTO dbp_data.sal_int (
    mandant_id, art_id, wrg_id, kjwo, owg_id, wg_id, wug_id, k1_artbew_menge,
    k1_anz_wup_absatz, k1_anz_wup_listung, k2_artbew_menge, k2_anz_wup_absatz, k2_anz_wup_listung, k3_artbew_menge,
    k3_anz_wup_absatz, k3_anz_wup_listung, k4_artbew_menge, k4_anz_wup_absatz, k4_anz_wup_listung, k5_artbew_menge,
    k5_anz_wup_absatz, k5_anz_wup_listung, ost_basis_artbew_menge, ost_basis_anz_wup_absatz, ost_basis_anz_wup_listung,
    ost_gross_artbew_menge, ost_gross_anz_wup_absatz, ost_gross_anz_wup_listung, sued_ost_artbew_menge,
    sued_ost_anz_wup_absatz, sued_ost_anz_wup_listung, sued_west_artbew_menge, sued_west_anz_wup_absatz,
    sued_west_anz_wup_listung, west_artbew_menge, west_anz_wup_absatz, west_anz_wup_listung, nord_artbew_menge,
    nord_anz_wup_absatz, nord_anz_wup_listung, total_artbew_menge, total_artbew_menge_sa, total_artbew_menge_vj,
    total_umsatz_netto, total_umsatz_netto_sa, total_umsatz_netto_af, total_rohertrag, total_rohertrag_sa,
    total_rohertrag_af, total_rohetrag_vj, total_rohertrag_olk, total_rohertrag_olk_sa, total_rohertrag_olk_af,
    total_rohertrag_olk_vj, abschriftsbetrag_ohne_werbung_netto, anz_wup_absatz, anz_wup_listung, anz_akt_wup_listung,
    listung_min_1_wup_fg, listung_min_1_sst_durchg_fg, listung_min_1_sst_durchg_mvke_fg, listung_min_1_region_durchg_fg,
    listung_min_1_region_durchg_baustein_fg
)
(
    SELECT DISTINCT
        mandant_id,
        art_id,
        wrg_id,
        kjwo,
        owg_id,
        wg_id,
        wug_id,
        k1_artbew_menge,
        k1_anz_wup_absatz,
        k1_anz_wup_listung,
        k2_artbew_menge,
        k2_anz_wup_absatz,
        k2_anz_wup_listung,
        k3_artbew_menge,
        k3_anz_wup_absatz,
        k3_anz_wup_listung,
        k4_artbew_menge,
        k4_anz_wup_absatz,
        k4_anz_wup_listung,
        k5_artbew_menge,
        k5_anz_wup_absatz,
        k5_anz_wup_listung,
        ost_basis_artbew_menge,
        ost_basis_anz_wup_absatz,
        ost_basis_anz_wup_listung,
        ost_gross_artbew_menge,
        ost_gross_anz_wup_absatz,
        ost_gross_anz_wup_listung,
        sued_ost_artbew_menge,
        sued_ost_anz_wup_absatz,
        sued_ost_anz_wup_listung,
        sued_west_artbew_menge,
        sued_west_anz_wup_absatz,
        sued_west_anz_wup_listung,
        west_artbew_menge,
        west_anz_wup_absatz,
        west_anz_wup_listung,
        nord_artbew_menge,
        nord_anz_wup_absatz,
        nord_anz_wup_listung,
        ROUND(CAST(total_artbew_menge AS NUMERIC), 3) AS total_artbew_menge,
        ROUND(CAST(total_artbew_menge_sa AS NUMERIC), 3) AS total_artbew_menge_sa,
        ROUND(CAST(total_artbew_menge_vj AS NUMERIC), 3) AS total_artbew_menge_vj,
        ROUND(CAST(total_umsatz_netto AS NUMERIC), 4) AS total_umsatz_netto,
        ROUND(CAST(total_umsatz_netto_sa AS NUMERIC), 4) AS total_umsatz_netto_sa,
        ROUND(CAST(total_umsatz_netto_af AS NUMERIC), 4) AS total_umsatz_netto_af,
        ROUND(CAST(total_rohertrag AS NUMERIC), 4) AS total_rohertrag,
        ROUND(CAST(total_rohertrag_sa AS NUMERIC), 4) AS total_rohertrag_sa,
        ROUND(CAST(total_rohertrag_af AS NUMERIC), 4) AS total_rohertrag_af,
        ROUND(CAST(total_rohertrag_vj AS NUMERIC), 4) AS total_rohertrag_vj,
        ROUND(CAST(total_rohertrag_olk AS NUMERIC), 4) AS total_rohertrag_olk,
        ROUND(CAST(total_rohertrag_olk_sa AS NUMERIC), 4) AS total_rohertrag_olk_sa,
        ROUND(CAST(total_rohertrag_olk_af AS NUMERIC), 4) AS total_rohertrag_olk_af,
        ROUND(CAST(total_rohertrag_olk_vj AS NUMERIC), 4) AS total_rohertrag_olk_vj,
        abschriftsbetrag_ohne_werbung_netto,
        anz_wup_absatz,
        anz_wup_listung,
        anz_akt_wup_listung,
        listung_min_1_wup_fg,
        listung_min_1_sst_durchg_fg,
        listung_min_1_sst_durchg_mvke_fg,
        listung_min_1_region_durchg_fg,
        listung_min_1_region_durchg_baustein_fg
    FROM dbp_etl.sal_final
    WHERE
        total_artbew_menge <> 0
        OR listung_min_1_wup_fg = 1
        OR anz_wup_listung > 0
        OR abschriftsbetrag_ohne_werbung_netto <> 0
);


CREATE OR REPLACE TEMPORARY TABLE _step0 AS
SELECT
    mandant_id,
    art_id
FROM dbp_data.sal_int
GROUP BY
    mandant_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    art_id,
    mandant_id,
    CASE
        WHEN MIN(sm_id) <> 0
            THEN 1
        ELSE 0
    END AS listung_min_1_sst_durchg_v1
FROM dbp_msi_view2.mv_sternchen_logik AS A11
WHERE
    mandant_id = 1
    AND list_durchg_fg = 1
GROUP BY
    art_id,
    mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    art_id,
    mandant_id,
    CASE
        WHEN
            MAX(typ_ost_basis) <> 0 OR MAX(typ_ost_gross) <> 0 OR MAX(typ_sued_ost) <> 0 OR MAX(typ_sued_west) <> 0 OR MAX(typ_west
            ) <> 0 OR MAX(typ_nord) <> 0
            THEN 1
        ELSE 0
    END AS listung_min_1_region_durchg_v1
FROM (
    SELECT
        art_id,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'O' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_ost_basis,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'Q' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_ost_gross,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'G' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_sued_ost,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'M' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_sued_west,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'W' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_west,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'N' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_nord,
        mandant_id
    FROM dbp_data.sternchen_logik_kreis AS V01
    WHERE mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS t1
WHERE mandant_id = 1
GROUP BY
    art_id,
    mandant_id;


CREATE OR REPLACE TEMPORARY TABLE _step3 AS
SELECT
    art_id,
    mandant_id,
    sm_id
FROM dbp_etl_process.art_sm_vw_zu_per AS A
WHERE
    mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
GROUP BY
    art_id,
    mandant_id,
    sm_id;


CREATE OR REPLACE TEMPORARY TABLE _step4 AS
SELECT
    A.mandant_id,
    A.art_id,
    1 AS list_region_teresa
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND B.dat_eroeffnung
        < CURRENT_DATE("Europe/Berlin")
INNER JOIN dbp_data.woche AS C ON TRUE
WHERE
    A.list_quelle_id IN ('3')
    AND A.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu
    )
    AND B.nb_id = 0
GROUP BY
    A.mandant_id,
    A.art_id,
    list_region_teresa;


CREATE OR REPLACE TEMPORARY TABLE _sal_upd AS
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(B.listung_min_1_sst_durchg_v1, 0) AS listung_min_1_sst_durchg_fg,
    COALESCE(CASE
        WHEN CAST(D.sm_id AS FLOAT64) > 0
            THEN 1
        ELSE 0
    END, 0) AS listung_min_1_sst_durchg_mvke_fg,
    COALESCE(C.listung_min_1_region_durchg_v1, 0) AS listung_min_1_region_durchg_fg,
    COALESCE(E.list_region_teresa, 0) AS listung_min_1_region_durchg_baustein_fg
FROM `_step0` AS A
LEFT JOIN `_step1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
LEFT JOIN `_step2` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
LEFT JOIN `_step3` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id
LEFT JOIN `_step4` AS E ON A.mandant_id = E.mandant_id AND A.art_id = E.art_id;


CREATE OR REPLACE TEMPORARY TABLE _sal_upd2 AS
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(b.listung_min_1_wup_fg, 0) AS listung_min_1_wup_fg
FROM `_sal_upd` AS A
LEFT JOIN (
    SELECT
        art_id,
        mandant_id,
        1 AS listung_min_1_wup_fg
    FROM dbp_data.art_list_wup_zu_per AS A11
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id;


UPDATE dbp_data.sal_int SET
    listung_min_1_wup_fg = 0,
    listung_min_1_sst_durchg_fg = 0,
    listung_min_1_sst_durchg_mvke_fg = 0,
    listung_min_1_region_durchg_fg = 0,
    listung_min_1_region_durchg_baustein_fg = 0
WHERE TRUE;


UPDATE dbp_data.sal_int SET
    listung_min_1_wup_fg = 0,
    listung_min_1_sst_durchg_fg = 0,
    listung_min_1_sst_durchg_mvke_fg = 0,
    listung_min_1_region_durchg_fg = 0,
    listung_min_1_region_durchg_baustein_fg = 0
WHERE TRUE;

UPDATE dbp_data.sal_int SET
    listung_min_1_sst_durchg_fg = b.listung_min_1_sst_durchg_fg,
    listung_min_1_sst_durchg_mvke_fg = b.listung_min_1_sst_durchg_mvke_fg,
    listung_min_1_region_durchg_fg = b.listung_min_1_region_durchg_fg,
    listung_min_1_region_durchg_baustein_fg = b.listung_min_1_region_durchg_baustein_fg FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(listung_min_1_sst_durchg_fg) AS listung_min_1_sst_durchg_fg,
        MAX(listung_min_1_sst_durchg_mvke_fg) AS listung_min_1_sst_durchg_mvke_fg,
        MAX(listung_min_1_region_durchg_fg) AS listung_min_1_region_durchg_fg,
        MAX(listung_min_1_region_durchg_baustein_fg) AS listung_min_1_region_durchg_baustein_fg
    FROM `_sal_upd`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE sal_int.mandant_id = b.mandant_id AND sal_int.art_id = b.art_id;


-- 02.02.22, -dbay-
--
-- update for assortment tool for keeping it synchronized


CREATE OR REPLACE TEMPORARY TABLE _daily_sal_upd AS
SELECT
    A.mandant_id,
    B.matching_id,
    COALESCE(B.anzahl_markt_wochen_kombis_abverkauf_mit_listung, 0) AS tm_anz_abverkauf,
    COALESCE(B.anzahl_markt_wochen_kombis_listung, 0) AS tm_anz_listung,
    SUM(A.anz_wup_absatz) AS sal_anz_abverkauf,
    SUM(A.anz_wup_listung) AS sal_anz_listung
FROM dbp_data.sal_int AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
INNER JOIN dbp_etl_process.tupel_mat_etl AS B ON c.mandant_id = B.mandant_id AND c.art_matching_id = B.matching_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY ((RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1) BETWEEN -52 AND (-1)
    )
    AND A.mandant_id = 1
    AND B.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl
        WHERE mandant_id = 1
    )
GROUP BY
    A.mandant_id,
    B.matching_id,
    tm_anz_abverkauf,
    tm_anz_listung
HAVING tm_anz_abverkauf <> sal_anz_abverkauf OR tm_anz_listung <> sal_anz_listung;


UPDATE dbp_etl_process.tupel_mat_etl SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id AND tupel_mat_etl.matching_id = b.matching_id AND tupel_mat_etl.a500_kjwo_update
    IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl
        WHERE mandant_id = 1
    );


UPDATE dbp_msi_data.tupel_mat_quarantaene SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE
    tupel_mat_quarantaene.mandant_id = b.mandant_id AND tupel_mat_quarantaene.matching_id = b.matching_id AND
    tupel_mat_quarantaene.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl
        WHERE mandant_id = 1
    );


UPDATE dbp_msi_data.tupel_mat SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE tupel_mat.mandant_id = b.mandant_id AND tupel_mat.matching_id = b.matching_id AND tupel_mat.a500_kjwo_update IN (
    SELECT MAX(a500_kjwo_update) AS a1581216993
    FROM dbp_etl_process.tupel_mat_etl
    WHERE mandant_id = 1
);
