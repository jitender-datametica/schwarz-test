--EXECUTE IMMEDIATE CONVERTED BLOCK - START
BEGIN
    if (exists (
        select *
        from dbp_etl.INFORMATION_SCHEMA.COLUMNS
        where
            table_name = 'AS_FOOD_TMP'
            and table_schema = 'DBP_ETL'
            and column_name = 'WRG_ID'
    )) then
        alter table if exists dbp_etl.AS_FOOD_TMP drop column wrg_id;
    end if;
END;

--EXECUTE IMMEDIATE CONVERTED BLOCK - END

/* check ( (erl_fg >=  0 ) and  (erl_fg <=  1 ) ) */ CREATE OR REPLACE TABLE dbp_etl.as_food_tmp_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_auslistung DATE NOT NULL,
    gp_id INTEGER DEFAULT -1 NOT NULL,
    phase_status INTEGER DEFAULT -1 NOT NULL,
    erl_fg INTEGER DEFAULT 0 NOT NULL,
    dat_final DATE,
    menge_startbestand NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    vk_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    phase_id INTEGER,
    kjwo INTEGER,
    weeks INTEGER,
    alweek INTEGER,
    week01 INTEGER,
    week02 INTEGER,
    week03 INTEGER,
    week04 INTEGER,
    week05 INTEGER,
    vknorm NUMERIC(29, 2),
    vkpr01 NUMERIC(29, 2),
    vkpr02 NUMERIC(29, 2),
    vkpr03 NUMERIC(29, 2),
    vkpr04 NUMERIC(29, 2),
    vkpr05 NUMERIC(29, 2),
    aedat DATE,
    erl_kz STRING(1) COLLATE 'und:ci' DEFAULT '' NOT NULL,
    td_insert TIMESTAMP,
    wrg_id STRING(3) COLLATE 'und:ci'
);


-- kopfdaten


/* check ( (erl_fg >=  0 ) and  (erl_fg <=  1 ) ) */ CREATE OR REPLACE TABLE dbp_etl.as_food_final (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_auslistung DATE NOT NULL,
    gp_id INTEGER DEFAULT -1 NOT NULL,
    phase_status INTEGER DEFAULT -1 NOT NULL,
    erl_fg INTEGER DEFAULT 0 NOT NULL,
    dat_final DATE,
    menge_startbestand NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    vk_netto NUMERIC(29, 4) DEFAULT 0.0000 NOT NULL,
    menge_endbestand NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    erl_kz STRING(1) COLLATE 'und:ci' DEFAULT '' NOT NULL,
    dat_aend DATE,
    wrg_id STRING(3)
);


-- positionen


CREATE OR REPLACE TABLE dbp_etl.as_food_det_final_tmp (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_auslistung DATE NOT NULL,
    phase_id INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    phase_wo INTEGER NOT NULL,
    phase_vk_brutto NUMERIC(29, 2) DEFAULT 0.00 NOT NULL,
    phase_vk_netto NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_abschrift_22 INTEGER DEFAULT 0 NOT NULL,
    abschriftbetrag_netto_22 NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_abschrift_122 INTEGER DEFAULT 0 NOT NULL,
    abschriftbetrag_netto_122 NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    diff_wert_bestand_netto NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_berechnet NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    menge_endbestand_phase NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    menge NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.000 NOT NULL,
    mwst_id INTEGER NOT NULL,
    wtag_phasenbeginn INTEGER,
    wrg_id STRING(3) COLLATE 'und:ci'
);


CREATE OR REPLACE TABLE dbp_etl.as_food_det_final (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_auslistung DATE NOT NULL,
    phase_id INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    phase_wo INTEGER NOT NULL,
    phase_vk_brutto NUMERIC(29, 2) DEFAULT 0.00 NOT NULL,
    phase_vk_netto NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_abschrift_22 INTEGER DEFAULT 0 NOT NULL,
    abschriftbetrag_netto_22 NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_abschrift_122 INTEGER DEFAULT 0 NOT NULL,
    abschriftbetrag_netto_122 NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    diff_wert_bestand_netto NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    menge_berechnet NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    menge_endbestand_phase NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    menge NUMERIC(29, 3) DEFAULT 0.000 NOT NULL,
    umsatz_netto NUMERIC(29, 4) DEFAULT 0.000 NOT NULL,
    mwst_id INTEGER NOT NULL,
    wtag_phasenbeginn INTEGER,
    dat_von DATE,
    dat_bis DATE,
    wrg_id STRING(3) COLLATE 'und:ci',
    dat_final DATE,
    erl_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
    as_final_status_id INTEGER,
    betrag_ek_nettonetto NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    betrag_ek_mep NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    betrag_einstandspreis NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    betrag_logkostenzuschlag NUMERIC(29, 4) DEFAULT 0.00 NOT NULL,
    betrag_ek_mep_vor_fwu NUMERIC(29, 4) DEFAULT 0.00 NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.as_food_det_tmp (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    wtag_phasenbeginn INTEGER,
    dat_von DATE,
    dat_bis DATE
);


/*
#------------------------------------------------------------------------------
# 2.) Einfuegen der Deltadaten in temporaere Tabelle.
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.as_food_tmp_2
(
    SELECT
        TMP.art_id,
        TMP.mandant_id,
        TMP.nb_id,
        TMP.wup_id,
        TMP.dat_auslistung,
        TMP.gp_id,
        TMP.phase_status,
        TMP.erl_fg,
        TMP.dat_final,
        TMP.menge_startbestand,
        TMP.vk_netto,
        TMP.phase_id,
        TMP.kjwo_kl,
        TMP.weeks,
        TMP.alweek,
        TMP.week01,
        TMP.week02,
        TMP.week03,
        TMP.week04,
        TMP.week05,
        TMP.vknorm,
        TMP.vkpr01,
        TMP.vkpr02,
        TMP.vkpr03,
        TMP.vkpr04,
        TMP.vkpr05,
        TMP.aedat,
        TMP.erl_kz,
        TMP.td_insert,
        B.default_wrg AS wrg_id
    FROM dbp_etl.as_food_tmp AS TMP
    INNER JOIN dbp_data.mandant AS B ON TMP.mandant_id = B.mandant_id
);


-- 09.01.2018, -dbay-
--
-- Filter nach ungueltig gepflegten Saetzen aufgrund eines Abbruchs.


DELETE FROM dbp_etl.as_food_tmp_2
WHERE week01 IS NULL;


/*
#------------------------------------------------------------------------------
# 3.) Befuellung der temporaeren Kopftabelle.
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TEMPORARY TABLE _distinkte_kombis AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    dat_auslistung,
    dat_final,
    erl_kz,
    aedat AS dat_aend
FROM dbp_etl.as_food_tmp_2
GROUP BY
    mandant_id,
    wup_id,
    art_id,
    dat_auslistung,
    dat_final,
    erl_kz,
    dat_aend;


-- (quantity_start_stock) based on marktbestand_erp from dat_auslistung

-- (net_sales_price) based on marktbestand_erp_zu from from dat_auslistung
INSERT INTO dbp_etl.as_food_final

(
    SELECT
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        A.gp_id,
        A.phase_status,
        A.erl_fg,
        A.dat_final,
        COALESCE(b.menge_lgbest_erp_frei_bme, 0) AS menge_startbestand,
        COALESCE(C.vk_netto, 0) AS vk_netto,
        COALESCE(d.menge_lgbest_erp_frei_bme, e.menge_lgbest_erp_frei_bme, 0) AS menge_endbestand,
        -- (quantity_end_stock) based on marktbestand_erp from dat_final-1 or aedat-1
        A.erl_kz,
        A.aedat AS dat_aend,
        C.wrg_id
    FROM dbp_etl.as_food_tmp_2 AS A
    LEFT JOIN (
        SELECT *
        FROM dbp_data.marktbestand_erp
        WHERE (
            mandant_id, dat, wup_id, art_id) IN (SELECT (mandant_id, dat_auslistung, wup_id, art_id)
        FROM `_distinkte_kombis`)
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat_auslistung = b.dat AND A.art_id = b.art_id
    LEFT JOIN dbp_data.marktbestand_erp_zu AS C ON b.bestand_id = C.bestand_id AND b.mandant_id = C.mandant_id

    LEFT JOIN (
        SELECT *
        FROM dbp_data.marktbestand_erp
        WHERE (
            mandant_id, dat, wup_id, art_id) IN (SELECT (mandant_id, DATE_SUB(dat_final, INTERVAL 1 DAY), wup_id, art_id)
        FROM `_distinkte_kombis`
        WHERE dat_final IS NOT NULL)
    ) AS d
        ON
            A.mandant_id = d.mandant_id AND A.wup_id = d.wup_id AND A.nb_id = d.nb_id
            AND DATE_SUB(A.dat_final, INTERVAL 1 DAY) = d.dat AND A.art_id = d.art_id
    LEFT JOIN (
        SELECT *
        FROM dbp_data.marktbestand_erp
        WHERE (
            mandant_id, dat, wup_id, art_id) IN (
            SELECT (mandant_id, DATE_SUB(dat_aend, INTERVAL 1 DAY), wup_id, art_id)
            FROM `_distinkte_kombis`
            WHERE
                dat_aend IS NOT NULL
                AND erl_kz = 'X'
        )
    ) AS e
        ON A.mandant_id = e.mandant_id AND A.wup_id = e.wup_id AND A.nb_id = e.nb_id AND DATE_SUB(
            A.aedat, INTERVAL 1 DAY
        ) = e.dat AND A.art_id = e.art_id
);


/*
#------------------------------------------------------------------------------
# 4.) Abgeschlossene und abgebrochene Vorgaenge protokollieren.
#------------------------------------------------------------------------------
*/

-- abgebrochene ohne dat_final


CREATE OR REPLACE TEMPORARY TABLE _test1 AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_auslistung,
    A.alweek,
    MIN(COALESCE(A.week01, A.week02, A.week03, A.week04, A.week05)) AS min_woche,
    MAX(B.kjwo) AS max_woche
FROM dbp_etl.as_food_tmp_2 AS A
INNER JOIN dbp_data.tag AS B ON A.aedat = B.dat
WHERE
    A.erl_fg = 1
    AND -- with stock and dat_final=null, max_woche is calculated based on (aedat)
    A.dat_final IS NULL
GROUP BY
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_auslistung,
    A.alweek;


INSERT INTO `_test1` (mandant_id, art_id, wup_id, nb_id, dat_auslistung, alweek, min_woche, max_woche)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat_auslistung,
        A.alweek,
        MIN(COALESCE(A.week01, A.week02, A.week03, A.week04, A.week05)) AS min_woche,
        MAX(D.kjwo) AS max_woche
    FROM dbp_etl.as_food_tmp_2 AS A
    INNER JOIN dbp_data.tag AS B ON DATE_SUB(A.dat_final, INTERVAL 1 DAY) = B.dat
    INNER JOIN dbp_data.tag AS C ON B.akt_wo = C.akt_wo
    INNER JOIN dbp_data.tag AS D ON D.akt_wo BETWEEN C.akt_wo AND (C.akt_wo + 3)
    WHERE
        A.erl_fg = 1
        AND -- with stock and dat_final=not null, max_woche is calculated based on (dat_final-1)
        A.dat_final IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat_auslistung,
        A.alweek
);


