CREATE OR REPLACE TEMPORARY TABLE _xxx_woche_sort AS
SELECT c.kjmo AS kjmo_sort
FROM dbp_data.monat AS a
INNER JOIN (
    SELECT kjmo_sort
    FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
    WHERE
        kjwo_bis IN (
            SELECT MAX(kjwo) AS a1886115246
            FROM dbp_data.art_nielsen_fakten_kjwo
            WHERE
                mandant_id = 1
        )
) AS b
    ON a.kjmo = b.kjmo_sort
INNER JOIN dbp_data.monat AS c
    ON a.akt_mo = c.akt_mo;

CREATE OR REPLACE TEMPORARY TABLE zzmq01 AS
SELECT
    kjwo,
    kjwo_vj,
    (
        SELECT *
        FROM `_xxx_woche_sort`
    ) AS kjmo_sort
FROM dbp_data.woche
WHERE
    kjwo BETWEEN (
        SELECT kjwo_von
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    ) AND (
        SELECT kjwo_bis
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    )
GROUP BY
    kjwo,
    kjwo_vj;

CREATE OR REPLACE TABLE dbp_etl.bf_artbew_wg_art_wo_sum_stp_de AS
SELECT
    a.mandant_id,
    c.kjwo,
    b.wg_id,
    a.art_id,
    a.wup_id,
    a.nb_id,
    a.bewart_id,
    a.menge,
    a.umsatz_netto,
    a.ek_mep
FROM dbp_data.artbew_wo_sum AS a
INNER JOIN dbp_data.woche_kj_kl AS c
    ON a.kjwo_kl = c.kjwo_kl
INNER JOIN dbp_data.art_wg_zu_per AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
WHERE
    a.mandant_id = 1 AND b.wg_id BETWEEN 1 AND 999;

CREATE OR REPLACE VIEW dbp_etl.mv_artbew_wo_sum AS
SELECT
    kjwo,
    art_id,
    wg_id,
    bewart_id,
    mandant_id,
    wup_id,
    nb_id,
    CAST(ek_mep AS FLOAT64) AS ek_mep_umsatz,
    CAST(umsatz_netto AS FLOAT64) AS umsatz_netto,
    CAST(menge AS FLOAT64) AS menge
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de
WHERE
    mandant_id = 1;

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_kw AS
SELECT
    v01.mandant_id,
    v01.wg_id,
    v01.art_id,
    v01.wup_id,
    v01.nb_id,
    v04.kreistyp_gruppe_id,
    v01.kjwo,
    IFNULL(SUM(v01.menge), 0) AS absatz,
    IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) AS absatz_sa,
    IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) AS absatz_af,
    IFNULL(COUNT(DISTINCT v01.kjwo), 0) AS anz_wo_mit_absatz,
    IFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo ELSE NULL END), 0) AS anz_wo_mit_absatz_sa,
    IFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo ELSE NULL END), 0) AS anz_wo_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de AS v01
INNER JOIN dbp_data.art_wg_zu_per AS v03
    ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
INNER JOIN dbp_data.wup AS v04
    ON
        v01.wup_id = v04.wup_id
        AND v01.nb_id = v04.nb_id
        AND v01.mandant_id = v04.mandant_id
WHERE
    v01.mandant_id = 1
    AND v03.arthiertyp_id = 2
    AND v03.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
    v01.mandant_id,
    v01.wg_id,
    v01.art_id,
    v01.wup_id,
    v01.nb_id,
    v04.kreistyp_gruppe_id,
    v01.kjwo;

CREATE OR REPLACE VIEW dbp_etl.mv_listung_markt_tag AS
SELECT
    v01.mandant_id,
    v03.wg_id,
    v01.art_id,
    v01.dat,
    v02.kjwo,
    v01.wup_id,
    IFNULL(SUM(v01.menge), 0) AS absatz,
    IFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge ELSE NULL END), 0) AS absatz_sa,
    IFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge ELSE NULL END), 0) AS absatz_af,
    IFNULL(COUNT(DISTINCT v02.dat), 0) AS anz_tage_mit_absatz,
    IFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.dat ELSE NULL END), 0) AS anz_tage_mit_absatz_sa,
    IFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.dat ELSE NULL END), 0) AS anz_tage_mit_absatz_af
FROM dbp_view.v_artbew AS v01
INNER JOIN dbp_view.v_tag AS v02
    ON v01.dat = v02.dat
INNER JOIN dbp_view.v_art_wg_zu_per AS v03
    ON v01.art_id = v03.art_id AND v01.mandant_id = v03.mandant_id
INNER JOIN dbp_view.v_wup AS v04
    ON
        v01.wup_id = v04.wup_id
        AND v01.nb_id = v04.nb_id
        AND v01.mandant_id = v04.mandant_id
WHERE
    v01.mandant_id = 1
    AND v03.arthiertyp_id = 2
    AND v03.dat_bis = CAST('9999-12-31' AS DATE)
GROUP BY
    v01.mandant_id,
    v03.wg_id,
    v01.art_id,
    v01.dat,
    v02.kjwo,
    v01.wup_id;

CREATE OR REPLACE TEMPORARY TABLE zzmq00 AS
SELECT
    a.art_id,
    a.mandant_id
FROM dbp_data.art AS a
INNER JOIN dbp_data.art_wg_zu_per AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
WHERE
    a.wg_art_fg = 0
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a.mandant_id = 1
GROUP BY
    a.art_id,
    a.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd02 AS
SELECT
    xxx.kjwo,
    a13.art_id AS art_id,
    a13.mandant_id AS mandant_id,
    MAX(a11.ek_kal_basis) AS stk_ek_kb_stamm
FROM dbp_msi_view2.mv_einkaufspreisstamm AS a11
INNER JOIN zzmq01 AS xxx
    ON 1 = 1
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a13
    ON a11.art_id = a13.art_id AND a11.mandant_id = a13.mandant_id
WHERE
    a13.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            a13.mandant_id = 1
    )
    AND a13.mandant_id = 1
GROUP BY
    1,
    2,
    3;

CREATE OR REPLACE TEMPORARY TABLE zzmd03 AS
SELECT
    xxx.kjwo,
    a11.art_id,
    a11.mandant_id,
    MAX(a11.vkpk1) AS wjxbfs1,
    MAX(a11.vkpk4) AS wjxbfs2
FROM dbp_msi_view2.mv_art_pm_vw_akt AS a11
INNER JOIN zzmq01 AS xxx
    ON TRUE
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a13
    ON a11.art_id = a13.art_id AND a11.mandant_id = a13.mandant_id
WHERE
    a13.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a13.mandant_id = 1
GROUP BY
    xxx.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd04 AS
SELECT
    xxx.kjwo,
    a12.art_id,
    a12.mandant_id,
    IFNULL(MAX(a11.mwst) / 100.0, 0) + 1.0 AS wjxbfs1
FROM dbp_msi_view2.mv_mwst_per AS a11
INNER JOIN zzmq01 AS xxx
    ON TRUE
INNER JOIN dbp_msi_view2.mv_art AS a12
    ON a11.mwst_id = a12.mwst_id
INNER JOIN zzmq00 AS pa13
    ON a12.art_id = pa13.art_id AND a12.mandant_id = pa13.mandant_id
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a14
    ON a12.art_id = a14.art_id AND a12.mandant_id = a14.mandant_id
WHERE
    a14.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a14.mandant_id = 1
GROUP BY
    xxx.kjwo,
    a12.art_id,
    a12.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzoj05 AS
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd02 AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd03 AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd04 AS pa11
GROUP BY
    1,
    2,
    3;

CREATE OR REPLACE TEMPORARY TABLE zzmd06 AS
SELECT
    pa11.kjwo,
    pa11.art_id AS art_id,
    pa11.mandant_id AS mandant_id,
    MAX(
        CASE
            WHEN pa12.stk_ek_kb_stamm IS NULL
                THEN NULL
            ELSE 1 - coalesce(pa12.stk_ek_kb_stamm / nullif(pa13.wjxbfs1 / nullif(pa14.wjxbfs1, 0), 0), 0)
        END
    ) AS sp_ekkb_01,
    MAX(
        CASE
            WHEN pa12.stk_ek_kb_stamm IS NULL
                THEN NULL
            ELSE 1 - coalesce(pa12.stk_ek_kb_stamm / nullif(pa13.wjxbfs2 / nullif(pa14.wjxbfs1, 0), 0), 0)
        END
    ) AS sp_ekkb_04
