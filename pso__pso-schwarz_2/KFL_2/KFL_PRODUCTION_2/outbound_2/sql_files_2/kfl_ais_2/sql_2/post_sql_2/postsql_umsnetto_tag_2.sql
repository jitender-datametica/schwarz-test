--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO KFL_PRODUCTION.DBX_LOAD.artbew_konto_tag_work_2
--(
--       mandant_id                        
--      ,wup_id                         
--      ,konto_id                       
--      ,bewart_id                                     
--      ,nb_id                       
--      ,arthiertyp_id                   
--      ,umsatz_brutto                  
--      ,umsatz_netto                      
--      ,umsatz_wrg
--      ,umsatz_brutto_konz                  
--      ,umsatz_netto_konz                
--      ,dat                                   
--)
--SELECT
--  1 AS mandant_id
--, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
--, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) AS konto_id
--, 1006 AS bewart_id
--, w.nb_id AS nb_id
--, 2 AS arthiertyp_id
--, SUM(CAST(brutto_umsatz AS NUMBER(29,2)) / 100 ) AS umsatz_brutto
--, SUM(CAST(netto_umsatz AS NUMBER(29,2)) /100 ) AS umsatz_netto
--, 'EUR' AS umsatz_wrg
--, SUM(CAST(brutto_umsatz  AS NUMBER(29,2)) / 100 ) AS umsatz_brutto_konz
--, SUM(CAST(netto_umsatz   AS NUMBER(29,2)) / 100 ) AS umsatz_netto_konz
--, CAST (datum AS DATE FORMAT 'YYYYMMDD') AS dat
--FROM KFL_PRODUCTION.DBX_LOAD.umsnetto_tag a
--INNER JOIN KFL_PRODUCTION.DBX_DATA.wup_2 w
--ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
--AND 1 = w.mandant_id
--AND w.nb_id IN (2, 7)
--
--GROUP BY 1,2,3,4,5,6,9,12
--;
--
--Comment from validation checker
--error line 28 at position 22 unexpected 'FORMAT'.
--, CAST (datum AS DATE  ^^^> FORMAT 'YYYYMMDD') AS dat
--syntax error line 28 at position 29 unexpected 'YYYYMMDD'.
--, CAST (datum AS DATE FORMAT  ^^^> 'YYYYMMDD') AS dat
--translated statement