-- abgebrochene mit dat_final


INSERT INTO `_test1` (mandant_id, art_id, wup_id, nb_id, dat_auslistung, alweek, min_woche, max_woche)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat_auslistung,
        A.alweek,
        MIN(COALESCE(A.week01, A.week02, A.week03, A.week04, A.week05)) AS min_woche,
        MAX(D.kjwo) AS max_woche
    FROM dbp_etl.as_food_tmp_2 AS A
    INNER JOIN dbp_data.tag AS B ON DATE_SUB(A.dat_final, INTERVAL 1 DAY) = B.dat
    INNER JOIN dbp_data.tag AS C ON B.akt_wo = C.akt_wo
    INNER JOIN dbp_data.tag AS D ON D.akt_wo BETWEEN C.akt_wo AND (C.akt_wo + 3)
    WHERE
        A.dat_final IS NOT NULL
        AND A.erl_fg = 0 -- without stock but with dat_final, max_woche is calculated based on (dat_final-1)

    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat_auslistung,
        A.alweek
);


/*
#------------------------------------------------------------------------------
# 5.) Offene Vorgaenge protokollieren.
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TEMPORARY TABLE _test2 AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_auslistung,
    alweek,
    MIN(COALESCE(week01, week02, week03, week04, week05)) AS min_woche,
    MAX(COALESCE(week05, week04, week03, week02, week01)) AS max_woche
FROM dbp_etl.as_food_tmp_2
WHERE
    erl_fg = 0
    AND -- without stock and without dat_final, max_woche is calculated based on (week05,week04,week03,week02,week01)

    dat_final IS NULL
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_auslistung,
    alweek;


/*
#------------------------------------------------------------------------------
# 6.) Befuellung der temporaeren Positionstabelle.
#------------------------------------------------------------------------------
*/

-- abgebrochene und abgeschlossene


INSERT INTO dbp_etl.as_food_det_final_tmp
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        CASE
            WHEN b.kjwo < A.week01
                THEN 0
            WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                THEN 1
            WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                THEN 2
            WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                THEN 3
            WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                THEN 4
            WHEN b.kjwo >= A.week05
                THEN 5
            ELSE NULL
        END AS phase_id_,
        D.kjwo,
        CASE
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 0
                THEN A.alweek
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 1
                THEN A.week01
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 2
                THEN A.week02
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 3
                THEN A.week03
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 4
                THEN A.week04
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 5
                THEN A.week05
            ELSE NULL
        END AS phase_wo,
        CAST(CASE
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 0
                THEN A.vknorm
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 1
                THEN A.vkpr01
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 2
                THEN A.vkpr02
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 3
                THEN A.vkpr03
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 4
                THEN A.vkpr04
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 5
                THEN A.vkpr05
            ELSE NULL
        END AS NUMERIC) AS phase_vk_brutto,
        0 AS phase_vk_netto,
        0 AS menge_abschrift_22,
        0 AS abschriftbetrag_netto_22,
        0 AS menge_abschrift_122,
        0 AS abschriftbetrag_netto_122,
        0 AS diff_wert_bestand_netto,
        0 AS menge_berechnet,
        0 AS menge_endbestand_phase,
        0 AS menge,
        0 AS umsatz_netto,
        E.mwst_id,
        CAST(NULL AS INTEGER) AS wtag_phasenbeginn,
        A.wrg_id
    FROM dbp_etl.as_food_tmp_2 AS A
    INNER JOIN (
        SELECT
            B.kjwo,
            A0.mandant_id,
            A0.art_id,
            A0.wup_id,
            A0.nb_id,
            A0.dat_auslistung,
            A0.alweek,
            A0.min_woche,
            A0.max_woche
        FROM `_test1` AS A0
        INNER JOIN dbp_data.woche AS B ON B.kjwo BETWEEN A0.alweek AND A0.max_woche
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat_auslistung = b.dat_auslistung

    INNER JOIN dbp_data.woche AS C ON b.kjwo = C.kjwo
    INNER JOIN dbp_data.woche AS D ON C.akt_wo + 1 = D.akt_wo
    INNER JOIN dbp_data.art AS E ON A.mandant_id = E.mandant_id AND A.art_id = E.art_id
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        phase_id_,
        D.kjwo,
        phase_wo,
        phase_vk_brutto,
        phase_vk_netto,
        menge_abschrift_22,
        abschriftbetrag_netto_22,
        menge_abschrift_122,
        abschriftbetrag_netto_122,
        diff_wert_bestand_netto,
        menge_berechnet,
        menge_endbestand_phase,
        menge,
        umsatz_netto,
        E.mwst_id,
        A.wrg_id
);


-- offene