FROM zzoj05 AS pa11
LEFT OUTER JOIN zzmd02 AS pa12
    ON
        pa11.art_id = pa12.art_id
        AND pa11.mandant_id = pa12.mandant_id
        AND pa11.kjwo = pa12.kjwo
LEFT OUTER JOIN zzmd03 AS pa13
    ON
        pa11.art_id = pa13.art_id
        AND pa11.mandant_id = pa13.mandant_id
        AND pa11.kjwo = pa13.kjwo
LEFT OUTER JOIN zzmd04 AS pa14
    ON
        pa11.art_id = pa14.art_id
        AND pa11.mandant_id = pa14.mandant_id
        AND pa11.kjwo = pa14.kjwo
GROUP BY
    1,
    2,
    3;

CREATE OR REPLACE TEMPORARY TABLE zzsp07_pre AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    a11.wup_id,
    COUNT(DISTINCT a11.wup_id) AS anz_maerkte,
    SUM(a11.absatz) AS absatz_gesamt,
    SUM(a11.anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(a11.absatz_af) AS absatz_af_sk1_bis6,
    SUM(a11.anz_wo_mit_absatz_af) AS anz_wo_mit_abs_af_sk1_bis6,
    SUM(a11.anz_wo_mit_absatz) AS anz_wo_mit_abs_tot_sk1_bis6
FROM dbp_etl.mv_listung_markt_kw AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN zzmq01 AS xxx
    ON a11.kjwo = xxx.kjwo
WHERE
    a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    a11.wup_id;

CREATE OR REPLACE TEMPORARY TABLE zzsp08_pre AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    a11.wup_id,
    SUM(a11.listung) AS anz_wo_listung
FROM dbp_msi_view2.mv_max_listung_markt_kw AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN zzmq01 AS pa13
    ON a11.kjwo = pa13.kjwo
WHERE
    a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    a11.wup_id;

CREATE OR REPLACE TEMPORARY TABLE _mm AS
SELECT
    a.kjwo,
    a.art_id,
    a.mandant_id,
    a.wup_id,
    a.anz_wo_listung,
    b.anz_maerkte,
    b.absatz_gesamt,
    b.anz_wo_mit_absatz,
    b.absatz_af_sk1_bis6,
    b.anz_wo_mit_abs_af_sk1_bis6,
    b.anz_wo_mit_abs_tot_sk1_bis6
FROM zzsp08_pre AS a
INNER JOIN zzsp07_pre AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND a.wup_id = b.wup_id
        AND a.kjwo = b.kjwo;

INSERT INTO `_mm`
(
    SELECT
        kjwo,
        art_id,
        mandant_id,
        wup_id,
        anz_wo_listung,
        0,
        0,
        0,
        0,
        0,
        0
    FROM zzsp08_pre
    WHERE
        NOT (kjwo, art_id, mandant_id, wup_id) IN (
            SELECT (kjwo, art_id, mandant_id, wup_id)
            FROM `_mm`
        )
);

CREATE OR REPLACE TEMPORARY TABLE zzsp07 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    COUNT(DISTINCT wup_id) AS anz_maerkte,
    SUM(absatz_gesamt) AS absatz_gesamt,
    SUM(anz_wo_mit_absatz) AS anz_wo_mit_absatz,
    SUM(absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
    SUM(anz_wo_mit_abs_af_sk1_bis6) AS anz_wo_mit_abs_af_sk1_bis6,
    SUM(anz_wo_mit_abs_tot_sk1_bis6) AS anz_wo_mit_abs_tot_sk1_bis6
FROM zzsp07_pre AS a11
WHERE
    anz_wo_mit_absatz <> 0
GROUP BY
    kjwo,
    art_id,
    mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzsp08 AS
SELECT
    kjwo,
    art_id,
    mandant_id,
    SUM(anz_wo_listung) AS anz_wo_listung
FROM zzsp08_pre AS a11
GROUP BY
    kjwo,
    art_id,
    mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzoj09 AS
SELECT
    kjwo,
    art_id,
    mandant_id
FROM zzsp07 AS pa11
GROUP BY
    kjwo,
    art_id,
    mandant_id
UNION DISTINCT
SELECT
    kjwo,
    art_id,
    mandant_id
FROM zzsp08 AS pa11
GROUP BY
    kjwo,
    art_id,
    mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0a_xxx AS
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id,
    1.0 AS wjxbfs1,
    pa12.absatz_gesamt,
    pa13.anz_wo_listung,
    pa12.anz_wo_mit_absatz,
    pa12.anz_maerkte,
    pa12.absatz_af_sk1_bis6,
    pa12.anz_wo_mit_abs_af_sk1_bis6,
    pa12.anz_wo_mit_abs_tot_sk1_bis6
FROM zzoj09 AS pa11
LEFT JOIN zzsp07 AS pa12
    ON
        pa11.art_id = pa12.art_id
        AND pa11.mandant_id = pa12.mandant_id
        AND pa11.kjwo = pa12.kjwo
LEFT JOIN zzsp08 AS pa13
    ON
        pa11.art_id = pa13.art_id
        AND pa11.mandant_id = pa13.mandant_id
        AND pa11.kjwo = pa13.kjwo;

CREATE OR REPLACE TEMPORARY TABLE zzmd0b AS
SELECT
    MAX(a11.kjwo) AS max_kjwo,
    MIN(a11.kjwo) AS min_kjwo
FROM dbp_data.woche AS a11
INNER JOIN zzmq01 AS pa12
    ON a11.kjwo = pa12.kjwo;

CREATE OR REPLACE TEMPORARY TABLE zzmd0c AS
SELECT
    xxx.kjwo,
    a13.art_id,
    a13.mandant_id,
    MIN(a11.sm_id) AS min_durchg_gelistet_sst
FROM dbp_msi_view2.mv_sternchen_logik AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN zzmq01 AS xxx
    ON TRUE
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a13
    ON a11.art_id = a13.art_id AND a11.mandant_id = a13.mandant_id
WHERE
    a13.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a13.mandant_id = 1
    AND a11.list_durchg_fg = 1
GROUP BY
    xxx.kjwo,
    a13.art_id,
    a13.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0d AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(a11.umsatz_netto) AS kassenumsatz_sk_1_bis_6,
    SUM(a11.ek_mep_umsatz) AS ek_mep_ums_sk1_bis_6,
    SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto ELSE NULL END) AS kassenumsatz_af_sk_1_bis_6,
    SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep_umsatz ELSE NULL END) AS ek_mep_ums_sa_sk1_bis_6,
    SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto ELSE NULL END) AS kassenumsatz_sa_sk_1_bis_6
FROM dbp_etl.mv_artbew_wo_sum AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS a16
    ON
        a11.mandant_id = a16.mandant_id
        AND a11.nb_id = a16.nb_id
        AND a11.wup_id = a16.wup_id
        AND a11.wg_id = a16.wg_id
INNER JOIN zzmq01 AS xxx
    ON a11.kjwo = xxx.kjwo