INSERT INTO dbp_etl.artbew_konto_tag_work_2 (
    mandant_id, wup_id, konto_id, bewart_id, nb_id, arthiertyp_id,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    dat
)
(
    SELECT
        1 AS mandant_id,
        CAST(
            ROUND(CAST(SUBSTR(A.marktnummer, 1, 4) AS BIGNUMERIC), 0) AS INTEGER
        )
            AS wup_id,
        CAST(ROUND(CAST(SUBSTR(A.fi_konto, 4, 7) AS BIGNUMERIC), 0) AS INTEGER)
            AS konto_id,
        1006 AS bewart_id,
        W.nb_id,
        2 AS arthiertyp_id,
        SUM(ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100) AS umsatz_brutto,
        SUM(ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100) AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        SUM(ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100)
            AS umsatz_brutto_konz,
        SUM(ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100)
            AS umsatz_netto_konz,
        PARSE_DATE('%Y%m%d', A.datum) AS dat
    FROM dbp_etl.d_umsnetto_tag_2 AS A
    INNER JOIN dbp_data.wup_2 AS W
        ON
            ROUND(CAST(A.marktnummer AS BIGNUMERIC), 0) = W.wup_id
            AND 1 = W.mandant_id
            AND W.nb_id IN (2, 7)
    GROUP BY
        mandant_id,
        wup_id,
        konto_id,
        bewart_id,
        W.nb_id,
        arthiertyp_id,
        umsatz_wrg,
        dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_konto_tag_2 AS A
WHERE (
    dat, wup_id, konto_id) IN (
    SELECT (dat, wup_id, konto_id)
    FROM dbp_etl.artbew_konto_tag_work_2
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO KFL_PRODUCTION.DBX_DATA.artbew_konto_tag_2
--(
--       mandant_id                        
--      ,wup_id                         
--      ,konto_id                       
--      ,bewart_id                                     
--      ,nb_id                       
--      ,arthiertyp_id                   
--      ,umsatz_brutto                  
--      ,umsatz_netto                      
--      ,umsatz_wrg
--      ,umsatz_brutto_konz                  
--      ,umsatz_netto_konz                
--      ,dat                                   
--)
--SELECT
--  1 AS mandant_id
--, CAST(SUBSTR(marktnummer,1,4) AS INTEGER) AS wup_id
--, CAST(SUBSTR(fi_konto,4,7) AS INTEGER) as konto_id
--, 1006 AS bewart_id
--, w.nb_id AS nb_id
--, 2 AS arthiertyp_id
--, SUM(CAST(brutto_umsatz AS NUMBER(29,2)) / 100 ) AS umsatz_brutto
--, SUM(CAST(netto_umsatz AS NUMBER(29,2)) /100 ) AS umsatz_netto
--, 'EUR' AS umsatz_wrg
--, SUM(CAST(brutto_umsatz  AS NUMBER(29,2)) / 100 ) AS umsatz_brutto_konz
--, SUM(CAST(netto_umsatz   AS NUMBER(29,2)) / 100 ) AS umsatz_netto_konz
--, CAST (datum AS DATE FORMAT 'YYYYMMDD') AS dat
--FROM KFL_PRODUCTION.DBX_LOAD.umsnetto_tag a
--INNER JOIN KFL_PRODUCTION.DBX_DATA.wup_2 w
--ON  CAST(a.marktnummer AS INTEGER) = w.wup_id
--AND 1 = w.mandant_id
--AND w.nb_id IN (2, 7)
--
--GROUP BY 1,2,3,4,5,6,9,12
--;
--
--Comment from validation checker
--error line 28 at position 22 unexpected 'FORMAT'.
--, CAST (datum AS DATE  ^^^> FORMAT 'YYYYMMDD') AS dat
--syntax error line 28 at position 29 unexpected 'YYYYMMDD'.
--, CAST (datum AS DATE FORMAT  ^^^> 'YYYYMMDD') AS dat
--translated statement


INSERT INTO dbp_data.artbew_konto_tag_2 (
    konto_id, arthiertyp_id, mandant_id, wup_id, nb_id, bewart_id, dat,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz
)
(
    SELECT
        CAST(ROUND(CAST(SUBSTR(A.fi_konto, 4, 7) AS BIGNUMERIC), 0) AS INTEGER)
            AS konto_id,
        2 AS arthiertyp_id,
        1 AS mandant_id,
        CAST(
            ROUND(CAST(SUBSTR(A.marktnummer, 1, 4) AS BIGNUMERIC), 0) AS INTEGER
        )
            AS wup_id,
        W.nb_id,
        1006 AS bewart_id,
        PARSE_DATE('%Y%m%d', A.datum) AS dat,
        SUM(ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100) AS umsatz_brutto,
        SUM(ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100) AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        SUM(ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100)
            AS umsatz_brutto_konz,
        SUM(ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100)
            AS umsatz_netto_konz
    FROM dbp_etl.d_umsnetto_tag_2 AS A
    INNER JOIN dbp_data.wup_2 AS W
        ON
            ROUND(CAST(A.marktnummer AS BIGNUMERIC), 0) = W.wup_id
            AND 1 = W.mandant_id
            AND W.nb_id IN (2, 7)
    GROUP BY
        mandant_id,
        wup_id,
        konto_id,
        bewart_id,
        W.nb_id,
        arthiertyp_id,
        umsatz_wrg,
        dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_2 AS A
WHERE nb_id = 2 AND bewart_id IN (
    1003, 1001) AND (dat, wup_id) IN (
    SELECT (dat, wup_id)
    FROM dbp_etl.artbew_konto_tag_work_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_wg_sum_2 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
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
        A.mandant_id,
        A.nb_id,
        2 AS arthiertyp_id,
        -2 AS wg_id,
        A.dat,
        A.wup_id,
        1003 AS bewart_id,
        T.kjmo,
        SUM(A.umsatz_brutto) AS umsatz_brutto,
        SUM(A.umsatz_netto) AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        SUM(A.umsatz_brutto) AS umsatz_brutto_konz,
        SUM(A.umsatz_netto) AS umsatz_netto_konz,
        1,
        0
    FROM dbp_etl.artbew_konto_tag_work_2 AS A
    INNER JOIN dbp_data.tag_2 AS T ON A.dat = T.dat
    WHERE A.nb_id = 2
    GROUP BY
        A.mandant_id,
        A.wup_id,
        wg_id,
        bewart_id,
        A.nb_id,
        arthiertyp_id,
        T.kjmo,
        umsatz_wrg,
        A.dat,
        14,
        15
);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew_wg_sum = 1
WHERE (
    mandant_id, wup_id, dat, nb_id) IN (
    SELECT (mandant_id, wup_id, dat, nb_id)
    FROM dbp_etl.artbew_konto_tag_work_2
    WHERE nb_id = 2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.artbew_abt_sum_tag_work_2 (
    mandant_id, wup_id, nb_id, abt_id, bewart_id, arthiertyp_id,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    dat
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.abt_id,
        A.bewart_id,
        A.arthiertyp_id,
        SUM(A.umsatz_brutto),
        SUM(A.umsatz_netto),
        A.umsatz_wrg,
        SUM(A.umsatz_brutto_konz),
        SUM(A.umsatz_netto_konz),
        A.dat
    FROM dbp_etl.artbew_konto_tag_work_2 AS A
    INNER JOIN dbp_data.wupcal_2 AS C
        ON
            A.wup_id = C.wup_id
            AND A.dat = C.dat
            AND A.mandant_id = C.mandant_id
            AND C.datenlieferung_artbew_wg_sum = 1
    INNER JOIN
        dbp_data.konto_2 AS B
        ON
            A.konto_id = B.konto_id AND 1 = B.mandant_id AND 2 = B.arthiertyp_id
    WHERE A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.bewart_id,
        A.nb_id,
        A.arthiertyp_id,
        A.umsatz_wrg,
        A.dat,
        B.abt_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.artbew_abt_sum_tag_work_2 (
    mandant_id, wup_id, nb_id, abt_id, bewart_id, arthiertyp_id,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    dat
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        wg_per.abt_id,
        A.bewart_id,
        A.arthiertyp_id,
        SUM(A.umsatz_brutto),
        SUM(A.umsatz_netto),
        A.umsatz_wrg,
        SUM(A.umsatz_brutto_konz),
        SUM(A.umsatz_netto_konz),
        A.dat
    FROM dbp_data.artbew_wg_sum_2 AS A
    INNER JOIN dbp_data.wg_per_2
        ON
            A.wg_id = wg_per.wg_id
            AND wg_per.mandant_id = 1
            AND wg_per.arthiertyp_id
            = 2 AND wg_per.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE
        A.mandant_id = 1
        AND A.bewart_id = 1001
        AND (
            A.wup_id, A.dat) IN (
            SELECT (wup_id, dat)
            FROM dbp_etl.artbew_abt_sum_tag_work_2
        )
    GROUP BY
        A.mandant_id,
        A.nb_id,
        A.arthiertyp_id,
        A.dat,
        A.wup_id,
        A.bewart_id,
        A.umsatz_wrg,
        wg_per.abt_id
);