INSERT INTO dbp_etl.as_food_det_final_tmp
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        CASE
            WHEN b.kjwo < A.week01
                THEN 0
            WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                THEN 1
            WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                THEN 2
            WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                THEN 3
            WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                THEN 4
            WHEN b.kjwo >= A.week05
                THEN 5
            ELSE NULL
        END AS phase_id_,
        D.kjwo,
        CASE
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 0
                THEN A.alweek
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 1
                THEN A.week01
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 2
                THEN A.week02
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 3
                THEN A.week03
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 4
                THEN A.week04
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 5
                THEN A.week05
            ELSE NULL
        END AS phase_wo,
        CAST(CASE
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 0
                THEN A.vknorm
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 1
                THEN A.vkpr01
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 2
                THEN A.vkpr02
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 3
                THEN A.vkpr03
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 4
                THEN A.vkpr04
            WHEN
                CASE
                    WHEN b.kjwo < A.week01
                        THEN 0
                    WHEN b.kjwo >= A.week01 AND b.kjwo < COALESCE(A.week02, 999999)
                        THEN 1
                    WHEN b.kjwo >= A.week02 AND b.kjwo < COALESCE(A.week03, 999999)
                        THEN 2
                    WHEN b.kjwo >= A.week03 AND b.kjwo < COALESCE(A.week04, 999999)
                        THEN 3
                    WHEN b.kjwo >= A.week04 AND b.kjwo < COALESCE(A.week05, 999999)
                        THEN 4
                    WHEN b.kjwo >= A.week05
                        THEN 5
                    ELSE NULL
                END = 5
                THEN A.vkpr05
            ELSE NULL
        END AS NUMERIC) AS phase_vk_brutto,
        0 AS phase_vk_netto,
        0 AS menge_abschrift_22,
        0 AS abschriftbetrag_netto_22,
        0 AS menge_abschrift_122,
        0 AS abschriftbetrag_netto_122,
        0 AS diff_wert_bestand_netto,
        0 AS menge_berechnet,
        0 AS menge_endbestand_phase,
        0 AS menge,
        0 AS umsatz_netto,
        E.mwst_id,
        CAST(NULL AS INTEGER) AS wtag_phasenbeginn,
        A.wrg_id
    FROM dbp_etl.as_food_tmp_2 AS A
    INNER JOIN (SELECT
        B.kjwo,
        A0.mandant_id,
        A0.art_id,
        A0.wup_id,
        A0.nb_id,
        A0.dat_auslistung,
        A0.alweek,
        A0.min_woche,
        A0.max_woche
    FROM `_test2` AS A0
    INNER JOIN (
        dbp_data.woche AS B LEFT JOIN (
            SELECT
                A1.kjwo -- display current_week
                    AS `A11860`
            FROM dbp_data.woche AS A1
            INNER JOIN (
                SELECT wtag_id
                FROM dbp_data.tag
                WHERE dat = CURRENT_DATE("Europe/Berlin")
            ) AS b
                ON TRUE
            WHERE
                A1.akt_wo = CASE
                    WHEN b.wtag_id = 1
                        THEN 1
                    ELSE 0
                END
        ) AS t3 ON TRUE
    ) ON B.kjwo BETWEEN A0.alweek AND t3.`A11860`) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id
            = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat_auslistung = b.dat_auslistung
    INNER JOIN dbp_data.woche AS C ON b.kjwo = C.kjwo
    INNER JOIN dbp_data.woche AS D ON C.akt_wo + 1 = D.akt_wo
    INNER JOIN dbp_data.art AS E ON A.mandant_id = E.mandant_id AND A.art_id = E.art_id
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        phase_id_,
        D.kjwo,
        phase_wo,
        phase_vk_brutto,
        phase_vk_netto,
        menge_abschrift_22,
        abschriftbetrag_netto_22,
        menge_abschrift_122,
        abschriftbetrag_netto_122,
        diff_wert_bestand_netto,
        menge_berechnet,
        menge_endbestand_phase,
        menge,
        umsatz_netto,
        E.mwst_id,
        A.wrg_id
);


-- add wtag_phasenbeginn


CREATE OR REPLACE TEMPORARY TABLE _tag AS
-- take only weeks
SELECT
    TT.kjwo,
    TT.wtag_id,
    TT.dat AS dat_von,
    DATE_ADD(TT.dat, INTERVAL 6 DAY) AS dat_bis
FROM (
    SELECT kjwo
    FROM dbp_data.tag
    GROUP BY kjwo
) AS t
INNER JOIN dbp_data.tag AS TT ON t.kjwo = TT.kjwo;


-- there were less rows in test due to not found correspondence on art_wg_zu_per, hence left join here !!!
INSERT INTO
dbp_etl.as_food_det_tmp
(
    SELECT
        af.art_id,
        af.mandant_id,
        af.kjwo,
        COALESCE(P.wtag_phasenbeginn, 1) AS wtag_phasenbeginn,
        CASE
            WHEN P.wtag_phasenbeginn = 7
                THEN DATE_SUB(T.dat_von, INTERVAL 7 DAY)
            ELSE T.dat_von
        END,
        CASE
            WHEN P.wtag_phasenbeginn = 7
                THEN DATE_SUB(T.dat_bis, INTERVAL 7 DAY)
            ELSE T.dat_bis
        END
    FROM (
        SELECT
            mandant_id,
            art_id,
            kjwo
        FROM dbp_etl.as_food_det_final_tmp
        GROUP BY
            art_id,
            mandant_id,
            kjwo
    ) AS af
    INNER JOIN dbp_data.art AS A ON af.mandant_id = A.mandant_id AND af.art_id = A.art_id
    LEFT JOIN dbp_data.art_wg_zu_per AS AWZ
        ON
            A.mandant_id = AWZ.mandant_id AND A.art_id = AWZ.art_id AND
            AWZ.arthiertyp_id = 2 AND AWZ.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN dbp_data.as_phasen AS P
        ON
            A.mandant_id = P.mandant_id AND A.posten_kz_sap = P.posten_kz_sap
            AND AWZ.wg_id = P.wg_id
    INNER JOIN `_tag` AS T ON af.kjwo = T.kjwo AND COALESCE(P.wtag_phasenbeginn, 1) = T.wtag_id
    GROUP BY
        af.art_id,
        af.mandant_id,
        af.kjwo,
        wtag_phasenbeginn,
        CASE
            WHEN P.wtag_phasenbeginn = 7
                THEN DATE_SUB(T.dat_von, INTERVAL 7 DAY)
            ELSE T.dat_von
        END,
        CASE
            WHEN P.wtag_phasenbeginn = 7
                THEN DATE_SUB(T.dat_bis, INTERVAL 7 DAY)
            ELSE T.dat_bis
        END
);


INSERT INTO dbp_etl.as_food_det_final
(
    SELECT
        M.art_id,
        M.mandant_id,
        M.nb_id,
        M.wup_id,
        M.dat_auslistung,
        M.phase_id,
        M.kjwo,
        M.phase_wo,
        M.phase_vk_brutto,
        M.phase_vk_netto,
        M.menge_abschrift_22,
        M.abschriftbetrag_netto_22,
        M.menge_abschrift_122,
        M.abschriftbetrag_netto_122,
        M.diff_wert_bestand_netto,
        M.menge_berechnet,
        M.menge_endbestand_phase,
        M.menge,
        M.umsatz_netto,
        M.mwst_id,
        T.wtag_phasenbeginn,
        T.dat_von,
        T.dat_bis,
        M.wrg_id,
        CAST(NULL AS DATE) AS dat_final,
        ' ' AS erl_kz,
        0 AS as_final_status_id,
        0 AS betrag_ek_nettonetto,
        0 AS betrag_ek_mep,
        0 AS betrag_einstandspreis,
        0 AS betrag_logkostenzuschlag,
        0 AS betrag_ek_mep_vor_fwu
    FROM dbp_etl.as_food_det_final_tmp AS M
    INNER JOIN
        dbp_etl.as_food_det_tmp
            AS T
        ON
            M.mandant_id = T.mandant_id AND M.art_id = T.art_id AND M.kjwo
            = T.kjwo
);


UPDATE dbp_etl.as_food_det_final SET
    phase_vk_netto = as_food_det_final.phase_vk_brutto / (dt1.mwst_ / 100 + 1) FROM (SELECT
    mandant_id AS mandant_id_,
    mwst_id AS mwst_id_,
    dat_von AS dat_von_,
    mwst AS mwst_,
    dat_bis AS dat_bis_
FROM dbp_data.mwst_per) AS dt1
WHERE
    as_food_det_final.dat_auslistung BETWEEN dt1.dat_von_ AND dt1.dat_bis_ AND as_food_det_final.mwst_id = dt1.mwst_id_
    AND as_food_det_final.mandant_id = dt1.mandant_id_;


UPDATE dbp_etl.as_food_det_final AS as_food_det_final0 SET
    menge_endbestand_phase = b.menge_endbestand FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        a.wup_id,
        a.dat_auslistung,
        a.phase_id,
        a.max_kjwo,
        COALESCE(D.menge_lgbest_erp_frei_bme, 0) AS menge_endbestand
    FROM (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            dat_auslistung,
            phase_id,
            wtag_phasenbeginn,
            MAX(kjwo) AS max_kjwo
        FROM dbp_etl.as_food_det_final
        GROUP BY
            art_id,
            mandant_id,
            wup_id,
            dat_auslistung,
            phase_id,
            wtag_phasenbeginn
    ) AS a
    INNER JOIN dbp_etl.as_food_det_final AS B
        ON
            a.mandant_id = B.mandant_id AND a.art_id = B.art_id AND a.wup_id = B.wup_id AND a.dat_auslistung = B.dat_auslistung AND a.phase_id = B.phase_id AND a.max_kjwo = B.kjwo
            AND a.wtag_phasenbeginn = B.wtag_phasenbeginn
    LEFT JOIN
        dbp_data.marktbestand_erp
            AS D
        ON
            a.mandant_id = D.mandant_id AND a.wup_id = D.wup_id AND a.art_id = D.art_id AND B.dat_bis = D.dat
) AS b
WHERE
    as_food_det_final0.mandant_id = b.mandant_id AND as_food_det_final0.kjwo = b.max_kjwo AND as_food_det_final0.dat_auslistung
    = b.dat_auslistung AND as_food_det_final0.wup_id = b.wup_id AND as_food_det_final0.art_id = b.art_id AND
    as_food_det_final0.phase_id = b.phase_id;