WHERE
    a11.mandant_id = 1
    AND a16.sm_id IN (1, 2, 3, 4, 5)
    AND a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0e AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(CASE WHEN a14.sm_id = 1 AND a14.mandant_id = 1 THEN a11.absatz ELSE NULL END) AS absatz_sk1,
    SUM(
        CASE
            WHEN a14.sm_id = 1 AND a14.mandant_id = 1
                THEN a11.anz_wo_mit_absatz
            ELSE NULL
        END
    ) AS anz_wo_mit_abs_sk1,
    SUM(CASE WHEN a14.sm_id = 2 AND a14.mandant_id = 1 THEN a11.absatz ELSE NULL END) AS absatz_sk2,
    SUM(
        CASE
            WHEN a14.sm_id = 2 AND a14.mandant_id = 1
                THEN a11.anz_wo_mit_absatz
            ELSE NULL
        END
    ) AS anz_wo_mit_abs_sk2,
    SUM(CASE WHEN a14.sm_id = 3 AND a14.mandant_id = 1 THEN a11.absatz ELSE NULL END) AS absatz_sk3,
    SUM(
        CASE
            WHEN a14.sm_id = 3 AND a14.mandant_id = 1
                THEN a11.anz_wo_mit_absatz
            ELSE NULL
        END
    ) AS anz_wo_mit_abs_sk3,
    SUM(CASE WHEN a14.sm_id = 4 AND a14.mandant_id = 1 THEN a11.absatz ELSE NULL END) AS absatz_sk4,
    SUM(
        CASE
            WHEN a14.sm_id = 4 AND a14.mandant_id = 1
                THEN a11.anz_wo_mit_absatz
            ELSE NULL
        END
    ) AS anz_wo_mit_abs_sk4,
    SUM(CASE WHEN a14.sm_id = 5 AND a14.mandant_id = 1 THEN a11.absatz ELSE NULL END) AS absatz_sk5,
    SUM(
        CASE
            WHEN a14.sm_id = 5 AND a14.mandant_id = 1
                THEN a11.anz_wo_mit_absatz
            ELSE NULL
        END
    ) AS anz_wo_mit_abs_sk5,
    SUM(
        CASE
            WHEN a14.mandant_id = 1 AND a14.sm_id IN (1, 2, 3, 4, 5)
                THEN a11.absatz_sa
            ELSE NULL
        END
    ) AS absatz_sa_sk1_bis6
FROM dbp_etl.mv_listung_markt_kw AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS a14
    ON
        a11.mandant_id = a14.mandant_id
        AND a11.nb_id = a14.nb_id
        AND a11.wg_id = a14.wg_id
        AND a11.wup_id = a14.wup_id
WHERE
    a14.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
    AND (
        a14.sm_id = 1
        AND a14.mandant_id = 1
        OR a14.sm_id = 2
        AND a14.mandant_id = 1
        OR a14.sm_id = 3
        AND a14.mandant_id = 1
        OR a14.sm_id = 4
        AND a14.mandant_id = 1
        OR a14.sm_id = 5
        AND a14.mandant_id = 1
        OR a14.mandant_id = 1
        AND a14.sm_id IN (1, 2, 3, 4, 5)
    )
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0f AS
SELECT
    a14.kjwo,
    a16.art_id AS art_id,
    a16.mandant_id AS mandant_id,
    sum(a11.abschriftenbetrag_netto) AS abschr_vk_o_werbung
FROM dbp_msi_view2.mv_marktabschriften AS a11
INNER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a16
    ON a11.art_id = a16.art_id AND a11.mandant_id = a16.mandant_id
INNER JOIN zzmq00 AS pa13
    ON a16.art_id = pa13.art_id AND a16.mandant_id = pa13.mandant_id
INNER JOIN dbp_msi_view2.mv_tag AS a14
    ON a11.dat = a14.dat
INNER JOIN zzmq01 AS pa15
    ON a14.kjwo = pa15.kjwo
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS a17
    ON
        a11.mandant_id = a17.mandant_id
        AND a11.nb_id = a17.nb_id
        AND a11.wup_id = a17.wup_id
        AND a16.mandant_id = a17.mandant_id
        AND a16.wg_id = a17.wg_id
WHERE
    a17.mandant_id = 1
    AND a17.sm_id IN (1, 2, 3, 4, 5)
    AND a16.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            a16.mandant_id = 1
    )
    AND a16.mandant_id = 1
    AND a11.abschriftenart_id <> -1
GROUP BY
    1,
    2,
    3;

CREATE OR REPLACE TEMPORARY TABLE zzmd0g AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'N' THEN a11.absatz ELSE NULL END) AS absatz_nord,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'N' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_nord,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'O' THEN a11.absatz ELSE NULL END) AS absatz_ost_basis,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'O' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_ost_basis,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'Q' THEN a11.absatz ELSE NULL END) AS absatz_ost_gross,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'Q' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_ost_gross,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'G' THEN a11.absatz ELSE NULL END) AS absatz_sued_ost,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'G' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_sued_ost,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'M' THEN a11.absatz ELSE NULL END) AS absatz_sued_west,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'M' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_sued_west,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'W' THEN a11.absatz ELSE NULL END) AS absatz_west,
    SUM(CASE WHEN a11.kreistyp_gruppe_id = 'W' THEN a11.anz_wo_mit_absatz ELSE NULL END) AS anz_wo_mit_abs_west
FROM dbp_etl.mv_listung_markt_kw AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
WHERE
    a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
    AND (
        a11.kreistyp_gruppe_id = 'G'
        OR a11.kreistyp_gruppe_id = 'M'
        OR a11.kreistyp_gruppe_id = 'N'
        OR a11.kreistyp_gruppe_id = 'O'
        OR a11.kreistyp_gruppe_id = 'Q'
        OR a11.kreistyp_gruppe_id = 'W'
    )
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmdxy AS
SELECT
    xxx.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(a11.absatz_sa) AS absatz_sa_sk1_bis6,
    SUM(a11.anz_tage_mit_absatz_sa) AS anz_tage_mit_abs_sa_sk1_bis6
FROM dbp_etl.mv_listung_markt_tag AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
INNER JOIN dbp_data.tag AS xxx
    ON a11.dat = xxx.dat
WHERE
    a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
    AND a11.dat BETWEEN (
        SELECT dat_von
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    ) AND (
        SELECT dat_bis
        FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum
        WHERE
            kjmo_sort IN (
                SELECT kjmo_sort
                FROM `_xxx_woche_sort`
            )
    )
GROUP BY
    xxx.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0h AS
SELECT
    pa15.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(a11.ek_mep_umsatz) AS ek_mep_ums_sk1_bis_6_vj,
    SUM(a11.umsatz_netto) AS kassenumsatz_sk_1_bis_6_vj
FROM dbp_etl.mv_artbew_wo_sum AS a11
INNER JOIN zzmq00 AS pa14
    ON a11.art_id = pa14.art_id AND a11.mandant_id = pa14.mandant_id
INNER JOIN zzmq01 AS pa15
    ON a11.kjwo = pa15.kjwo_vj
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS a17
    ON
        a11.mandant_id = a17.mandant_id
        AND a11.nb_id = a17.nb_id
        AND a11.wup_id = a17.wup_id
        AND a11.wg_id = a17.wg_id
WHERE
    a17.sm_id IN (1, 2, 3, 4, 5)
    AND a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
GROUP BY
    pa15.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0i AS
SELECT
    pa15.kjwo,
    a11.art_id,
    a11.mandant_id,
    SUM(a11.absatz) AS absatz_vj_sk1_bis_6
FROM dbp_etl.mv_listung_markt_kw AS a11
INNER JOIN zzmq00 AS pa13
    ON a11.art_id = pa13.art_id AND a11.mandant_id = pa13.mandant_id
INNER JOIN zzmq01 AS pa15
    ON a11.kjwo = pa15.kjwo_vj
INNER JOIN dbp_msi_view2.mv_wg_wup_sm_zu_per AS a15
    ON
        a11.mandant_id = a15.mandant_id
        AND a11.nb_id = a15.nb_id
        AND a11.wg_id = a15.wg_id
        AND a11.wup_id = a15.wup_id
WHERE
    a15.mandant_id = 1
    AND a15.sm_id IN (1, 2, 3, 4, 5)
    AND a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
GROUP BY
    pa15.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzmd0j AS
SELECT
    a11.kjwo,
    a11.art_id,
    a11.mandant_id,
    IFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto ELSE NULL END), 0) - IFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.ek_mep_umsatz ELSE NULL END), 0) AS wjxbfs1_af,
    IFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto ELSE NULL END), 0) - IFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.ek_mep_umsatz ELSE NULL END), 0) AS wjxbfs1_sa,
    IFNULL(SUM(a11.umsatz_netto), 0) - IFNULL(SUM(a11.ek_mep_umsatz), 0) AS wjxbfs1_tot,
    IFNULL(SUM(a11.umsatz_netto), 0) AS umsatz_brutto_tot,
    IFNULL(SUM(CASE WHEN a11.bewart_id = 1001 THEN a11.umsatz_netto ELSE NULL END), 0) AS umsatz_brutto_af,
    IFNULL(SUM(CASE WHEN a11.bewart_id = 1002 THEN a11.umsatz_netto ELSE NULL END), 0) AS umsatz_brutto_sa
