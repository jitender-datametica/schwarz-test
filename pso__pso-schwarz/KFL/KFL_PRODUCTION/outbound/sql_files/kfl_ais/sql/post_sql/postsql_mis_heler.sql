DELETE FROM dbp_data.artbew_wg_sum
WHERE
    mandant_id = 2
    AND wg_id = -99
    AND bewart_id = 1005
    AND dat IN (SELECT DISTINCT
        PARSE_DATE(
            '%Y%m%d', doc_date) AS
        a880809152
    FROM dbp_etl.mis_heler
    WHERE loc_currcy = 'CZK');


--translated statement


-- ,COALESCE(m.bus_area, substring(m.alloc_nmbr, 1, 4), '0') AS wup_id
-- EVT2342668
INSERT INTO
dbp_data.artbew_wg_sum (
    mandant_id, nb_id, arthiertyp_id, wg_id, umrechnungskurs_hist, dat, wup_id,
    bewart_id,
    kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
)
(
    SELECT
        mandant_id,
        nb_id,
        mandant_id AS arthiertyp_id,
        wg_id,
        umrechnungskurs,
        doc_date2,
        CAST(wup_id AS INTEGER) AS wup_id,
        bewart_id,
        kjmo,
        CAST(umsatz_brutto AS NUMERIC) AS umsatz_brutto,
        CAST(umsatz_brutto AS NUMERIC) AS umsatz_netto,
        umsatz_wrg,
        CAST(umsatz_brutto_konz AS NUMERIC) AS umsatz_brutto_konz,
        CAST(umsatz_brutto_konz AS NUMERIC) AS umsatz_netto_konz,
        quelle,
        nb_id AS menge
    FROM (
        SELECT
            2 AS mandant_id,
            COALESCE(NULLIF(M.bus_area, ''), SUBSTR(M.alloc_nmbr, 1, 4), '0')
                AS wup_id,
            -99 AS wg_id,
            1005 AS bewart_id,
            PARSE_DATE('%Y%m%d', M.doc_date) AS doc_date2,
            0 AS nb_id,
            2 AS arthiertyp_id,
            M.loc_currcy AS umsatz_wrg,
            T.kjmo,
            0 AS menge,
            1 AS quelle,
            SUM(CASE
                WHEN M.dcindic = 'H'
                    THEN M.deb_cre_lc
                ELSE M.deb_cre_lc * -1
            END) AS umsatz_brutto,
            SUM(CASE
                WHEN M.dcindic = 'H'
                    THEN M.deb_cre_lc
                ELSE M.deb_cre_lc * -1
            END) AS umsatz_netto,
            SUM(CASE
                WHEN M.dcindic = 'H'
                    THEN M.deb_cre_lc * K.umrechnungskurs
                ELSE M.deb_cre_lc * K.umrechnungskurs * -1
            END) AS umsatz_brutto_konz,
            SUM(CASE
                WHEN M.dcindic = 'H'
                    THEN M.deb_cre_lc * K.umrechnungskurs
                ELSE M.deb_cre_lc * K.umrechnungskurs * -1
            END) AS umsatz_netto_konz,
            MAX(X.umrechnungskurs) as umrechnungskurs
        FROM dbp_etl.mis_heler AS M
        INNER JOIN dbp_data.kurs AS K
            ON
                M.loc_currcy = K.von_wrg_id
                AND K.nach_wrg_id = 'EUR'
                AND K.dat_bis
                = PARSE_DATE('%F', '9999-12-31') AND K.kurstyp_id = 3
        INNER JOIN dbp_data.kurs AS X
            ON
                M.loc_currcy = X.von_wrg_id
                AND X.nach_wrg_id = 'EUR'
                AND PARSE_DATE(
                    '%Y%m%d',
                    M.doc_date
                ) BETWEEN X.dat_von AND X.dat_bis AND X.kurstyp_id = 3
        INNER JOIN
            dbp_data.tag AS T
            ON PARSE_DATE('%Y%m%d', M.doc_date) = T.dat
        GROUP BY
            mandant_id,
            wup_id,
            wg_id,
            bewart_id,
            doc_date2,
            nb_id,
            arthiertyp_id,
            umsatz_wrg,
            T.kjmo,
            menge,
            quelle
    ) AS t2
    WHERE
        t2.umsatz_wrg = 'CZK'
        AND ABS(t2.umsatz_brutto) < 10000
);


-- ,COALESCE(mis_heler.bus_area, substring(mis_heler.alloc_nmbr, 1, 4), '0') AS wup_id
-- EVT2342668

-- 2 für Helerrundung
INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt (
    mandant_id, wup_id, nb_id, dat,
    calc_fg, dat_lief
)
(
    SELECT
        2 AS mandant_id,
        CAST(
            COALESCE(
                NULLIF(bus_area, ''), SUBSTR(alloc_nmbr, 1, 4), '0'
            ) AS INTEGER
        ) AS wup_id,
        0 AS nb_id,
        PARSE_DATE('%Y%m%d', doc_date) AS dat,
        2 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.mis_heler AS M
    WHERE loc_currcy = 'CZK'
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);
