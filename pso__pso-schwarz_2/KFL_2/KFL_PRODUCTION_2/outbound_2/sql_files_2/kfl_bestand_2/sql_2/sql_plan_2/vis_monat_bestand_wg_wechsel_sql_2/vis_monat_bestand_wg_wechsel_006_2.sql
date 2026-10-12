--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT t01.mandant_id, t01.art_id, t01.arthiertyp_id
--   ,t01.wg_id (TITLE 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--FROM KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.vis_mon_best_wg_wechsel_tmp_2 t01
--JOIN KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.vis_mon_best_wg_wechsel_tmp_2 t02
--   ON t01.mandant_id = t02.mandant_id
--  AND t01.art_id = t02.art_id
--  AND t01.arthiertyp_id = t02.arthiertyp_id
--WHERE (t01.wg_id <> t02.wg_id)
--  AND t01.alt_neu_kz = -1
--  AND t02.alt_neu_kz = 1
--ORDER BY t01.mandant_id, t01.art_id, t01.arthiertyp_id, t01.wg_id, t02.wg_id
--
----end subquery
--
--);
--
--Comment from validation checker
--error line 5 at position 21 unexpected 'wg_id alt'.
--   ,t01.wg_id (TITLE  ^^^> 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--syntax error line 5 at position 21 unexpected 'wg_id alt'.
--   ,t01.wg_id (TITLE  ^^^> 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--syntax error line 5 at position 45 unexpected '('.
--   ,t01.wg_id (TITLE 'wg_id alt'), t02.wg_id  ^^^> (TITLE 'wg_id neu')
--syntax error line 18 at position 0 unexpected ')'.
-- ^^^> );
--translated statement


SELECT COUNT(*)
FROM (
    SELECT
        T01.mandant_id,
        T01.art_id,
        T01.arthiertyp_id,
        T01.wg_id,
        T02.wg_id AS wg_id0
    FROM dbp_etl.vis_mon_best_wg_wechsel_tmp_2 AS T01
    INNER JOIN dbp_etl.vis_mon_best_wg_wechsel_tmp_2 AS T02
        ON
            T01.mandant_id = T02.mandant_id AND T01.art_id
            = T02.art_id AND T01.arthiertyp_id = T02.arthiertyp_id
    WHERE
        T01.wg_id <> T02.wg_id
        AND T01.alt_neu_kz = -1
        AND T02.alt_neu_kz = 1
    ORDER BY
        T01.mandant_id NULLS LAST,
        T01.art_id NULLS LAST,
        T01.arthiertyp_id NULLS LAST,
        T01.wg_id NULLS LAST,
        wg_id0 NULLS LAST
) AS t1_2;
--end subquery