FROM dbp_etl.mv_artbew_wo_sum AS a11
INNER JOIN zzmq00 AS pa12
    ON a11.art_id = pa12.art_id AND a11.mandant_id = pa12.mandant_id
WHERE
    a11.wg_id IN (
        SELECT wg_id
        FROM dbp_process.bf_sort_wg
        WHERE
            mandant_id = 1
    )
    AND a11.mandant_id = 1
    AND a11.kjwo BETWEEN (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE
            kjwo IN (
                SELECT MIN(kjwo) AS a1636373476
                FROM zzmq01
            )
    ) AND (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE
            kjwo IN (
                SELECT MAX(kjwo) AS a1886115246
                FROM zzmq01
            )
    )
GROUP BY
    a11.kjwo,
    a11.art_id,
    a11.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE zzoj0k AS
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd06 AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd02 AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0a_xxx AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0c AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0f AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0g AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0d AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0h AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0i AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0j AS pa11
GROUP BY
    1,
    2,
    3
UNION DISTINCT
SELECT
    pa11.kjwo,
    pa11.art_id,
    pa11.mandant_id
FROM zzmd0e AS pa11
GROUP BY
    1,
    2,
    3;

CREATE OR REPLACE TEMPORARY TABLE _step01 AS
SELECT
    pa11.kjwo,
    a132.wg_id AS wg_id,
    a132.mandant_id AS mandant_id,
    a138.wg_bez AS wg_bez,
    CAST(a132.wg_id AS STRING) AS wg_id0,
    a132.wug_id AS wug_id,
    a132.mandant_id AS mandant_id0,
    a132.wg_id AS wug_id0,
    a136.wug_bez AS wug_bez,
    CONCAT(
        CASE
            WHEN a132.wg_id < 10
                THEN CONCAT('00', CAST(a132.wg_id AS STRING))
            WHEN a132.wg_id < 100
                THEN CONCAT('0', CAST(a132.wg_id AS STRING))
            ELSE CAST(a132.wg_id AS STRING)
        END,
        CASE
            WHEN a132.wug_id < 10
                THEN CONCAT('00', CAST(a132.wug_id AS STRING))
            WHEN a132.wug_id < 100
                THEN CONCAT('0', CAST(a132.wug_id AS STRING))
            ELSE CAST(a132.wug_id AS STRING)
        END
    ) AS custcol_58,
    a126.art_id AS art_id,
    a126.mandant_id AS mandant_id1,
    a133.art_bez AS art_bez,
    CASE
        WHEN a127.art_id < 10000000
            THEN CONCAT('00', substr(CAST(FLOOR(a127.art_id / 100) AS STRING), 1, 10))
        WHEN a127.art_id < 100000000
            THEN CONCAT('0', substr(CAST(FLOOR(a127.art_id / 100) AS STRING), 1, 10))
        ELSE substr(CAST(FLOOR(a127.art_id / 100) AS STRING), 1, 10)
    END AS custcol_52,
    a127.loesch_id AS loesch_id,
    a127.zek_id AS zek_id0,
    a127.mandant_id AS mandant_id2,
    a137.zek_lang_bez AS zek_lang_bez,
    a127.eigenmarke_id,
    a127.bio_fg,
    a127.tierwohl_kz,
    a127.vegan_fg,
    CASE WHEN a127.posten_id = 'pf' THEN 'x' ELSE ' ' END AS posten_food,
    CASE WHEN a127.posten_id = 'pn' THEN 'x' ELSE ' ' END AS posten_nonfood,
    a127.gluten_fg,
    coalesce(x.mwst, 0) AS mwst,
    a127.aldi_id AS aldi_id,
    a127.discount_id AS discount_id,
    a135.discount_bez AS discount_bez,
    a128.kolli_faktor_dz AS kolli_faktor_dz,
    CAST(round(1 / nullif(a128.kolli_faktor_dz, 0)) AS INT64) AS kolli_faktor_dz0,
    a128.koll_faktor_zl AS koll_faktor_zl,
    CAST(round(1 / nullif(a128.koll_faktor_zl, 0)) AS INT64) AS kolli_zl,
    a130.mhd_zeitraum_dz AS mhd_zeitraum_dz,
    a130.mhd_zeitraum_dz AS mhd_zeitraum_dz0,
    a127.mhd_zeitraum AS mhd_zeitraum,
    a127.mhd_zeitraum AS mhd_zeitraum0,
    a131.art_id AS art_id0,
    a131.mandant_id AS mandant_id3,
    a131.vkpk1 AS vkpk1,
    a126.akt_gp_id AS akt_gp_id,
    a134.akt_gp_name AS akt_gp_name,
    a127.lactose_fg AS lactose_fg,
    a131.art_id AS art_id1,
    a131.mandant_id AS mandant_id4,
    a131.vkpk4 AS vkpk4,
    a129.typ_ost_basis AS kreistyp_gruppe_id,
    a129.art_id AS art_id2,
    a129.typ_ost_basis AS typ_ost_basis,
    a129.typ_ost_gross AS kreistyp_gruppe_id0,
    a129.art_id AS art_id3,
    a129.typ_ost_gross AS typ_ost_gross,
    a129.typ_sued_ost AS typ_sued_ost,
    a129.art_id AS art_id4,
    a129.typ_sued_ost AS typ_sued_ost0,
    a129.typ_sued_west AS kreistyp_gruppe_id1,
    a129.art_id AS art_id5,
    a129.typ_sued_west AS typ_sued_west,
    a129.typ_west AS kreistyp_gruppe_id2,
    a129.art_id AS art_id6,
    a129.typ_west AS typ_west,
    a129.typ_nord AS kreistyp_gruppe_id3,
    a129.art_id AS art_id7,
    a129.typ_nord AS typ_nord,
    MAX(pa12.sp_ekkb_01) AS sp_ekkb_01,
    MAX(pa13.stk_ek_kb_stamm) AS stk_ek_kb_stamm,
    MAX(pa14.wjxbfs1) AS wjxbfs1,
    MAX(pa14.absatz_gesamt) AS absatz_gesamt,
    MAX(pa15.max_kjwo) AS max_kjwo,
    MAX(pa15.min_kjwo) AS min_kjwo,
    MAX(pa16.min_durchg_gelistet_sst) AS min_durchg_gelistet_sst,
    MAX(pa12.sp_ekkb_04) AS sp_ekkb_04,
    MAX(pa17.kassenumsatz_sk_1_bis_6) AS kassenumsatz_sk_1_bis_6,
    MAX(pa18.absatz_sk1) AS absatz_sk1,
    MAX(pa18.absatz_sk2) AS absatz_sk2,
    MAX(pa18.absatz_sk3) AS absatz_sk3,
    MAX(pa18.absatz_sk4) AS absatz_sk4,
    MAX(pa18.absatz_sk5) AS absatz_sk5,
    MAX(pa14.absatz_af_sk1_bis6) AS absatz_af_sk1_bis6,
    MAX(pa14.anz_wo_mit_abs_af_sk1_bis6) AS anz_wo_mit_abs_af_sk1_bis6,
    MAX(pa114.abschr_vk_o_werbung) AS abschr_vk_o_werbung,
    MAX(pa115.absatz_nord) AS absatz_nord,
    MAX(pa115.absatz_ost_basis) AS absatz_ost_basis,
    MAX(pa115.absatz_ost_gross) AS absatz_ost_gross,
    MAX(pa115.absatz_sued_ost) AS absatz_sued_ost,
    MAX(pa115.absatz_sued_west) AS absatz_sued_west,
    MAX(pa115.absatz_west) AS absatz_west,
    sum(pa201.absatz_sa_sk1_bis6) AS absatz_sa_sk1_bis6,
    sum(pa201.anz_tage_mit_abs_sa_sk1_bis6) AS anz_tage_mit_abs_sa_sk1_bis6,
    MAX(pa17.kassenumsatz_af_sk_1_bis_6) AS kassenumsatz_af_sk_1_bis_6,
    MAX(pa115.anz_wo_mit_abs_ost_basis) AS anz_wo_mit_abs_ost_basis,
    MAX(pa115.anz_wo_mit_abs_sued_west) AS anz_wo_mit_abs_sued_west,
    MAX(pa17.ek_mep_ums_sa_sk1_bis_6) AS ek_mep_ums_sa_sk1_bis_6,
    MAX(pa14.anz_wo_listung) AS anz_wo_listung,
    MAX(pa122.ek_mep_ums_sk1_bis_6_vj) AS ek_mep_ums_sk1_bis_6_vj,
    MAX(pa115.anz_wo_mit_abs_west) AS anz_wo_mit_abs_west,
    MAX(pa123.absatz_vj_sk1_bis_6) AS absatz_vj_sk1_bis_6,
    MAX(pa18.anz_wo_mit_abs_sk2) AS anz_wo_mit_abs_sk2,
    MAX(pa122.kassenumsatz_sk_1_bis_6_vj) AS kassenumsatz_sk_1_bis_6_vj,
    MAX(pa115.anz_wo_mit_abs_nord) AS anz_wo_mit_abs_nord,
    MAX(pa124.wjxbfs1_tot) AS wjxbfs2_tot,
    MAX(pa124.wjxbfs1_af) AS wjxbfs2_af,
    MAX(pa124.wjxbfs1_sa) AS wjxbfs2_sa,
    MAX(pa14.anz_wo_mit_absatz) AS anz_wo_mit_absatz, /* max(pa18.absatz_sa_sk1_bis6)  absatz_sa_sk1_bis6, */
    MAX(pa18.anz_wo_mit_abs_sk4) AS anz_wo_mit_abs_sk4,
    MAX(pa18.anz_wo_mit_abs_sk1) AS anz_wo_mit_abs_sk1,
    MAX(pa17.ek_mep_ums_sk1_bis_6) AS ek_mep_ums_sk1_bis_6,
    MAX(pa17.kassenumsatz_sa_sk_1_bis_6) AS kassenumsatz_sa_sk_1_bis_6,
    MAX(pa18.anz_wo_mit_abs_sk3) AS anz_wo_mit_abs_sk3,
    MAX(pa115.anz_wo_mit_abs_sued_ost) AS anz_wo_mit_abs_sued_ost,
    MAX(pa18.anz_wo_mit_abs_sk5) AS anz_wo_mit_abs_sk5,
    MAX(pa115.anz_wo_mit_abs_ost_gross) AS anz_wo_mit_abs_ost_gross,
    MAX(pa124.umsatz_brutto_tot) AS umsatz_brutto_tot,
    MAX(pa124.umsatz_brutto_af) AS umsatz_brutto_af,
    MAX(pa124.umsatz_brutto_sa) AS umsatz_brutto_sa,
    MAX(pa14.anz_wo_mit_abs_tot_sk1_bis6) AS anz_wo_mit_abs_tot_sk1_bis6,
    MAX(pa14.anz_maerkte) AS anz_maerkte
