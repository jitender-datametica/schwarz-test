--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.d_tanktresor_help_kunden_2;


INSERT INTO dbp_etl.d_tanktresor_help_kunden_2 (
    marktnummer, wg_text, schluessel2, wert, datum
)
(SELECT
    marktnummer,
    wg_text,
    schluessel2,
    wert,
    datum
FROM dbp_etl.d_tanktresor_help_2
WHERE SUBSTR(schluessel2, 1, 6) = 'KUNDEN');


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.d_tanktresor_help_2
WHERE SUBSTR(schluessel2, 1, 6) = 'KUNDEN';


DELETE FROM dbp_data.artbew_wg_sum_2
WHERE (mandant_id, CAST(wup_id AS BIGNUMERIC), nb_id, dat) IN (
    SELECT (
        1, ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0),
        W.nb_id, PARSE_DATE('%d-%m-%Y', DTH.datum)
    )
    FROM dbp_etl.d_tanktresor_help_2 AS DTH
    INNER JOIN
        dbp_data.wup_2
            AS W
        ON
            ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0) = W.wup_id
            AND W.mandant_id
            = 1 AND W.nb_id = 7
) AND quelle = 2;


-- , to_date(datum, 'DD-MM_2-YYYY') / 100 + 190000 AS kjmo
INSERT INTO dbp_data.artbew_wg_sum_2 (
    mandant_id,
    nb_id,
    arthiertyp_id,
    wg_id,
    dat,
    wup_id,
    bewart_id,
    kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(
    SELECT
        1 AS mandant_id,
        W.nb_id,
        2 AS arthiertyp_id,
        -1 AS wg_id,
        PARSE_DATE('%d-%m-%Y', DTH.datum) AS dat,
        CAST(ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0) AS INTEGER)
            AS wup_id,
        1001 AS bewart_id,
        CAST(
            ROUND(
                CAST(
                    REPLACE(
                        '' || CAST(PARSE_DATE('%d-%m-%Y', DTH.datum) AS STRING),
                        '-',
                        ''
                    ) AS BIGNUMERIC
                ),
                0
            )
            / 100 
         AS INTEGER) AS kjmo,
        SUM(ROUND(CAST(CASE
            WHEN DTH.schluessel2 = 'UMSBRU_GESAMT'
                THEN DTH.wert
            ELSE NULL
        END AS NUMERIC), 2)) AS umsatz_brutto,
        SUM(ROUND(CAST(CASE
            WHEN DTH.schluessel2 = 'UMSNET'
                THEN DTH.wert
            ELSE NULL
        END AS NUMERIC), 2)) AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        SUM(ROUND(CAST(CASE
            WHEN DTH.schluessel2 = 'UMSBRU_GESAMT'
                THEN DTH.wert
            ELSE NULL
        END AS NUMERIC), 2)) AS umsatz_brutto_konz,
        SUM(ROUND(CAST(CASE
            WHEN DTH.schluessel2 = 'UMSNET'
                THEN DTH.wert
            ELSE NULL
        END AS NUMERIC), 2)) AS umsatz_netto_konz,
        1,
        SUM(ROUND(CAST(CASE
            WHEN DTH.schluessel2 = 'LITER_GESAMT'
                THEN DTH.wert
            ELSE NULL
        END AS NUMERIC), 3)) AS menge
    FROM dbp_etl.d_tanktresor_help_2 AS DTH
    INNER JOIN dbp_data.wup_2 AS W
        ON
            ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0) = W.wup_id
            AND W.mandant_id
            = 1 AND W.nb_id = 7
    WHERE
        (
            1,
            ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0),
            -1,
            PARSE_DATE('%d-%m-%Y', DTH.datum),
            W.nb_id
        ) NOT IN (
            SELECT (mandant_id, CAST(wup_id AS BIGNUMERIC), wg_id, dat, nb_id)
            FROM dbp_data.artbew_wg_sum_2
        )
    GROUP BY
        mandant_id,
        wup_id,
        wg_id,
        bewart_id,
        dat,
        W.nb_id,
        arthiertyp_id,
        kjmo
);


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew_wg_sum = 1,
    td_update = CURRENT_TIMESTAMP()
WHERE (mandant_id, CAST(wup_id AS BIGNUMERIC), nb_id, dat) IN (SELECT (
    1, ROUND(CAST(marktnummer AS BIGNUMERIC), 0), 7,
    PARSE_DATE('%d-%m-%Y', datum)
)
FROM dbp_etl.d_tanktresor_help_2);


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_2 (
    mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief
)
(
    SELECT
        1 AS mandant_id,
        CAST(ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0) AS INTEGER)
            AS wup_id,
        W.nb_id,
        PARSE_DATE('%d-%m-%Y', DTH.datum) AS dat,
        0 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.d_tanktresor_help_2 AS DTH
    INNER JOIN dbp_data.wup_2 AS W
        ON
            ROUND(CAST(DTH.marktnummer AS BIGNUMERIC), 0) = W.wup_id
            AND W.mandant_id
            = 1 AND W.nb_id = 7
    GROUP BY
        mandant_id,
        wup_id,
        W.nb_id,
        dat,
        calc_fg,
        dat_lief
);


