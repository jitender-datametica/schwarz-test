--[OK] statement is translated correctly (syntax and type checks are fine)


-- , CAST(SUBSTR(marktnummer,4,1) AS INTEGER) AS nb_id
INSERT INTO dbp_etl.artbew_konto_work_1 (
    mandant_id,
    wup_id, konto_id, bewart_id, nb_id, arthiertyp_id, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz,
    umsatz_netto_konz, kjmo
)
(
    SELECT
        1 AS mandant_id,
        CAST(ROUND(CAST(SUBSTR(A.marktnummer, 1, 4) AS BIGNUMERIC), 0) AS INTEGER) AS wup_id,
        CAST(ROUND(CAST(SUBSTR(A.fi_konto, 4, 7) AS BIGNUMERIC), 0) AS INTEGER) AS konto_id,
        1004 AS bewart_id,
        W.nb_id,
        2 AS arthiertyp_id,
        ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100 AS umsatz_brutto,
        ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100 AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100 AS umsatz_brutto_konz,
        ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100 AS umsatz_netto_konz,
        B.kjmo
    FROM dbp_etl.umsnetto_1 AS A
    INNER JOIN dbp_data.monat_1 AS B ON A.gjmo = CAST(B.gjmo AS STRING)
    INNER JOIN
        dbp_data.wup_1
            AS W
        ON
            ROUND(CAST(A.marktnummer AS BIGNUMERIC), 0) = W.wup_id AND 1 = W.mandant_id
            AND W.nb_id IN (2, 7)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_konto_1
WHERE kjmo IN (
    SELECT DISTINCT MO.kjmo
    FROM dbp_etl.umsnetto_1 AS UMS
    INNER JOIN dbp_data.monat_1 AS MO ON UMS.gjmo = CAST(MO.gjmo AS STRING)
    INNER JOIN dbp_data.wup_1
        AS W ON ROUND(CAST(UMS.marktnummer AS BIGNUMERIC), 0) = W.wup_id AND 1 = W.mandant_id
    AND W.nb_id IN (2, 7)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- , CAST(SUBSTR(marktnummer,4,1) AS INTEGER) AS nb_id
INSERT INTO dbp_data.artbew_konto_1 (
    mandant_id,
    wup_id, konto_id, bewart_id, nb_id, arthiertyp_id, umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz,
    umsatz_netto_konz, kjmo
)
(
    SELECT
        1 AS mandant_id,
        CAST(ROUND(CAST(SUBSTR(A.marktnummer, 1, 4) AS BIGNUMERIC), 0) AS INTEGER) AS wup_id,
        CAST(ROUND(CAST(SUBSTR(A.fi_konto, 4, 7) AS BIGNUMERIC), 0) AS INTEGER) AS konto_id,
        1004 AS bewart_id,
        W.nb_id,
        2 AS arthiertyp_id,
        ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100 AS umsatz_brutto,
        ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100 AS umsatz_netto,
        'EUR' AS umsatz_wrg,
        ROUND(CAST(A.brutto_umsatz AS NUMERIC), 2) / 100 AS umsatz_brutto_konz,
        ROUND(CAST(A.netto_umsatz AS NUMERIC), 2) / 100 AS umsatz_netto_konz,
        B.kjmo
    FROM dbp_etl.umsnetto_1 AS A
    INNER JOIN dbp_data.monat_1 AS B ON A.gjmo = CAST(B.gjmo AS STRING) INNER JOIN dbp_data.wup_1 AS W
        ON
            ROUND(CAST(A.marktnummer AS BIGNUMERIC), 0) = W.wup_id AND 1 = W.mandant_id
            AND W.nb_id IN (2, 7)
    GROUP BY
        mandant_id,
        wup_id,
        konto_id,
        bewart_id,
        W.nb_id,
        arthiertyp_id,
        umsatz_brutto,
        umsatz_netto,
        umsatz_wrg,
        umsatz_brutto_konz,
        umsatz_netto_konz,
        B.kjmo
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.artbew_abt_sum_work_1
--  (
--       mandant_id
--      ,wup_id
--      ,nb_id
--      ,abt_id
--      ,bewart_id
--      ,dat
--      ,arthiertyp_id
--      ,umsatz_brutto
--      ,umsatz_netto
--      ,umsatz_wrg 
--      ,umsatz_brutto_konz
--      ,umsatz_netto_konz
--      ,kjmo
--    )
--SELECT 
--       a.mandant_id                        
--      ,a.wup_id
--      ,a.nb_id 
--      ,b.abt_id
--      ,a.bewart_id                                
--      ,CASE 
--         WHEN t.wtag_id = 7 
--            THEN add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 -1
--        ELSE
--            add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1
--       END AS dat     
--       ,a.arthiertyp_id                   
--      ,SUM(a.umsatz_brutto)
--      ,SUM(a.umsatz_netto)                      
--      ,a.umsatz_wrg
--      ,SUM(a.umsatz_brutto_konz)                  
--      ,SUM(a.umsatz_netto_konz)                
--      ,a.kjmo
--FROM DBX_LOAD.artbew_konto_work_1 a
--
--INNER JOIN DBX_DATA.tag_1 t
--on add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 = t.dat
--
--INNER JOIN DBX_DATA.konto_1 b	
--ON  a.konto_id =  b.konto_id
--AND 1 = b.mandant_id
--AND 2 = b.arthiertyp_id
--WHERE a.mandant_id = 1
--GROUP BY 1,2,3,4,5,6,7,10,13
--;
--
--Comment from validation checker
--error line 25 at position 41 unexpected '!'.
--            THEN add_months(cast(a.kjmo ! ^^^> ! '01' as date format 'YYYYMMDD'),1)-1 -1
--syntax error line 25 at position 56 unexpected 'format'.
--            THEN add_months(cast(a.kjmo !! '01' as date  ^^^> format 'YYYYMMDD'),1)-1 -1
--translated statement


INSERT INTO dbp_etl.artbew_abt_sum_work_1 (
    mandant_id, wup_id, nb_id, abt_id, bewart_id, dat, arthiertyp_id,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, kjmo
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.abt_id,
        A.bewart_id,
        CASE
            WHEN T.wtag_id = 7
                THEN DATE_SUB(
                    DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(A.kjmo, '01'))), LAST_DAY(DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), INTERVAL 1 DAY),
                    INTERVAL 1 DAY
                )
            ELSE DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(A.kjmo, '01'))), LAST_DAY(DATE_ADD(DATE(CONCAT(
                A.kjmo,
                '01'
            )), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), INTERVAL 1 DAY)
        END AS dat,
        A.arthiertyp_id,
        SUM(A.umsatz_brutto),
        SUM(A.umsatz_netto),
        A.umsatz_wrg,
        SUM(A.umsatz_brutto_konz),
        SUM(A.umsatz_netto_konz),
        A.kjmo
    FROM dbp_etl.artbew_konto_work_1 AS A
    INNER JOIN dbp_data.tag_1 AS T
        ON DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(
            A.kjmo,
            '01'
        ))), LAST_DAY(DATE_ADD(DATE(CONCAT(A.kjmo, '01')
        ), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01'
        )),
        INTERVAL 1 MONTH)), INTERVAL 1 DAY) = T.dat
    INNER JOIN dbp_data.konto_1 AS B ON A.konto_id = B.konto_id AND 1 = B.mandant_id AND 2 = B.arthiertyp_id
    WHERE A.mandant_id = 1
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.abt_id,
        A.bewart_id,
        dat,
        A.arthiertyp_id,
        A.umsatz_wrg,
        A.kjmo
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_LOAD.artbew_abt_sum_work_1
--  (
--       mandant_id
--      ,wup_id
--      ,nb_id
--      ,abt_id
--      ,bewart_id
--      ,dat
--      ,arthiertyp_id
--      ,umsatz_brutto
--      ,umsatz_netto
--      ,umsatz_wrg 
--      ,umsatz_brutto_konz
--      ,umsatz_netto_konz
--      ,kjmo
--    )
--SELECT 
--       a.mandant_id                        
--      ,a.wup_id
--      ,a.nb_id 
--      ,abt_id
--      ,1001 AS bewart_id 
--      ,CASE 
--         WHEN t.wtag_id = 7 
--            THEN add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 -1
--        ELSE
--            add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1
--       END AS dat             
--      ,a.arthiertyp_id                   
--      ,SUM(a.umsatz_brutto)
--      ,SUM(a.umsatz_netto)                      
--      ,a.umsatz_wrg
--      ,SUM(a.umsatz_brutto_konz)
--      ,SUM(a.umsatz_netto_konz)                
--      ,a.kjmo                                
--FROM DBX_DATA.artbew_wg_sum_1 a
--
--
--INNER JOIN DBX_DATA.wg_per_1	
--ON  a.wg_id = DBX_DATA.wg_per.wg_id
--AND DBX_DATA.wg_per.mandant_id = 1
--AND DBX_DATA.wg_per.arthiertyp_id = 2
--and DBX_DATA.wg_per.dat_bis = 80991231
--
--INNER JOIN DBX_DATA.tag_1 t
--on add_months(cast(a.kjmo !! '01' as date format 'YYYYMMDD'),1)-1 = t.dat
--
--
--WHERE a.mandant_id = 1
--AND a.bewart_id IN (1001,1006)
--AND ( a.wup_id
--     ,a.kjmo)
--  IN
--(
--SELECT   wup_id
--    , kjmo
--FROM DBX_LOAD.artbew_konto_work_1)
--
--GROUP BY 1,2,3,4,5,6,7,10,13
--;
--
--Comment from validation checker
--error line 25 at position 41 unexpected '!'.
--            THEN add_months(cast(a.kjmo ! ^^^> ! '01' as date format 'YYYYMMDD'),1)-1 -1
--syntax error line 25 at position 56 unexpected 'format'.
--            THEN add_months(cast(a.kjmo !! '01' as date  ^^^> format 'YYYYMMDD'),1)-1 -1
--translated statement