FROM zzoj0k AS pa11
LEFT OUTER JOIN zzmd06 AS pa12
    ON
        pa11.art_id = pa12.art_id
        AND pa11.mandant_id = pa12.mandant_id
        AND pa11.kjwo = pa12.kjwo
LEFT OUTER JOIN zzmd02 AS pa13
    ON
        pa11.art_id = pa13.art_id
        AND pa11.mandant_id = pa13.mandant_id
        AND pa11.kjwo = pa13.kjwo
LEFT OUTER JOIN zzmd0a_xxx AS pa14
    ON
        pa11.art_id = pa14.art_id
        AND pa11.mandant_id = pa14.mandant_id
        AND pa11.kjwo = pa14.kjwo
CROSS JOIN zzmd0b AS pa15
LEFT OUTER JOIN zzmd0c AS pa16
    ON
        pa11.art_id = pa16.art_id
        AND pa11.mandant_id = pa16.mandant_id
        AND pa11.kjwo = pa16.kjwo
LEFT OUTER JOIN zzmd0d AS pa17
    ON
        pa11.art_id = pa17.art_id
        AND pa11.mandant_id = pa17.mandant_id
        AND pa11.kjwo = pa17.kjwo
LEFT OUTER JOIN zzmd0e AS pa18
    ON
        pa11.art_id = pa18.art_id
        AND pa11.mandant_id = pa18.mandant_id
        AND pa11.kjwo = pa18.kjwo
LEFT OUTER JOIN zzmd0f AS pa114
    ON
        pa11.art_id = pa114.art_id
        AND pa11.mandant_id = pa114.mandant_id
        AND pa11.kjwo = pa114.kjwo
LEFT OUTER JOIN zzmd0g AS pa115
    ON
        pa11.art_id = pa115.art_id
        AND pa11.mandant_id = pa115.mandant_id
        AND pa11.kjwo = pa115.kjwo
LEFT OUTER JOIN zzmd0h AS pa122
    ON
        pa11.art_id = pa122.art_id
        AND pa11.mandant_id = pa122.mandant_id
        AND pa11.kjwo = pa122.kjwo
LEFT OUTER JOIN zzmd0i AS pa123
    ON
        pa11.art_id = pa123.art_id
        AND pa11.mandant_id = pa123.mandant_id
        AND pa11.kjwo = pa123.kjwo
LEFT OUTER JOIN zzmd0j AS pa124
    ON
        pa11.art_id = pa124.art_id
        AND pa11.mandant_id = pa124.mandant_id
        AND pa11.kjwo = pa124.kjwo
LEFT OUTER JOIN zzmdxy AS pa201
    ON
        pa11.art_id = pa201.art_id
        AND pa11.mandant_id = pa201.mandant_id
        AND pa11.kjwo = pa201.kjwo
LEFT OUTER JOIN (
    SELECT
        mv_art_gp_zu_per.mandant_id,
        mv_art_gp_zu_per.art_id,
        MAX(mv_art_gp_zu_per.gp_id) AS akt_gp_id
    FROM dbp_msi_view2.mv_art_gp_zu_per
    WHERE
        mv_art_gp_zu_per.aktuell_fg = 'a'
    GROUP BY
        1,
        2
) AS a126
    ON pa11.art_id = a126.art_id AND pa11.mandant_id = a126.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_art AS a127
    ON a126.art_id = a127.art_id AND a126.mandant_id = a127.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_kolli_faktor_dz_zl AS a128
    ON a126.art_id = a128.art_id AND a126.mandant_id = a128.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_sternchen_logik_kreistyp AS a129
    ON a126.art_id = a129.art_id AND a126.mandant_id = a129.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_art_herst_zu AS a130
    ON a126.art_id = a130.art_id AND a126.mandant_id = a130.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_art_pm_vw_akt AS a131
    ON a126.art_id = a131.art_id AND a126.mandant_id = a131.mandant_id
LEFT OUTER JOIN dbp_msi_view2.mv_art_wg_zu_per AS a132
    ON
        a127.art_id = a132.art_id
        AND a127.mandant_id = a132.mandant_id
        AND a127.art_id = a132.art_id
LEFT OUTER JOIN dbp_msi_view2.mv_art_spr_zu AS a133
    ON
        a126.art_id = a133.art_id
        AND a126.mandant_id = a133.mandant_id
        AND a127.art_id = a133.art_id
LEFT OUTER JOIN dbp_msi_view2.mv_gp_aktuell AS a134
    ON a126.akt_gp_id = a134.akt_gp_id
LEFT OUTER JOIN dbp_msi_view2.mv_artkz_discount AS a135
    ON a127.discount_id = a135.discount_id
LEFT OUTER JOIN dbp_msi_view2.mv_wug_spr_zu AS a136
    ON
        a132.mandant_id = a136.mandant_id
        AND a132.wg_id = a136.wg_id
        AND a132.wug_id = a136.wug_id