DELETE FROM dbp_data.vis_tag_tks_sorte_2
WHERE
    (
        mandant_id,
        CAST(wup_id AS BIGNUMERIC),
        nb_id,
        dat,
        tks_sorte_id,
        tks_sorte_bez
    ) IN (SELECT (
        mandant_id, wup_id,
        nb_id, dat, tks_sorte_id, tks_sorte_bez
    )
    FROM (SELECT
        1 AS mandant_id,
        7 AS nb_id,
        ROUND(CAST(marktnummer AS BIGNUMERIC), 0) AS wup_id,
        PARSE_DATE('%d-%m-%Y', datum) AS dat,
        TRIM(wg_text) AS txt,
        CASE
            WHEN TRIM(wg_text) LIKE '%.DIESEL.DIESEL%'
                THEN 10
            WHEN TRIM(wg_text) LIKE '%.DIESEL.BIODIESEL%'
                THEN 11
            WHEN TRIM(wg_text) LIKE '%.NORMAL%'
                THEN 20
            WHEN TRIM(wg_text) LIKE '%.SUPBL%'
                THEN 30
            WHEN TRIM(wg_text) LIKE '%.SUPPL%'
                THEN 31
            WHEN TRIM(wg_text) LIKE '%.SUPE10%'
                THEN 32
            WHEN TRIM(wg_text) LIKE '%.MIX%'
                THEN 40
            WHEN TRIM(wg_text) LIKE '%.SONDER.OEL%'
                THEN 50
            WHEN TRIM(wg_text) LIKE '%.SONDER.WASCHEN%'
                THEN 60
            ELSE -1
        END AS tks_sorte_id,
        CASE
            WHEN TRIM(wg_text) LIKE '%.DIESEL.DIESEL%'
                THEN 'Diesel'
            WHEN TRIM(wg_text) LIKE '%.DIESEL.BIODIESEL%'
                THEN 'Biodiesel'
            WHEN TRIM(wg_text) LIKE '%.NORMAL%'
                THEN 'Normal'
            WHEN TRIM(wg_text) LIKE '%.SUPBL%'
                THEN 'Super Bleifrei'
            WHEN TRIM(wg_text) LIKE '%.SUPPL%'
                THEN 'Super Plus'
            WHEN TRIM(wg_text) LIKE '%.SUPE10%'
                THEN 'Super E10'
            WHEN TRIM(wg_text) LIKE '%.MIX%'
                THEN 'Mix'
            WHEN TRIM(wg_text) LIKE '%.SONDER.OEL%'
                THEN 'Öl'
            WHEN TRIM(wg_text) LIKE '%.SONDER.WASCHEN%'
                THEN 'Waschen'
            ELSE '-1'
        END AS tks_sorte_bez
    FROM dbp_etl.d_tanktresor_help_2 AS V01) AS sub
    WHERE tks_sorte_id > 0
    GROUP BY mandant_id,
    nb_id,
    wup_id,
    dat,
    tks_sorte_id,
    tks_sorte_bez);


--[not OK] statement is not translated correctly-----------------------------------------------------------------


/* (STRING(40)) */ -- sorte_bez generierenen
-- betraege auf spalten verteilen
-- sorte_id generierenen