UPDATE dbp_etl.as_food_det_final SET
    menge = COALESCE(b.menge, 0),
    umsatz_netto = COALESCE(b.umsatz_netto, 0),
    wrg_id = b.wrg,
    betrag_ek_nettonetto = COALESCE(b.ek_nettonetto, 0),
    betrag_ek_mep = COALESCE(b.ek_mep, 0),
    betrag_einstandspreis = COALESCE(b.einstandspreis, 0),
    betrag_logkostenzuschlag = COALESCE(b.logkostenzuschlag, 0),
    betrag_ek_mep_vor_fwu = COALESCE(b.ek_mep_vor_fwu, 0) FROM (
    SELECT
        A.mandant_id,
        A.kjwo,
        A.art_id,
        A.wup_id,
        A.nb_id,
        D.wrg,
        SUM(D.menge) AS menge,
        SUM(D.umsatz_netto) AS umsatz_netto,
        SUM(D.ek_nettonetto) AS ek_nettonetto,
        SUM(D.ek_mep) AS ek_mep,
        SUM(D.einstandspreis) AS einstandspreis,
        SUM(D.logkostenzuschlag) AS logkostenzuschlag,
        SUM(D.ek_mep_vor_fwu) AS ek_mep_vor_fwu
    FROM dbp_etl.as_food_det_final AS A
    INNER JOIN dbp_data.artbew AS D
        ON
            A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND A.wup_id =
            D.wup_id AND A.nb_id = D.nb_id AND D.dat BETWEEN A.dat_von AND A.dat_bis
    GROUP BY
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.kjwo,
        D.wrg
) AS b
WHERE
    as_food_det_final.mandant_id = b.mandant_id AND as_food_det_final.kjwo = b.kjwo AND as_food_det_final.wup_id = b.wup_id
    AND as_food_det_final.nb_id = b.nb_id AND as_food_det_final.art_id = b.art_id;


CREATE OR REPLACE TEMPORARY TABLE _markets AS
SELECT
    wtag_phasenbeginn,
    dat_von,
    dat_bis,
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id
FROM dbp_etl.as_food_det_final
GROUP BY
    wtag_phasenbeginn,
    dat_von,
    dat_bis,
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id;


