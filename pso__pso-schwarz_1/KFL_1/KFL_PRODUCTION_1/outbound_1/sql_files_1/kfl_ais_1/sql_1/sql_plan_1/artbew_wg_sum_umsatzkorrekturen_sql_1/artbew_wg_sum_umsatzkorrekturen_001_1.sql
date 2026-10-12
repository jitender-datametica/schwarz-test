--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_1
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.artbew_abt_sum_tag_work_1
) AND bewart_id = 1006;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.artbew_wg_sum_1 (
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
        K.nb_id,
        K.arthiertyp_id,
        G.wg_id,
        K.dat,
        K.wup_id,
        K.bewart_id,
        T.kjmo,
        K.umsatz_brutto - A.umsatz_brutto AS umsatz_brutto,
        K.umsatz_netto - A.umsatz_netto AS umsatz_netto,
        K.umsatz_wrg,
        K.umsatz_brutto_konz - A.umsatz_brutto_konz AS umsatz_brutto_konz,
        K.umsatz_netto_konz - A.umsatz_netto_konz AS umsatz_netto_konz,
        8 AS quelle,
        CAST('' as numeric) AS menge
    FROM dbp_etl.artbew_abt_sum_tag_work_1 AS K
    INNER JOIN dbp_etl.artbew_abt_sum_tag_work_1 AS A
        ON
            K.mandant_id = A.mandant_id AND K.wup_id = A.wup_id
            AND K.abt_id = A.abt_id AND K.dat = A.dat
    INNER JOIN dbp_data.tag_1 AS T ON K.dat = T.dat
    INNER JOIN
        dbp_data.wg_per_1 AS G
        ON K.mandant_id = G.mandant_id AND K.abt_id = G.abt_id
    WHERE
        K.bewart_id = 1006
        AND A.bewart_id = 1001
        AND G.wg_id IN (-200, -100, -10, -20, -30, -40, -50, -60, -70, -80)
        AND G.arthiertyp_id = 2
        AND G.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_wg_sum_1
WHERE
    bewart_id = 1006
    AND umsatz_brutto BETWEEN -1 AND 1
    AND umsatz_netto BETWEEN -1 AND 1
    AND dat BETWEEN DATE_SUB(
        CURRENT_DATE("Europe/Berlin"),
        INTERVAL 10 DAY
    ) AND (CURRENT_DATE("Europe/Berlin")
    );


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO KFL_PRODUCTION.${DWH_COMMON_DBX_PROCESS}.artbew_wg_sum_agg_wt_1
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
--	KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.artbew_abt_sum_tag_work_1 t1_1
--GROUP BY 
--	 t1.mandant_id
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
    FROM dbp_etl.artbew_abt_sum_tag_work_1 AS T1_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);