/* (INTEGER) */ INSERT INTO dbp_data.vis_tag_tks_sorte_2 (
    mandant_id, wup_id, nb_id, dat, tks_sorte_id,
    tks_sorte_bez, ums_netto, ums_brutto, menge_liter, anz_kunde, wrg_id
)
(
    SELECT
        mandant_id,
        CAST(wup_id AS INTEGER) AS wup_id,
        nb_id,
        dat,
        tks_sorte_id,
        tks_sorte_bez,
        SUM(tks_ums_netto) AS ums_netto,
        SUM(tks_ums_netto) + SUM(tks_ums_mwst) AS ums_brutto,
        SUM(tks_liter) AS menge_liter,
        CAST(SUM(tks_kunden) AS INTEGER) AS anz_kunden,
        'EUR' AS wrg_id
    FROM (SELECT
        1 AS mandant_id,
        7 AS nb_id,
        ROUND(CAST(marktnummer AS BIGNUMERIC), 0) AS wup_id,
        PARSE_DATE('%d-%m-%Y', datum) AS dat,
        ROUND(CAST(wert AS NUMERIC), 2) AS betrag,
        TRIM(wg_text) AS txt,
        CASE
            WHEN SUBSTR(TRIM(wg_text), 1, 16) = 'UMSATZ_TKS_NETTO'
                THEN ROUND(CAST(wert AS NUMERIC), 2)
            ELSE 0
        END AS tks_ums_netto,
        CASE
            WHEN SUBSTR(TRIM(wg_text), 1, 15) = 'UMSATZ_TKS_MWST'
                THEN ROUND(CAST(wert AS NUMERIC), 2)
            ELSE 0
        END AS tks_ums_mwst,
        CASE
            WHEN SUBSTR(TRIM(wg_text), 1, 16) = 'UMSATZ_TKS_LITER'
                THEN ROUND(CAST(wert AS NUMERIC), 2)
            ELSE 0
        END AS tks_liter,
        CASE
            WHEN SUBSTR(TRIM(wg_text), 1, 10) = 'KUNDEN_TKS'
                THEN ROUND(CAST(wert AS NUMERIC), 2)
            ELSE 0
        END AS tks_kunden,
        CASE
            WHEN TRIM(wg_text) LIKE '%.DIESEL.DIESEL%'
                THEN 10
            WHEN TRIM(wg_text) LIKE '%.DIESEL.BIODIESEL%'
                THEN 11
            WHEN TRIM(wg_text) LIKE '%.NORMAL%'
                THEN 20
            WHEN TRIM(wg_text) LIKE '%.SUPBL%'
                THEN 30
            WHEN TRIM(wg_text) LIKE '%.SUPPL%'
                THEN 31
            WHEN TRIM(wg_text) LIKE '%.SUPE10%'
                THEN 32
            WHEN TRIM(wg_text) LIKE '%.MIX%'
                THEN 40
            WHEN TRIM(wg_text) LIKE '%.SONDER.OEL%'
                THEN 50
            WHEN TRIM(wg_text) LIKE '%.SONDER.WASCHEN%'
                THEN 60
            ELSE -1
        END AS tks_sorte_id,
        CASE
            WHEN TRIM(wg_text) LIKE '%.DIESEL.DIESEL%'
                THEN 'Diesel'
            WHEN TRIM(wg_text) LIKE '%.DIESEL.BIODIESEL%'
                THEN 'Biodiesel'
            WHEN TRIM(wg_text) LIKE '%.NORMAL%'
                THEN 'Normal'
            WHEN TRIM(wg_text) LIKE '%.SUPBL%'
                THEN 'Super Bleifrei'
            WHEN TRIM(wg_text) LIKE '%.SUPPL%'
                THEN 'Super Plus'
            WHEN TRIM(wg_text) LIKE '%.SUPE10%'
                THEN 'Super E10'
            WHEN TRIM(wg_text) LIKE '%.MIX%'
                THEN 'Mix'
            WHEN TRIM(wg_text) LIKE '%.SONDER.OEL%'
                THEN 'Öl'
            WHEN TRIM(wg_text) LIKE '%.SONDER.WASCHEN%'
                THEN 'Waschen'
            ELSE '-1'
        END AS tks_sorte_bez
    FROM dbp_etl.d_tanktresor_help_2 AS V01) AS sub
    WHERE tks_sorte_id > 0
    GROUP BY
        mandant_id,
        nb_id,
        wup_id,
        dat,
        tks_sorte_id,
        tks_sorte_bez
);


UPDATE dbp_data.wupcal_2 SET
    bonanzahl = CAST(ums_dt.`_kundenzahl` AS INTEGER),
    datenlieferung_bonanzahl = 1,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        K.marktnummer AS `_wup_id`,
        7 AS `_nb_id`,
        PARSE_DATE('%d-%m-%Y', K.datum) AS `_dat`,
        SUM(
            ROUND(
                CAST(CAST(K.wert AS FLOAT64) * W.kundenfaktor AS BIGNUMERIC), 0
            )
        ) AS `_kundenzahl`
    FROM dbp_etl.d_tanktresor_help_kunden_2 AS K
    INNER JOIN dbp_data.wup_2 AS W
        ON
            K.marktnummer = CAST(W.wup_id AS STRING) AND W.mandant_id = 1 AND 7
            = W.nb_id
    WHERE K.schluessel2 = 'KUNDEN_GESAMT'
    GROUP BY
        `_wup_id`,
        `_nb_id`,
        `_dat`
) AS ums_dt
WHERE
    CAST(wupcal.wup_id AS STRING) = ums_dt.`_wup_id`
    AND wupcal.nb_id = ums_dt.`_nb_id`
    AND wupcal.dat = ums_dt.`_dat`
    AND wupcal.mandant_id = 1 AND wupcal.bonanzahl <> ums_dt.`_kundenzahl`;