LEFT OUTER JOIN dbp_msi_view2.mv_zek AS a137
    ON a127.mandant_id = a137.mandant_id AND a127.zek_id = a137.zek_id
LEFT OUTER JOIN dbp_msi_view2.mv_wg_spr_zu AS a138
    ON a132.mandant_id = a138.mandant_id AND a132.wg_id = a138.wg_id
LEFT OUTER JOIN dbp_data.mwst_per AS x
    ON
        a132.mandant_id = x.mandant_id
        AND a127.mwst_id = x.mwst_id
        AND x.dat_bis = '9999-12-31'
GROUP BY
    1,
    8,
    7,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    round(1 / nullif(a128.kolli_faktor_dz, 0)),
    32,
    round(1 / nullif(a128.koll_faktor_zl, 0)),
    35,
    35,
    37,
    37,
    44,
    45,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    49,
    63,
    49,
    52,
    63,
    52,
    55,
    63,
    55,
    58,
    63,
    58,
    61,
    63,
    61,
    64,
    63,
    64;

DELETE FROM dbp_etl.bf_sort_sal_aggregat
WHERE
    kjwo IN (
        SELECT kjwo
        FROM zzmq01
    );

INSERT INTO dbp_etl.bf_sort_sal_aggregat
SELECT
    kjwo,
    wg_id,
    mandant_id,
    wg_bez,
    wg_id0,
    wug_id,
    mandant_id0,
    wug_id0,
    wug_bez,
    custcol_58,
    art_id,
    mandant_id1,
    art_bez,
    custcol_52,
    loesch_id,
    zek_id0,
    mandant_id2,
    zek_lang_bez,
    eigenmarke_id,
    bio_fg,
    tierwohl_kz,
    vegan_fg,
    posten_food,
    posten_nonfood,
    gluten_fg,
    mwst,
    aldi_id,
    discount_id,
    discount_bez,
    kolli_faktor_dz,
    kolli_faktor_dz0,
    koll_faktor_zl,
    kolli_zl,
    mhd_zeitraum_dz,
    mhd_zeitraum_dz0,
    mhd_zeitraum,
    mhd_zeitraum0,
    CAST(art_id0 AS INT64),
    CAST(mandant_id3 AS INT64),
    CAST(vkpk1 AS NUMERIC),
    akt_gp_id,
    akt_gp_name,
    lactose_fg,
    CAST(art_id1 AS INT64),
    CAST(mandant_id4 AS INT64),
    CAST(vkpk4 AS NUMERIC),
    kreistyp_gruppe_id,
    art_id2,
    typ_ost_basis,
    kreistyp_gruppe_id0,
    art_id3,
    typ_ost_gross,
    typ_sued_ost,
    art_id4,
    typ_sued_ost0,
    kreistyp_gruppe_id1,
    art_id5,
    typ_sued_west,
    kreistyp_gruppe_id2,
    art_id6,
    typ_west,
    kreistyp_gruppe_id3,
    art_id7,
    typ_nord,
    CAST(sp_ekkb_01 AS NUMERIC),
    stk_ek_kb_stamm,
    wjxbfs1,
    absatz_gesamt,
    max_kjwo,
    min_kjwo,
    min_durchg_gelistet_sst,
    CAST(sp_ekkb_04 AS NUMERIC),
    kassenumsatz_sk_1_bis_6,
    absatz_sk1,
    absatz_sk2,
    absatz_sk3,
    absatz_sk4,
    absatz_sk5,
    absatz_af_sk1_bis6,
    anz_wo_mit_abs_af_sk1_bis6,
    abschr_vk_o_werbung,
    absatz_nord,
    absatz_ost_basis,
    absatz_ost_gross,
    absatz_sued_ost,
    absatz_sued_west,
    absatz_west,
    absatz_sa_sk1_bis6,
    anz_tage_mit_abs_sa_sk1_bis6,
    kassenumsatz_af_sk_1_bis_6,
    anz_wo_mit_abs_ost_basis,
    anz_wo_mit_abs_sued_west,
    ek_mep_ums_sa_sk1_bis_6,
    anz_wo_listung,
    ek_mep_ums_sk1_bis_6_vj,
    anz_wo_mit_abs_west,
    absatz_vj_sk1_bis_6,
    anz_wo_mit_abs_sk2,
    kassenumsatz_sk_1_bis_6_vj,
    anz_wo_mit_abs_nord,
    wjxbfs2_tot,
    wjxbfs2_af,
    wjxbfs2_sa,
    anz_wo_mit_absatz,
    anz_wo_mit_abs_sk4,
    anz_wo_mit_abs_sk1,
    ek_mep_ums_sk1_bis_6,
    kassenumsatz_sa_sk_1_bis_6,
    anz_wo_mit_abs_sk3,
    anz_wo_mit_abs_sued_ost,
    anz_wo_mit_abs_sk5,
    anz_wo_mit_abs_ost_gross,
    umsatz_brutto_tot,
    umsatz_brutto_af,
    umsatz_brutto_sa,
    anz_wo_mit_abs_tot_sk1_bis6,
    anz_maerkte
FROM `_step01`
WHERE
    `_step01`.kjwo IN (
        SELECT kjwo
        FROM zzmq01
    );

TRUNCATE TABLE dbp_etl.bf_sort_sal_export;