INSERT INTO dbp_etl.artbew_abt_sum_work_1 (
    mandant_id, wup_id, nb_id, abt_id, bewart_id, dat, arthiertyp_id,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, kjmo
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        wg_per.abt_id,
        1001 AS bewart_id,
        CASE
            WHEN T.wtag_id = 7
                THEN DATE_SUB(
                    DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(A.kjmo, '01'))), LAST_DAY(DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), INTERVAL 1 DAY),
                    INTERVAL 1 DAY
                )
            ELSE DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(A.kjmo, '01'))), LAST_DAY(DATE_ADD(DATE(CONCAT(
                A.kjmo,
                '01'
            )), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01')), INTERVAL 1 MONTH)), INTERVAL 1 DAY)
        END AS dat,
        A.arthiertyp_id,
        SUM(A.umsatz_brutto),
        SUM(A.umsatz_netto),
        A.umsatz_wrg,
        SUM(A.umsatz_brutto_konz),
        SUM(A.umsatz_netto_konz),
        A.kjmo
    FROM dbp_data.artbew_wg_sum_1 AS A
    INNER JOIN dbp_data.wg_per_1
        ON
            A.wg_id = wg_per.wg_id AND wg_per.mandant_id = 1 AND wg_per.arthiertyp_id
            = 2 AND wg_per.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_1 AS T
        ON DATE_SUB(IF(DATE(CONCAT(A.kjmo, '01')) = LAST_DAY(DATE(CONCAT(
            A.kjmo,
            '01'
        ))), LAST_DAY(DATE_ADD(DATE(CONCAT(A.kjmo, '01')
        ), INTERVAL 1 MONTH)), DATE_ADD(DATE(CONCAT(A.kjmo, '01'
        )),
        INTERVAL 1 MONTH)), INTERVAL 1 DAY) = T.dat
    WHERE
        A.mandant_id = 1
        AND A.bewart_id IN (1001, 1006)
        AND (
            A.wup_id, A.kjmo) IN (
            SELECT (wup_id, kjmo)
            FROM dbp_etl.artbew_konto_work_1
        )
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        wg_per.abt_id,
        bewart_id,
        dat,
        A.arthiertyp_id,
        A.umsatz_wrg,
        A.kjmo
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_1
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.artbew_abt_sum_work_1
) AND bewart_id = 1004;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_wg_sum_1 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
    umsatz_brutto, umsatz_netto, umsatz_wrg, umsatz_brutto_konz, umsatz_netto_konz, quelle, menge
)
(
    SELECT
        A.mandant_id,
        K.nb_id,
        K.arthiertyp_id,
        G.wg_id,
        K.dat,
        K.wup_id,
        K.bewart_id,
        K.kjmo,
        K.umsatz_brutto - A.umsatz_brutto AS umsatz_brutto,
        K.umsatz_netto - A.umsatz_netto AS umsatz_netto,
        K.umsatz_wrg,
        K.umsatz_brutto_konz - A.umsatz_brutto_konz AS umsatz_brutto_konz,
        K.umsatz_netto_konz - A.umsatz_netto_konz AS umsatz_netto_konz,
        8 AS quelle,
        CAST('' AS NUMERIC) AS menge
    FROM dbp_etl.artbew_abt_sum_work_1 AS K
    INNER JOIN dbp_etl.artbew_abt_sum_work_1 AS A
        ON
            K.mandant_id = A.mandant_id AND K.wup_id = A.wup_id AND
            K.abt_id = A.abt_id AND K.dat = A.dat
    INNER JOIN dbp_data.wg_per_1 AS G ON K.mandant_id = G.mandant_id AND K.abt_id = G.abt_id
    WHERE
        K.bewart_id = 1004
        AND A.bewart_id IN (1001)
        AND G.wg_id IN (-200, -100, -10, -20, -30, -40, -50, -60, -70, -80)
        AND G.arthiertyp_id = 2
        AND G.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_PROCESS.artbew_wg_sum_agg_wt_1
--(
--	mandant_id
--	,wup_id
--	,nb_id
--	,dat
--	,calc_fg
--	,dat_lief
--)
--SELECT
--	t1.mandant_id
--	,t1.wup_id
--	,t1.nb_id
--	,t1.dat
--	,3 as calc_fg -- 2 für Umsatzkorrektur
--	,date dat_lief
--FROM
--	DBX_LOAD.artbew_abt_sum_work_1 t1_1
--GROUP BY 
--	t1.mandant_id
--	,t1.wup_id
--	,t1.nb_id
--	,t1.dat
--;
--
--Comment from validation checker
--error line 16 at position 2
--	, ^^^> date dat_lief
--invalid identifier 'DATE'
--translated statement


-- 2 für Umsatzkorrektur
INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_1 (
    mandant_id, wup_id, nb_id,
    dat, calc_fg, dat_lief
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        3 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.artbew_abt_sum_work_1 AS T1_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);
