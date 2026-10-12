--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT t01.mandant_id, t01.art_id, t01.arthiertyp_id
--   ,t01.wg_id (TITLE 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--FROM DBX_LOAD.vis_tag_best_wg_wechsel_tmp_2 t01
--JOIN DBX_LOAD.vis_tag_best_wg_wechsel_tmp_2 t02
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
--error line 5 at position 21 unexpected ''wg_id alt''.
--   ,t01.wg_id (TITLE  ^^^> 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--syntax error line 5 at position 21 unexpected ''wg_id alt''.
--   ,t01.wg_id (TITLE  ^^^> 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
--syntax error line 5 at position 45 unexpected '('.
--   ,t01.wg_id (TITLE 'wg_id alt'), t02.wg_id  ^^^> (TITLE 'wg_id neu')
--syntax error line 18 at position 0 unexpected ')'.
-- ^^^> );
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT t01.mandant_id, t01.art_id, t01.arthiertyp_id
   ,t01.wg_id (TITLE 'wg_id alt'), t02.wg_id (TITLE 'wg_id neu')
FROM DBP_ETL.vis_tag_best_wg_wechsel_tmp_2 t01
JOIN DBP_ETL.vis_tag_best_wg_wechsel_tmp_2 t02
   ON t01.mandant_id = t02.mandant_id
  AND t01.art_id = t02.art_id
  AND t01.arthiertyp_id = t02.arthiertyp_id
WHERE (t01.wg_id <> t02.wg_id)
  AND t01.alt_neu_kz = -1
  AND t02.alt_neu_kz = 1
ORDER BY t01.mandant_id, t01.art_id, t01.arthiertyp_id, t01.wg_id, t02.wg_id

--end subquery

);