INSERT INTO dbp_etl.bf_sort_sal_export
(
    SELECT
        b.kjmo_sort AS monat,
        b.monate_anz AS anz_monate,
        a.wg_id,
        a.wug_id,
        a.custcol_52 AS art_nr,
        a.art_bez,
        a.loesch_id AS art_status,
        CAST(a.akt_gp_id AS STRING) || ':' || a.akt_gp_name AS akt_lieferant,
        a.zek_id0 AS zek,
        a.eigenmarke_id AS eigenmarke,
        a.bio_fg AS bio,
        a.tierwohl_kz AS tierwohl,
        a.vegan_fg AS vegan,
        a.posten_food,
        a.posten_nonfood,
        a.gluten_fg AS gluten,
        a.mwst,
        a.aldi_id AS disc_pe,
        a.discount_id AS disc_marke,
        a.lactose_fg AS lcf,
        COALESCE(CAST(a.min_durchg_gelistet_sst AS STRING), 'N/A') AS k_listung,
        a.typ_ost_basis AS ost_basis,
        a.typ_ost_gross AS ost_gross,
        a.typ_sued_ost AS sued_ost,
        a.typ_sued_west AS sued_west,
        a.typ_west AS west,
        a.typ_nord AS nord,
        a.kolli_faktor_dz0 AS kol_bst,
        a.kolli_zl AS kol_la,
        a.mhd_zeitraum_dz AS rlz_dz,
        a.mhd_zeitraum AS rlz,
        SUM(a.absatz_sk1) AS k1_absatz,
        IF(SUM(a.anz_wo_mit_abs_sk1) = 0, NULL, SUM(a.anz_wo_mit_abs_sk1)) AS k1_markt_wochen,
        SUM(a.absatz_sk1) / IF(SUM(a.anz_wo_mit_abs_sk1) = 0, NULL, SUM(a.anz_wo_mit_abs_sk1)) AS k1_absatz_mt_wo,
        SUM(a.absatz_sk2) AS k2_absatz,
        IF(SUM(a.anz_wo_mit_abs_sk2) = 0, NULL, SUM(a.anz_wo_mit_abs_sk2)) AS k2_markt_wochen,
        SUM(a.absatz_sk2) / IF(SUM(a.anz_wo_mit_abs_sk2) = 0, NULL, SUM(a.anz_wo_mit_abs_sk2)) AS k2_absatz_mt_wo,
        SUM(a.absatz_sk3) AS k3_absatz,
        IF(SUM(a.anz_wo_mit_abs_sk3) = 0, NULL, SUM(a.anz_wo_mit_abs_sk3)) AS k3_markt_wochen,
        SUM(a.absatz_sk3) / IF(SUM(a.anz_wo_mit_abs_sk3) = 0, NULL, SUM(a.anz_wo_mit_abs_sk3)) AS k3_absatz_mt_wo,
        SUM(a.absatz_sk4) AS k4_absatz,
        IF(SUM(a.anz_wo_mit_abs_sk4) = 0, NULL, SUM(a.anz_wo_mit_abs_sk4)) AS k4_markt_wochen,
        SUM(a.absatz_sk4) / IF(SUM(a.anz_wo_mit_abs_sk4) = 0, NULL, SUM(a.anz_wo_mit_abs_sk4)) AS k4_absatz_mt_wo,
        SUM(a.absatz_sk5) AS k5_absatz,
        IF(SUM(a.anz_wo_mit_abs_sk5) = 0, NULL, SUM(a.anz_wo_mit_abs_sk5)) AS k5_markt_wochen,
        SUM(a.absatz_sk5) / IF(SUM(a.anz_wo_mit_abs_sk5) = 0, NULL, SUM(a.anz_wo_mit_abs_sk5)) AS k5_absatz_mt_wo,
        SUM(a.absatz_ost_basis) AS ost_basis_absatz,
        IF(SUM(a.anz_wo_mit_abs_ost_basis) = 0, NULL, SUM(a.anz_wo_mit_abs_ost_basis)) AS ost_basis_markt_wochen,
        SUM(a.absatz_ost_basis) / IF(SUM(a.anz_wo_mit_abs_ost_basis) = 0, NULL, SUM(a.anz_wo_mit_abs_ost_basis)) AS ost_basis_absatz_mt_wo,
        SUM(a.absatz_ost_gross) AS ost_gross_absatz,
        IF(SUM(a.anz_wo_mit_abs_ost_gross) = 0, NULL, SUM(a.anz_wo_mit_abs_ost_gross)) AS ost_gross_markt_wochen,
        SUM(a.absatz_ost_gross) / IF(SUM(a.anz_wo_mit_abs_ost_gross) = 0, NULL, SUM(a.anz_wo_mit_abs_ost_gross)) AS ost_gross_absatz_mt_wo,
        SUM(a.absatz_sued_ost) AS sued_ost_absatz,
        IF(SUM(a.anz_wo_mit_abs_sued_ost) = 0, NULL, SUM(a.anz_wo_mit_abs_sued_ost)) AS sued_ost_markt_wochen,
        SUM(a.absatz_sued_ost) / IF(SUM(a.anz_wo_mit_abs_sued_ost) = 0, NULL, SUM(a.anz_wo_mit_abs_sued_ost)) AS sued_ost_absatz_mt_wo,
        SUM(a.absatz_sued_west) AS sued_west_absatz,
        IF(SUM(a.anz_wo_mit_abs_sued_west) = 0, NULL, SUM(a.anz_wo_mit_abs_sued_west)) AS sued_west_markt_wochen,
        SUM(a.absatz_sued_west) / IF(SUM(a.anz_wo_mit_abs_sued_west) = 0, NULL, SUM(a.anz_wo_mit_abs_sued_west)) AS sued_west_absatz_mt_wo,
        SUM(a.absatz_west) AS west_absatz,
        IF(SUM(a.anz_wo_mit_abs_west) = 0, NULL, SUM(a.anz_wo_mit_abs_west)) AS west_markt_wochen,
        SUM(a.absatz_west) / IF(SUM(a.anz_wo_mit_abs_west) = 0, NULL, SUM(a.anz_wo_mit_abs_west)) AS west_absatz_mt_wo,
        SUM(a.absatz_nord) AS nord_absatz,
        IF(SUM(a.anz_wo_mit_abs_nord) = 0, NULL, SUM(a.anz_wo_mit_abs_nord)) AS nord_markt_wochen,
        SUM(a.absatz_nord) / IF(SUM(a.anz_wo_mit_abs_nord) = 0, NULL, SUM(a.anz_wo_mit_abs_nord)) AS nord_absatz_mt_wo,
        SUM(a.absatz_gesamt) AS total_absatz,
        SUM(a.absatz_gesamt) / IF(SUM(a.anz_wo_mit_abs_tot_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_tot_sk1_bis6)) AS total_absatz_mt_wo,
        ROUND(
            (
                SUM(a.absatz_gesamt) / IF(SUM(a.absatz_vj_sk1_bis_6) = 0, NULL, SUM(a.absatz_vj_sk1_bis_6)) - 1
            ) * 100,
            1
        ) AS stg_absatz_vj,
        ROUND(
            SUM(a.anz_wo_mit_absatz) / IF(SUM(a.anz_wo_listung) = 0, NULL, SUM(a.anz_wo_listung)) * 100,
            1
        ) AS schnelldreherquote,
        ROUND(
            SUM(a.absatz_sa_sk1_bis6) / IF(SUM(a.absatz_gesamt) = 0, NULL, SUM(a.absatz_gesamt)) * 100,
            1
        ) AS aktion_absatz,
        SUM(a.kassenumsatz_sk_1_bis_6) AS kassenumsatz,
        SUM(a.wjxbfs2_tot) / IF(SUM(a.absatz_gesamt) = 0, NULL, SUM(a.absatz_gesamt)) AS stueck_re_mep,
        SUM(a.wjxbfs2_tot) AS total_re_mep,
        ROUND(
            (
                SUM(a.wjxbfs2_tot) / IF(
                    SUM(a.kassenumsatz_sk_1_bis_6_vj - a.ek_mep_ums_sk1_bis_6_vj) = 0,
                    NULL,
                    SUM(a.kassenumsatz_sk_1_bis_6_vj - a.ek_mep_ums_sk1_bis_6_vj)
                ) - 1
            ) * 100,
            1
        ) AS stg_re_mep_vj,
        ROUND(
            SUM(a.wjxbfs2_tot) / IF(SUM(a.kassenumsatz_sk_1_bis_6) = 0, NULL, SUM(a.kassenumsatz_sk_1_bis_6)) * 100,
            1
        ) AS avg_spanne_mep,
        ROUND(
            SUM(a.wjxbfs2_af) / IF(SUM(a.kassenumsatz_af_sk_1_bis_6) = 0, NULL, SUM(a.kassenumsatz_af_sk_1_bis_6)) * 100,
            1
        ) AS avg_spanne_af_mep,
        ROUND(
            SUM(a.kassenumsatz_sa_sk_1_bis_6 - a.ek_mep_ums_sa_sk1_bis_6) / IF(SUM(a.kassenumsatz_sa_sk_1_bis_6) = 0, NULL, SUM(a.kassenumsatz_sa_sk_1_bis_6)) * 100,
            1
        ) AS avg_spanne_sa_mep,
        ROUND(SUM(a.abschr_vk_o_werbung), 1) AS abschr_o_werb,
        ROUND(
            SUM(a.abschr_vk_o_werbung) / IF(SUM(a.kassenumsatz_sk_1_bis_6) = 0, NULL, SUM(a.kassenumsatz_sk_1_bis_6)) * 100,
            1
        ) AS abschr_o_werb_umsatz,
        CAST(ROUND(AVG(a.stk_ek_kb_stamm), 2) AS FLOAT64) AS kb,
        CAST(ROUND(AVG(a.vkpk1), 2) AS FLOAT64) AS vk_pk_1,
        CAST(ROUND(AVG(a.vkpk4), 2) AS FLOAT64) AS vk_pk_4,
        CAST(ROUND(AVG(a.sp_ekkb_01) * 100, 1) AS FLOAT64) AS sp_kb_pk_1,
        CAST(ROUND(AVG(a.sp_ekkb_04) * 100, 1) AS FLOAT64) AS sp_kb_pk_4,
        SUM(a.absatz_af_sk1_bis6) AS total_af_absatz,
        IF(SUM(a.anz_wo_mit_abs_af_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS absatz_af_markt_wochen,
        SUM(a.absatz_af_sk1_bis6) / IF(SUM(a.anz_wo_mit_abs_af_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS total_absatz_af_mt_wo,
        SUM(a.absatz_sa_sk1_bis6) AS total_sa_absatz,
        IF(SUM(a.anz_tage_mit_abs_sa_sk1_bis6) = 0, NULL, SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS absatz_sa_markt_tage,
        SUM(a.absatz_sa_sk1_bis6) / IF(SUM(a.anz_tage_mit_abs_sa_sk1_bis6) = 0, NULL, SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS total_absatz_sa_mt_tag,
        SUM(a.wjxbfs2_af) / IF(SUM(a.absatz_af_sk1_bis6) = 0, NULL, SUM(a.absatz_af_sk1_bis6)) AS stueck_re_mep_af,
        SUM(a.wjxbfs2_sa) / IF(SUM(a.absatz_sa_sk1_bis6) = 0, NULL, SUM(a.absatz_sa_sk1_bis6)) AS stueck_re_mep_sa,
        SUM(a.wjxbfs2_af) AS af_re_mep,
        SUM(a.wjxbfs2_sa) AS sa_re_mep,
        SUM(a.umsatz_brutto_tot) AS total_umsatz_netto,
        SUM(a.umsatz_brutto_tot) / IF(SUM(a.anz_wo_mit_abs_tot_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_tot_sk1_bis6)) AS total_umsatz_netto_mt_wo,
        SUM(a.umsatz_brutto_af) AS af_umsatz_netto,
        SUM(a.umsatz_brutto_af) / IF(SUM(a.anz_wo_mit_abs_af_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS af_umsatz_netto_mt_wo,
        SUM(a.umsatz_brutto_sa) AS sa_umsatz_netto,
        SUM(a.umsatz_brutto_sa) / IF(SUM(a.anz_tage_mit_abs_sa_sk1_bis6) = 0, NULL, SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS sa_umsatz_netto_mt_tag,
        SUM(a.wjxbfs2_tot) / IF(SUM(a.anz_wo_mit_abs_af_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS total_re_mep_mt_wo,
        SUM(a.wjxbfs2_af) / IF(SUM(a.anz_wo_mit_abs_af_sk1_bis6) = 0, NULL, SUM(a.anz_wo_mit_abs_af_sk1_bis6)) AS af_re_mep_mt_wo,
        SUM(a.wjxbfs2_sa) / IF(SUM(a.anz_tage_mit_abs_sa_sk1_bis6) = 0, NULL, SUM(a.anz_tage_mit_abs_sa_sk1_bis6)) AS sa_re_mep_mt_tag,
        SUM(0) AS anz_maerkte,
        CAST(SUM(a.anz_wo_mit_absatz) AS INT64) AS anz_wo_mit_absatz,
        CAST(IF(SUM(a.anz_wo_listung) = 0, NULL, SUM(a.anz_wo_listung)) AS INT64) AS anz_wo_listung,
        CAST(ROUND(
            CAST(CASE
                WHEN
                    SUBSTR(
                        GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                        1,
                        1
                    ) = ' '
                    OR SUBSTR(
                        GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                        1,
                        1
                    ) = '*'
                    THEN '0'
                ELSE SUBSTR(
                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                    1,
                    1
                )
            END AS BIGNUMERIC),
            0
        ) AS INT64) AS sl,
        MAX(
            CASE
                WHEN
                    ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (4, 8)
                    THEN a.kolli_zl
                WHEN
                    ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (1, 5)
                    THEN NULL
                WHEN
                    NOT ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (1, 4, 5, 8)
                    THEN CASE
                        WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz = 0
                            THEN a.kolli_zl
                        WHEN a.mhd_zeitraum = 0 AND a.mhd_zeitraum_dz <> 0
                            THEN NULL
                        WHEN
                            a.mhd_zeitraum <> 0
                            AND a.mhd_zeitraum_dz <> 0
                            OR a.mhd_zeitraum = 0
                            AND a.mhd_zeitraum_dz = 0
                            THEN a.kolli_zl
                        ELSE NULL
                    END
                ELSE NULL
            END
        ) AS kol_la_bzw,
        MAX(
            CASE
                WHEN
                    ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (4, 8)
                    THEN NULL
                WHEN
                    ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (1, 5)
                    THEN a.kolli_faktor_dz0
                WHEN
                    NOT ROUND(
                        CAST(CASE
                            WHEN
                                SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = ' '
                                OR SUBSTR(
                                    GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                    1,
                                    1
                                ) = '*'
                                THEN '0'
                            ELSE SUBSTR(
                                GREATEST(a.typ_ost_basis, a.typ_ost_gross, a.typ_sued_ost, a.typ_sued_west, a.typ_west, a.typ_nord),
                                1,
                                1
                            )
                        END AS BIGNUMERIC),
                        0
                    ) IN (1, 4, 5, 8)
                    THEN CASE
                        WHEN a.mhd_zeitraum <> 0 AND a.mhd_zeitraum_dz = 0
                            THEN NULL
                        WHEN a.mhd_zeitraum = 0 AND a.mhd_zeitraum_dz <> 0
                            THEN a.kolli_faktor_dz0
                        ELSE NULL
                    END
                ELSE NULL
            END
        ) AS kol_bst_bzw,
        MAX(CAST(c.lager_prozent AS NUMERIC) / 100) AS lagerprozent,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.bf_sort_sal_aggregat AS a
    INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS b
        ON a.kjwo BETWEEN b.kjwo_von AND b.kjwo_bis
    INNER JOIN dbp_data.art AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.art_id = c.art_id
            AND c.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        b.kjmo_sort IN (
            SELECT kjmo_sort
            FROM zzmq01
        )
        AND NOT ROUND(SAFE_CAST(a.custcol_52 AS BIGNUMERIC), 0) IS NULL
    GROUP BY
        monat,
        anz_monate,
        a.wg_id,
        a.wug_id,
        art_nr,
        a.art_bez,
        art_status,
        akt_lieferant,
        zek,
        eigenmarke,
        bio,
        tierwohl,
        vegan,
        a.posten_food,
        a.posten_nonfood,
        gluten,
        a.mwst,
        disc_pe,
        disc_marke,
        lcf,
        k_listung,
        ost_basis,
        ost_gross,
        sued_ost,
        sued_west,
        west,
        nord,
        kol_bst,
        kol_la,
        rlz_dz,
        rlz
);

UPDATE dbp_etl.bf_sort_sal_export SET anz_listung_as_is = 0
WHERE
    TRUE;

UPDATE dbp_etl.bf_sort_sal_export SET anz_listung_as_is = b.anz_listung_as_is
FROM (
    SELECT
        CAST(FLOOR(a.art_id / 100) AS INT64) AS kl_art_id,
        SUM(a.listung_id) AS anz_listung_as_is
    FROM dbp_data.art_wup_zu_per AS a
    INNER JOIN dbp_data.wup AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN b.dat_von AND b.dat_bis
    INNER JOIN dbp_data.art_wg_zu_per AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.art_id = c.art_id
            AND c.arthiertyp_id = 2
            AND c.dat_bis = CAST('9999-12-31' AS DATE)
    WHERE
        a.mandant_id = 1
        AND a.listung_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    GROUP BY
        kl_art_id
) AS b
WHERE
    ROUND(CAST(bf_sort_sal_export.art_nr AS BIGNUMERIC), 0) = b.kl_art_id;

UPDATE dbp_etl.bf_sort_sal_export AS bf_sort_sal_export0 SET anz_maerkte = b.anz_maerkte
FROM (
    SELECT
        kl_art_id,
        COUNT(DISTINCT wup_id) AS anz_maerkte
    FROM (
        SELECT
            CAST(FLOOR(a.art_id / 100) AS INT64) AS kl_art_id,
            a.wup_id,
            SUM(a.menge) AS menge
        FROM dbp_data.artbew AS a
        INNER JOIN dbp_msi_data.ek_sort_sortiment_mat_zeitraum AS c
            ON a.dat BETWEEN c.dat_von AND c.dat_bis
        INNER JOIN dbp_data.art_wg_zu_per AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND b.arthiertyp_id = 2
                AND b.dat_bis = CAST('9999-12-31' AS DATE)
        WHERE
            a.mandant_id = 1
            AND c.kjmo_sort IN (
                SELECT monat
                FROM dbp_etl.bf_sort_sal_export
            )
        GROUP BY
            kl_art_id,
            a.wup_id
        HAVING
            menge > 0
    ) AS x
    GROUP BY
        kl_art_id
) AS b
WHERE
    ROUND(CAST(bf_sort_sal_export0.art_nr AS BIGNUMERIC), 0) = b.kl_art_id;