CREATE OR REPLACE TEMPORARY TABLE _abschriften AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    D.wrg_id,
    SUM(CASE
        WHEN D.abschriftart_id = 22
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_22,
    SUM(CASE
        WHEN D.abschriftart_id = 22
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_22,
    SUM(CASE
        WHEN D.abschriftart_id IN (23, 122)
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_122,
    SUM(CASE
        WHEN D.abschriftart_id IN (23, 122)
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_122
FROM `_markets` AS A
INNER JOIN dbp_data.marktabschriften AS D
    ON
        A.wup_id = D.wup_id AND A.mandant_id = D.mandant_id AND A.nb_id
        = D.nb_id AND A.art_id = D.art_id AND -- d.dat  between a.dat_von and a.dat_bis -- take whole week
        A.kjwo = D.woche_id

WHERE
    D.mandant_id = 1
    AND D.abschriftart_id IN (22, 23, 122)
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    D.wrg_id;


UPDATE dbp_etl.as_food_det_final SET
    menge_abschrift_22 = CAST(b.menge_abschrift_22 AS INTEGER),
    abschriftbetrag_netto_22 = CAST(b.abschriftbetrag_netto_22 AS NUMERIC),
    menge_abschrift_122 = CAST(b.menge_abschrift_122 AS INTEGER),
    abschriftbetrag_netto_122 = CAST(b.abschriftbetrag_netto_122 AS NUMERIC),
    wrg_id = b.wrg_id
FROM `_abschriften` AS b
WHERE
    as_food_det_final.mandant_id = b.mandant_id AND as_food_det_final.wup_id = b.wup_id AND as_food_det_final.nb_id =
    b.nb_id AND as_food_det_final.art_id = b.art_id AND as_food_det_final.kjwo = b.kjwo;


----new abschriften fuer kmo ----


CREATE OR REPLACE TABLE dbp_etl.`_markets_kmo` AS
SELECT
    wtag_phasenbeginn,
    dat_von,
    dat_bis,
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung
FROM dbp_etl.as_food_det_final
WHERE mandant_id <> 1
GROUP BY
    wtag_phasenbeginn,
    dat_von,
    dat_bis,
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften` AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_122,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_122
FROM dbp_etl.`_markets_kmo` AS A
INNER JOIN dbp_data.marktabschriften AS D
    ON
        A.wup_id = D.wup_id AND A.mandant_id = D.mandant_id AND A.nb_id
        = D.nb_id AND A.art_id = D.art_id AND -- d.dat  between a.dat_von and a.dat_bis
        A.kjwo = D.woche_id
WHERE
    D.mandant_id <> 1
    AND D.abschriftart_id = 953
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_max_kjwo` AS
SELECT
    MAX(kjwo) AS kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung
FROM dbp_etl.`_markets_kmo` AS A
GROUP BY
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_max_pjwo1` AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    MAX(B.pjwo) AS pjwo
FROM dbp_etl.`_kmoabschriften_max_kjwo` AS A
INNER JOIN dbp_data.tag AS B ON A.kjwo = B.kjwo
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_max_pjwo2` AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    MAX(B.pjwo) AS pjwo
FROM dbp_etl.`_kmoabschriften_max_pjwo1` AS A
INNER JOIN dbp_data.tag AS B ON A.pjwo = B.kjwo
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_kjwo1` AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_122,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_122
FROM dbp_data.marktabschriften AS D
INNER JOIN dbp_etl.`_kmoabschriften_max_pjwo1` AS A
    ON
        D.wup_id = A.wup_id AND D.mandant_id = A.mandant_id
        AND D.nb_id = A.nb_id AND D.art_id = A.art_id AND D.woche_id = A.pjwo
WHERE D.abschriftart_id = 953
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_kjwo2` AS
SELECT
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_122,
    SUM(CASE
        WHEN D.abschriftart_id = 953
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_122
FROM dbp_data.marktabschriften AS D
INNER JOIN dbp_etl.`_kmoabschriften_max_pjwo2` AS A
    ON
        D.wup_id = A.wup_id AND D.mandant_id = A.mandant_id
        AND D.nb_id = A.nb_id AND D.art_id = A.art_id AND D.woche_id = A.pjwo
WHERE D.abschriftart_id = 953
GROUP BY
    A.kjwo,
    A.mandant_id,
    A.wup_id,
    A.nb_id,
    A.art_id,
    A.dat_auslistung,
    D.wrg_id;


CREATE OR REPLACE TABLE dbp_etl.`_kmoabschriften_final` AS
SELECT
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung,
    wrg_id,
    SUM(menge_abschrift_122) AS menge_abschrift_122,
    SUM(abschriftbetrag_netto_122) AS abschriftbetrag_netto_122
FROM (
    SELECT *
    FROM dbp_etl.`_kmoabschriften`
    UNION ALL
    SELECT *
    FROM dbp_etl.`_kmoabschriften_kjwo1`
    UNION ALL
    SELECT *
    FROM dbp_etl.`_kmoabschriften_kjwo2`
) AS t
GROUP BY
    kjwo,
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_auslistung,
    wrg_id;


-- new logic - update for data where dat_aulistung>='2022-03-07'


UPDATE dbp_etl.as_food_det_final SET
    menge_abschrift_122 = CAST(b.menge_abschrift_122 AS INTEGER),
    abschriftbetrag_netto_122 = CAST(b.abschriftbetrag_netto_122 AS NUMERIC),
    wrg_id = b.wrg_id
FROM dbp_etl.`_kmoabschriften_final` AS b
WHERE
    as_food_det_final.mandant_id = b.mandant_id AND as_food_det_final.wup_id = b.wup_id AND as_food_det_final.nb_id =
    b.nb_id AND as_food_det_final.art_id = b.art_id AND as_food_det_final.kjwo = b.kjwo AND as_food_det_final.dat_auslistung
    = b.dat_auslistung AND as_food_det_final.dat_auslistung >= DATE '2022-03-07';


-- old logic - update for data where dat_aulistung<'2022-03-07'


UPDATE dbp_etl.as_food_det_final AS as_food_det_final0 SET
    menge_abschrift_122 = CASE
        WHEN b.abschriftbetrag_netto_122 <> 0
            THEN 1
        ELSE 0
    END,
    abschriftbetrag_netto_122 = CAST(b.abschriftbetrag_netto_122 AS NUMERIC),
    wrg_id = b.wrg_id FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat_auslistung,
        b.kjwo,
        b.wrg_id,
        A.menge_endbestand * b.phase_vk_netto * -1 AS abschriftbetrag_netto_122
    FROM dbp_etl.as_food_final AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            nb_id,
            dat_auslistung,
            wrg_id,
            MAX(CASE
                WHEN phase_id = 0
                    THEN phase_vk_netto
                ELSE 0
            END) AS phase_vk_netto,
            MAX(kjwo) AS kjwo
        FROM dbp_etl.as_food_det_final
        WHERE mandant_id > 1
        GROUP BY
            mandant_id,
            art_id,
            wup_id,
            nb_id,
            dat_auslistung,
            wrg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id
            AND A.dat_auslistung = b.dat_auslistung
    WHERE
        A.dat_final IS NOT NULL
        AND A.dat_final <= CURRENT_DATE("Europe/Berlin")
        AND A.mandant_id > 1
) AS b
WHERE
    as_food_det_final0.mandant_id = b.mandant_id AND as_food_det_final0.wup_id = b.wup_id AND as_food_det_final0.nb_id
    = b.nb_id AND as_food_det_final0.art_id = b.art_id AND as_food_det_final0.kjwo = b.kjwo AND as_food_det_final0.dat_auslistung
    = b.dat_auslistung AND as_food_det_final0.dat_auslistung < DATE '2022-03-07';


-- update preisaenderung fuer kmo


UPDATE dbp_etl.as_food_det_final AS as_food_det_final0 SET
    menge_abschrift_22 = CASE
        WHEN b.diff_wert_bestand_netto <> 0
            THEN 1
        ELSE 0
    END,
    abschriftbetrag_netto_22 = CAST(b.diff_wert_bestand_netto AS NUMERIC),
    menge_berechnet = CASE
        WHEN b.diff_wert_bestand_netto <> 0
            THEN 1
        ELSE 0
    END,
    diff_wert_bestand_netto = CAST(b.diff_wert_bestand_netto AS NUMERIC) FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.kjwo,
        A.dat_auslistung,
        (A.phase_vk_netto - b.phase_vk_netto) * A.menge AS diff_wert_bestand_netto
    FROM dbp_etl.as_food_det_final AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            nb_id,
            dat_auslistung,
            phase_vk_netto
        FROM dbp_etl.as_food_det_final
        WHERE
            phase_id = 0
            AND mandant_id > 1
        GROUP BY
            art_id,
            mandant_id,
            nb_id,
            wup_id,
            dat_auslistung,
            phase_vk_netto
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat_auslistung = b.dat_auslistung
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.kjwo,
        A.dat_auslistung,
        diff_wert_bestand_netto
) AS b
WHERE
    as_food_det_final0.mandant_id = b.mandant_id AND as_food_det_final0.wup_id = b.wup_id AND as_food_det_final0.nb_id
    = b.nb_id AND as_food_det_final0.art_id = b.art_id AND as_food_det_final0.kjwo = b.kjwo AND as_food_det_final0.dat_auslistung
    = b.dat_auslistung;


CREATE OR REPLACE TEMPORARY TABLE _snapshot AS
-- with stock or dat_final <=CURRENT_DATE("Europe/Berlin")
SELECT
    C.kjwo AS kjwo_kill,
    -- determine last week until today from dat_final or aedat
    A.dat_final AS dat_final_,
    A.dat_aend,
    B.art_id,
    B.mandant_id,
    B.nb_id,
    B.wup_id,
    B.dat_auslistung,
    B.phase_id,
    B.kjwo,
    B.phase_wo,
    B.phase_vk_brutto,
    B.phase_vk_netto,
    B.menge_abschrift_22,
    B.abschriftbetrag_netto_22,
    B.menge_abschrift_122,
    B.abschriftbetrag_netto_122,
    B.diff_wert_bestand_netto,
    B.menge_berechnet,
    B.menge_endbestand_phase,
    B.menge,
    B.umsatz_netto,
    B.mwst_id,
    B.wtag_phasenbeginn,
    B.dat_von,
    B.dat_bis,
    B.wrg_id,
    B.dat_final,
    B.erl_kz,
    B.as_final_status_id,
    B.betrag_ek_nettonetto,
    B.betrag_ek_mep,
    B.betrag_einstandspreis,
    B.betrag_logkostenzuschlag,
    B.betrag_ek_mep_vor_fwu
FROM dbp_etl.as_food_final AS A
INNER JOIN dbp_data.tag AS C ON COALESCE(A.dat_final, A.dat_aend) = C.dat -- join on dat_final or aedat

INNER JOIN dbp_etl.as_food_det_final AS B
    ON
        A.art_id = B.art_id AND A.mandant_id = B.mandant_id AND A.wup_id
        = B.wup_id AND A.dat_auslistung = B.dat_auslistung AND C.kjwo -- take all weeks >= week from dat_final or aedat

        <= B.kjwo
WHERE
    A.erl_fg = 1
    OR A.dat_final IS NOT NULL AND A.dat_final <= CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _absatz_konsolidiert AS
SELECT
    D.mandant_id,
    a.kjwo_kill AS kjwo,
    D.art_id,
    D.wup_id,
    D.wrg,
    SUM(D.menge) AS menge,
    SUM(D.umsatz_netto) AS umsatz_netto,
    SUM(D.ek_nettonetto) AS ek_nettonetto,
    SUM(D.ek_mep) AS ek_mep,
    SUM(D.einstandspreis) AS einstandspreis,
    SUM(D.logkostenzuschlag) AS logkostenzuschlag,
    SUM(D.ek_mep_vor_fwu) AS ek_mep_vor_fwu
FROM (
    SELECT
        kjwo_kill,
        mandant_id,
        wup_id,
        art_id,
        dat_auslistung,
        dat_final,
        dat_aend,
        wtag_phasenbeginn,
        dat_von,
        dat_bis
    FROM `_snapshot`
    GROUP BY
        kjwo_kill,
        mandant_id,
        wup_id,
        art_id,
        dat_auslistung,
        dat_final,
        dat_aend,
        wtag_phasenbeginn,
        dat_von,
        dat_bis
) AS a
INNER JOIN dbp_data.artbew AS D
    ON
        a.mandant_id = D.mandant_id AND a.art_id = D.art_id AND a.wup_id = D.wup_id AND D.dat BETWEEN a.dat_von AND a.dat_bis -- take whole week
        AND D.dat <= COALESCE(a.dat_final, a.dat_aend
        )
GROUP BY
    D.mandant_id,
    kjwo,
    D.art_id,
    D.wup_id,
    D.wrg;


CREATE OR REPLACE TEMPORARY TABLE _abschrift_konsolidiert AS
SELECT
    D.mandant_id,
    a.kjwo_kill AS kjwo,
    D.art_id,
    D.wup_id,
    D.wrg_id,
    SUM(CASE
        WHEN D.abschriftart_id = 22
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_22,
    SUM(CASE
        WHEN D.abschriftart_id = 22
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_22,
    SUM(CASE
        WHEN D.abschriftart_id IN (23, 122)
            THEN D.menge_abschrift
        ELSE 0
    END) AS menge_abschrift_122,
    SUM(CASE
        WHEN D.abschriftart_id IN (23, 122)
            THEN D.abschriftbetrag_netto
        ELSE 0
    END) AS abschriftbetrag_netto_122
FROM (
    SELECT
        kjwo_kill,
        mandant_id,
        wup_id,
        art_id,
        dat_auslistung,
        dat_final,
        dat_aend,
        wtag_phasenbeginn,
        dat_von,
        dat_bis
    FROM `_snapshot`
    GROUP BY
        kjwo_kill,
        mandant_id,
        wup_id,
        art_id,
        dat_auslistung,
        dat_final,
        dat_aend,
        wtag_phasenbeginn,
        dat_von,
        dat_bis
) AS a
INNER JOIN dbp_data.marktabschriften AS D
    ON
        a.mandant_id = D.mandant_id AND a.art_id = D.art_id AND a.wup_id
        = D.wup_id AND D.dat <= COALESCE(a.dat_final, a.dat_aend) AND D.dat BETWEEN a.dat_von AND a.dat_bis
WHERE
    D.mandant_id = 1
    AND D.abschriftart_id IN (22, 23, 122)
GROUP BY
    D.mandant_id,
    kjwo,
    D.art_id,
    D.wup_id,
    D.wrg_id;


UPDATE `_snapshot` SET
    umsatz_netto = 0,
    betrag_ek_nettonetto = 0,
    betrag_ek_mep = 0,
    betrag_einstandspreis = 0,
    betrag_logkostenzuschlag = 0,
    betrag_ek_mep_vor_fwu = 0,
    menge_abschrift_22 = 0,
    abschriftbetrag_netto_22 = 0,
    menge_abschrift_122 = 0,
    abschriftbetrag_netto_122 = 0
WHERE mandant_id = 1;


UPDATE `_snapshot` SET
    umsatz_netto = 0,
    betrag_ek_nettonetto = 0,
    betrag_ek_mep = 0,
    betrag_einstandspreis = 0,
    betrag_logkostenzuschlag = 0,
    betrag_ek_mep_vor_fwu = 0
WHERE mandant_id > 1;


UPDATE `_snapshot` SET
    menge = b.menge,
    umsatz_netto = b.umsatz_netto,
    wrg_id = b.wrg,
    betrag_ek_nettonetto = b.ek_nettonetto,
    betrag_ek_mep = b.ek_mep,
    betrag_einstandspreis = b.einstandspreis,
    betrag_logkostenzuschlag = b.logkostenzuschlag,
    betrag_ek_mep_vor_fwu = b.ek_mep_vor_fwu
FROM `_absatz_konsolidiert` AS b
WHERE
    `_snapshot`.mandant_id = b.mandant_id AND `_snapshot`.kjwo = b.kjwo AND `_snapshot`.wup_id = b.wup_id AND
    `_snapshot`.art_id = b.art_id;


UPDATE `_snapshot` SET
    menge_abschrift_22 = CAST(b.menge_abschrift_22 AS INTEGER),
    abschriftbetrag_netto_22 = CAST(b.abschriftbetrag_netto_22 AS NUMERIC),
    menge_abschrift_122 = CAST(b.menge_abschrift_122 AS INTEGER),
    abschriftbetrag_netto_122 = CAST(b.abschriftbetrag_netto_122 AS NUMERIC),
    wrg_id = b.wrg_id
FROM `_abschrift_konsolidiert` AS b
WHERE
    `_snapshot`.mandant_id = b.mandant_id AND `_snapshot`.kjwo = b.kjwo AND `_snapshot`.wup_id = b.wup_id AND
    `_snapshot`.art_id = b.art_id;


UPDATE dbp_etl.as_food_det_final SET
    menge = b.menge,
    umsatz_netto = b.umsatz_netto,
    menge_abschrift_22 = b.menge_abschrift_22,
    abschriftbetrag_netto_22 = b.abschriftbetrag_netto_22,
    menge_abschrift_122 = b.menge_abschrift_122,
    abschriftbetrag_netto_122 = b.abschriftbetrag_netto_122,
    wrg_id = b.wrg_id
FROM `_snapshot` AS b
WHERE
    as_food_det_final.mandant_id = b.mandant_id AND as_food_det_final.kjwo = b.kjwo AND as_food_det_final.wup_id = b.wup_id
    AND as_food_det_final.art_id = b.art_id AND as_food_det_final.dat_auslistung = b.dat_auslistung;


-- kmo (preisaenderung fuer abgeschlossene)


UPDATE dbp_etl.as_food_det_final AS as_food_det_final0 SET
    menge_abschrift_22 = CASE
        WHEN b.diff_wert_bestand_netto <> 0
            THEN 1
        ELSE 0
    END,
    abschriftbetrag_netto_22 = CAST(b.diff_wert_bestand_netto AS NUMERIC),
    menge_berechnet = CASE
        WHEN b.diff_wert_bestand_netto <> 0
            THEN 1
        ELSE 0
    END,
    diff_wert_bestand_netto = CAST(b.diff_wert_bestand_netto AS NUMERIC),
    wrg_id = b.wrg_id FROM (
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.kjwo,
        A.dat_auslistung,
        b.wrg_id,
        (A.phase_vk_netto - b.phase_vk_netto) * A.menge AS diff_wert_bestand_netto
    FROM `_snapshot` AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            nb_id,
            dat_auslistung,
            MAX(wrg_id) AS wrg_id,
            phase_vk_netto
        FROM dbp_etl.as_food_det_final
        WHERE
            phase_id = 0
            AND mandant_id > 1
        GROUP BY
            art_id,
            mandant_id,
            nb_id,
            wup_id,
            dat_auslistung,
            phase_vk_netto
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat_auslistung = b.dat_auslistung
) AS b
WHERE
    as_food_det_final0.mandant_id = b.mandant_id AND as_food_det_final0.wup_id = b.wup_id AND as_food_det_final0.nb_id
    = b.nb_id AND as_food_det_final0.art_id = b.art_id AND as_food_det_final0.kjwo = b.kjwo AND as_food_det_final0.dat_auslistung
    = b.dat_auslistung;


/*select dat_final*/


CREATE OR REPLACE TABLE dbp_etl.as_food_upd AS
SELECT
    MAX(as_food_final.dat_auslistung) AS dat_auslistung,
    MAX(tag.kjwo) AS kjwo,
    as_food_final.mandant_id,
    as_food_final.wup_id,
    as_food_final.nb_id,
    as_food_final.art_id,
    as_food_final.dat_final
FROM dbp_etl.as_food_final
INNER JOIN dbp_data.tag ON as_food_final.dat_final = tag.dat
WHERE
    as_food_final.dat_final IS NOT NULL
    AND as_food_final.dat_final > as_food_final.dat_auslistung
GROUP BY
    as_food_final.art_id,
    as_food_final.mandant_id,
    as_food_final.nb_id,
    as_food_final.wup_id,
    as_food_final.dat_final;


/*set dat_final*/


UPDATE dbp_etl.as_food_det_final SET
    dat_final = dt1.dat_final_ FROM (SELECT
    kjwo AS dat_final_woche_,
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    art_id AS art_id_,
    dat_final AS dat_final_,
    dat_auslistung AS dat_auslistung_
FROM dbp_etl.as_food_upd AS T1) AS dt1
WHERE
    as_food_det_final.mandant_id = dt1.mandant_id_ AND as_food_det_final.wup_id = dt1.wup_id_ AND as_food_det_final.art_id
    = dt1.art_id_ AND as_food_det_final.kjwo = dt1.dat_final_woche_ AND as_food_det_final.dat_auslistung = dt1.dat_auslistung_;


/*set dat_final for next kjwo where dat_final > dat_auslistung and erl_kz = 'D'*/


CREATE OR REPLACE TABLE dbp_etl.as_food_upd AS
-- and erl_kz <> 'D' --
SELECT
    as_food_final.mandant_id,
    as_food_final.wup_id,
    as_food_final.nb_id,
    as_food_final.art_id,
    as_food_final.dat_final,
    as_food_final.erl_kz,
    as_food_final.dat_auslistung,
    tag.kjwo,
    ROW_NUMBER() OVER (
        PARTITION BY as_food_final.mandant_id, as_food_final.wup_id, as_food_final.nb_id, as_food_final.art_id
        ORDER BY
            as_food_final.dat_final IS NULL DESC, as_food_final.dat_final DESC, as_food_final.dat_auslistung IS NULL
            DESC, as_food_final.dat_auslistung DESC, tag.kjwo IS NULL DESC, tag.kjwo DESC
    ) AS rn
FROM dbp_etl.as_food_final
INNER JOIN dbp_data.tag ON as_food_final.dat_final = tag.dat
WHERE
    as_food_final.dat_final IS NOT NULL
    AND as_food_final.erl_kz = 'D'
    AND as_food_final.dat_final > as_food_final.dat_auslistung;


UPDATE dbp_etl.as_food_det_final SET
    dat_final = dt1.dat_final_ FROM (SELECT
    kjwo AS dat_final_woche_,
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    art_id AS art_id_,
    dat_final AS dat_final_,
    dat_auslistung AS dat_auslistung_,
    erl_kz AS erl_kz_
FROM dbp_etl.as_food_upd AS T1
WHERE rn = 1) AS dt1
WHERE
    as_food_det_final.mandant_id = dt1.mandant_id_ AND as_food_det_final.wup_id = dt1.wup_id_ AND as_food_det_final.art_id
    = dt1.art_id_ AND as_food_det_final.kjwo >= dt1.dat_final_woche_ AND dt1.dat_final_ > as_food_det_final.dat_auslistung;
/* and dat_final > dat_auslistung */


/* set erkl_kz = 'D' where dat_final is not null*/


CREATE OR REPLACE TABLE dbp_etl.as_food_upd AS
SELECT
    as_food_final.mandant_id,
    as_food_final.wup_id,
    as_food_final.nb_id,
    as_food_final.art_id,
    as_food_final.dat_final,
    as_food_final.erl_kz,
    as_food_final.dat_auslistung,
    tag.kjwo,
    ROW_NUMBER() OVER (
        PARTITION BY as_food_final.mandant_id, as_food_final.wup_id, as_food_final.nb_id, as_food_final.art_id
        ORDER BY
            as_food_final.dat_final IS NULL DESC, as_food_final.dat_final DESC, as_food_final.dat_auslistung IS NULL
            DESC, as_food_final.dat_auslistung DESC, tag.kjwo IS NULL DESC, tag.kjwo DESC
    ) AS rn
FROM dbp_etl.as_food_final
INNER JOIN dbp_data.tag ON as_food_final.dat_final = tag.dat
WHERE
    as_food_final.dat_final IS NOT NULL
    AND as_food_final.erl_kz = 'D'
    AND as_food_final.dat_final > as_food_final.dat_auslistung;


UPDATE dbp_etl.as_food_det_final SET
    erl_kz = dt1.erl_kz_ FROM (SELECT -- t1.rn,
    kjwo AS dat_final_woche_,
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    art_id AS art_id_,
    dat_final AS dat_final_,
    dat_auslistung AS dat_auslistung_,
    erl_kz AS erl_kz_
FROM dbp_etl.as_food_upd AS T1
WHERE rn = 1) AS dt1
WHERE
    as_food_det_final.mandant_id = dt1.mandant_id_ AND as_food_det_final.wup_id = dt1.wup_id_ AND as_food_det_final.art_id
    = dt1.art_id_ AND as_food_det_final.kjwo >= dt1.dat_final_woche_ AND as_food_det_final.dat_final > dt1.dat_auslistung_;


/* update erl_kz where dat_final is null*/


CREATE OR REPLACE TABLE dbp_etl.as_food_upd AS
SELECT
    as_food_final.mandant_id,
    as_food_final.wup_id,
    as_food_final.nb_id,
    as_food_final.art_id,
    as_food_final.dat_final,
    as_food_final.erl_kz,
    as_food_final.dat_auslistung,
    tag.kjwo,
    ROW_NUMBER() OVER (
        PARTITION BY as_food_final.mandant_id, as_food_final.wup_id, as_food_final.nb_id, as_food_final.art_id
        ORDER BY
            as_food_final.dat_aend IS NULL DESC, as_food_final.dat_aend DESC, as_food_final.dat_auslistung IS NULL DESC,
            as_food_final.dat_auslistung DESC, tag.kjwo IS NULL DESC, tag.kjwo DESC
    ) AS rn
FROM dbp_etl.as_food_final
INNER JOIN dbp_data.tag ON as_food_final.dat_aend = tag.dat
WHERE as_food_final.dat_final IS NULL;


UPDATE dbp_etl.as_food_det_final SET
    erl_kz = dt1.erl_kz_ FROM (SELECT
    kjwo AS dat_final_woche_,
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    art_id AS art_id_,
    dat_auslistung AS dat_auslistung_,
    erl_kz AS erl_kz_
FROM dbp_etl.as_food_upd AS T1) AS dt1
WHERE
    as_food_det_final.mandant_id = dt1.mandant_id_ AND as_food_det_final.wup_id = dt1.wup_id_ AND as_food_det_final.art_id
    = dt1.art_id_ AND as_food_det_final.kjwo = dt1.dat_final_woche_ AND as_food_det_final.dat_auslistung = dt1.dat_auslistung_;


/*set as_final_status_id = 2*/


UPDATE dbp_etl.as_food_det_final SET
    as_final_status_id = 2 FROM (
    SELECT
        T3.kjwo AS dat_final_woche_,
        T4.kjwo AS max_woche_,
        T1.mandant_id AS mandant_id_,
        T1.wup_id AS wup_id_,
        T1.nb_id AS nb_id_,
        T1.art_id AS art_id_,
        T1.dat_final AS dat_final_,
        T1.erl_kz AS erl_kz_
    FROM dbp_etl.as_food_final AS T1
    INNER JOIN dbp_data.tag AS T3 ON T1.dat_final = T3.dat
    INNER JOIN dbp_data.woche AS T4 ON T3.akt_wo + 1 = T4.akt_wo
    WHERE
        T1.erl_kz <> 'D'
        AND T1.dat_final IS NOT NULL
) AS dt1
WHERE
    as_food_det_final.mandant_id = dt1.mandant_id_ AND as_food_det_final.wup_id = dt1.wup_id_ AND as_food_det_final.art_id
    = dt1.art_id_ AND as_food_det_final.erl_kz <> 'D' AND as_food_det_final.kjwo BETWEEN dt1.dat_final_woche_ AND dt1.max_woche_ AND as_food_det_final.dat_final IS NOT NULL;


DELETE FROM dbp_data.as_food
WHERE (mandant_id, wup_id, nb_id, art_id, dat_auslistung) IN (SELECT
    (mandant_id, wup_id, nb_id, art_id, dat_auslistung
    )
FROM dbp_etl.as_food_final);


INSERT INTO dbp_data.as_food (
    art_id, mandant_id, nb_id, wup_id, dat_auslistung, gp_id, wrg_id,
    phase_status, erl_fg, dat_final, menge_startbestand, vk_netto, menge_endbestand, erl_kz, dat_aend, td_update, td_insert
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        A.gp_id,
        B.default_wrg AS wrg_id,
        A.phase_status,
        A.erl_fg,
        A.dat_final,
        A.menge_startbestand,
        A.vk_netto,
        A.menge_endbestand,
        A.erl_kz,
        A.dat_aend,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_etl.as_food_final AS A
    INNER JOIN dbp_data.mandant AS B ON A.mandant_id = B.mandant_id
);


DELETE FROM dbp_data.as_food_det
WHERE (mandant_id, wup_id, nb_id, art_id, dat_auslistung, kjwo) IN (SELECT (
    mandant_id, wup_id, nb_id, art_id,
    dat_auslistung, kjwo
)
FROM dbp_etl.as_food_det_final);


INSERT INTO dbp_data.as_food_det (
    art_id, mandant_id, nb_id, wup_id, dat_auslistung, kjwo, phase_wo,
    wrg_id, erl_kz, dat_final, as_final_status_id, phase_id, phase_vk_brutto, phase_vk_netto, menge_totalabschrift,
    betrag_totalabschrift_netto, menge_preisabschrift, betrag_preisabschrift_netto, menge_endbestand_phase, menge_absatz,
    umsatz_netto, betrag_ek_nettonetto, betrag_ek_mep, betrag_einstandspreis, betrag_logkostenzuschlag,
    betrag_ek_mep_vor_fwu, td_update, td_insert
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.nb_id,
        A.wup_id,
        A.dat_auslistung,
        A.kjwo,
        A.phase_wo,
        C.default_wrg AS wrg_id,
        A.erl_kz,
        A.dat_final,
        A.as_final_status_id,
        A.phase_id,
        A.phase_vk_brutto,
        A.phase_vk_netto,
        CASE
            WHEN A.mandant_id = 1
                THEN A.menge_abschrift_122
            ELSE -1 * ABS(A.menge_abschrift_122)
        END AS menge_totalabschrift,
        CAST(CASE
            WHEN A.mandant_id = 1
                THEN A.abschriftbetrag_netto_122
            ELSE -1 * ABS(A.abschriftbetrag_netto_122)
        END AS NUMERIC) AS betrag_totalabschrift_netto,
        A.menge_abschrift_22 AS menge_preisabschrift,
        A.abschriftbetrag_netto_22 AS betrag_preisabschrift_netto,
        A.menge_endbestand_phase,
        A.menge AS menge_absatz,
        A.umsatz_netto,
        A.betrag_ek_nettonetto,
        A.betrag_ek_mep,
        A.betrag_einstandspreis,
        A.betrag_logkostenzuschlag,
        A.betrag_ek_mep_vor_fwu,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_etl.as_food_det_final AS A
    INNER JOIN (SELECT
        MAX(kjwo_kl) AS kjwo_kl,
        kjwo
    FROM dbp_data.woche_kj_kl
    GROUP BY kjwo) AS b ON A.kjwo = b.kjwo
    INNER JOIN dbp_data.mandant AS C ON A.mandant_id = C.mandant_id
);


-- vorbereitung fuers bestandstracking


CREATE OR REPLACE TEMPORARY TABLE _sonntag AS
SELECT
    dat,
    kjwo
FROM dbp_data.tag
WHERE
    wtag_id = 7
    AND akt_wo BETWEEN -2 AND 0
GROUP BY
    dat,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mbst AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    B.kjwo,
    A.menge_lgbest_erp_frei_bme
FROM dbp_data.marktbestand_erp AS A
INNER JOIN `_sonntag` AS B ON A.dat = B.dat
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id,
    B.kjwo,
    A.menge_lgbest_erp_frei_bme;


DELETE FROM dbp_etl_process.as_food_mbst
WHERE kjwo IN (
    SELECT kjwo
    FROM `_mbst`
);


INSERT INTO dbp_etl_process.as_food_mbst (mandant_id, wup_id, art_id, kjwo, menge_lgbest_erp_frei_bme)
(SELECT
    mandant_id,
    wup_id,
    art_id,
    kjwo,
    menge_lgbest_erp_frei_bme
FROM `_mbst`);


UPDATE dbp_data.as_food_det SET
    menge_endbestand = b.menge_lgbest_erp_frei_bme FROM (
    SELECT *
    FROM dbp_etl_process.as_food_mbst
    WHERE kjwo < (
        SELECT kjwo
        FROM dbp_data.woche
        WHERE akt_wo = 0
    )
) AS b
WHERE
    as_food_det.mandant_id = b.mandant_id AND as_food_det.wup_id = b.wup_id AND as_food_det.art_id = b.art_id AND
    as_food_det.kjwo = b.kjwo;


CREATE OR REPLACE TEMPORARY TABLE _gestern AS
SELECT
    dat,
    kjwo
FROM dbp_data.tag
WHERE dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
GROUP BY
    dat,
    kjwo;


CREATE OR REPLACE TEMPORARY TABLE _mbst AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.art_id,
    B.kjwo,
    A.menge_lgbest_erp_frei_bme
FROM dbp_data.marktbestand_erp AS A
INNER JOIN `_gestern` AS B ON A.dat = B.dat
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.art_id,
    B.kjwo,
    A.menge_lgbest_erp_frei_bme;


UPDATE dbp_data.as_food_det SET
    menge_endbestand = b.menge_lgbest_erp_frei_bme
FROM `_mbst` AS b
WHERE
    as_food_det.mandant_id = b.mandant_id AND as_food_det.wup_id = b.wup_id AND as_food_det.art_id = b.art_id AND
    as_food_det.kjwo = b.kjwo;


-- as_final_status_id-updates


UPDATE dbp_data.as_food_det SET
    as_final_status_id = 0
WHERE TRUE;


CREATE OR REPLACE TABLE dbp_etl.asf AS
SELECT
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    dat_final,
    erl_kz,
    dat_auslistung,
    kjwo,
    ROW_NUMBER() OVER (
        PARTITION BY
            mandant_id, wup_id, nb_id, art_id, dat_auslistung ORDER BY
            kjwo IS NULL, kjwo,
            dat_final IS NULL, dat_final
    ) AS rn
FROM dbp_data.as_food_det
WHERE
    dat_final IS NOT NULL
    AND erl_kz = 'D'
    AND dat_final > dat_auslistung;


CREATE OR REPLACE TABLE dbp_etl.update_as_ AS
SELECT DISTINCT
    T3.mandant_id,
    T3.wup_id,
    T3.nb_id,
    T3.art_id,
    T3.dat_final,
    T3.erl_kz,
    T3.dat_auslistung,
    T3.kjwo,
    T3.rn,
    T2.kjwo AS kjwo_artbew
FROM dbp_data.artbew AS T1
INNER JOIN dbp_data.tag AS T2 ON T1.dat = T2.dat
INNER JOIN dbp_etl.asf AS T3
    ON
        T1.art_id = T3.art_id AND T1.mandant_id = T3.mandant_id AND T1.wup_id =
        T3.wup_id
WHERE
    T2.kjwo BETWEEN T3.kjwo + 1 AND (T3.kjwo + 5)
    AND T1.menge > 0
    AND T3.rn = 1;


UPDATE dbp_data.as_food_det SET
    as_final_status_id = 1 FROM (SELECT DISTINCT
    kjwo_artbew AS dat_final_woche_,
    mandant_id AS mandant_id_,
    wup_id AS wup_id_,
    nb_id AS nb_id_,
    art_id AS art_id_,
    dat_final AS dat_final_,
    dat_auslistung AS dat_auslistung_,
    erl_kz AS erl_kz_
FROM dbp_etl.update_as_ AS T1) AS dt1
WHERE
    as_food_det.mandant_id = dt1.mandant_id_ AND as_food_det.wup_id = dt1.wup_id_ AND as_food_det.art_id = dt1.art_id_
    AND as_food_det.nb_id = dt1.nb_id_ AND as_food_det.dat_final = dt1.dat_final_ AND as_food_det.dat_auslistung =
    dt1.dat_auslistung_ AND as_food_det.kjwo = dt1.dat_final_woche_ AND as_food_det.erl_kz = dt1.erl_kz_ AND
    as_food_det.menge_absatz > 0;

CREATE OR REPLACE TEMPORARY TABLE _schrott AS (
    SELECT
        mandant_id,
        dat_auslistung,
        min(kjwo) as kjwo,
        wup_id,
        art_id,
        dat_final
    FROM dbp_data.as_food_det
    WHERE dat_final IS NOT NULL
    GROUP BY 1, 2, 4, 5, 6
);

UPDATE dbp_data.as_food_det a
SET a.dat_final = b.dat_final
FROM _schrott b
WHERE
    a.mandant_id = b.mandant_id
    AND a.wup_id = b.wup_id
    AND a.art_id = b.art_id
    AND a.dat_auslistung = b.dat_auslistung
    AND a.kjwo > b.kjwo
    AND COALESCE(a.dat_final, '9999-12-31') <> b.dat_final;


UPDATE dbp_data.as_food_det AS as_food_det0 SET
    as_final_status_id = 2 FROM (
    SELECT
        T3.kjwo AS dat_final_woche_,
        t5.kjwo AS max_woche_,
        T1.mandant_id AS mandant_id_,
        T1.wup_id AS wup_id_,
        T1.nb_id AS nb_id_,
        T1.art_id AS art_id_,
        T1.dat_auslistung AS dat_auslistung_,
        T1.dat_final AS dat_final_
    FROM dbp_data.as_food_det AS T1
    INNER JOIN dbp_data.as_food AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id = T2.art_id AND T1.wup_id
            = T2.wup_id AND T1.dat_auslistung = T2.dat_auslistung
    INNER JOIN dbp_data.tag AS T3 ON T1.dat_final = T3.dat
    INNER JOIN dbp_data.woche AS T4 ON T3.akt_wo = T4.akt_wo
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            kjwo
        FROM dbp_data.as_food_det
        WHERE
            kjwo <= (
                SELECT DISTINCT kjwo
                FROM dbp_data.woche
                WHERE akt_wo = 0
            )
        GROUP BY
            art_id,
            mandant_id,
            wup_id,
            kjwo
    ) AS t5 ON T1.mandant_id = t5.mandant_id AND T1.art_id = t5.art_id AND T1.wup_id = t5.wup_id AND T1.kjwo = t5.kjwo

    WHERE
        T1.erl_kz <> 'D'
        AND T1.menge_endbestand > 0
        AND T1.dat_final IS NOT NULL
    GROUP BY
        dat_final_woche_,
        max_woche_,
        mandant_id_,
        wup_id_,
        nb_id_,
        art_id_,
        dat_auslistung_,
        dat_final_
) AS dt1
WHERE
    as_food_det0.mandant_id = dt1.mandant_id_ AND as_food_det0.wup_id = dt1.wup_id_ AND as_food_det0.art_id = dt1.art_id_
    AND as_food_det0.erl_kz <> 'D' AND as_food_det0.dat_auslistung = dt1.dat_auslistung_ AND as_food_det0.kjwo = dt1.max_woche_ AND as_food_det0.dat_final IS NOT NULL;
