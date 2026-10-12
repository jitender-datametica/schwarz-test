--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DEL FROM DBX_DATA.art_art_gruppe_flw_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_DATA.art_art_gruppe_flw_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.art_art_gruppe_flw_1
--SELECT
--t2.mandant_id,
--t2.art_id,
--Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t0.art_attribut_id ELSE '-' END) AS art_gruppe_id,
--Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt / not maintained' END) AS art_gruppe_bez,
--Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t0.art_attribut_id ELSE '-' END) AS art_klasse_id,
--Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_klasse_bez,
--Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t0.art_attribut_id ELSE '-' END) AS art_rohstoff_id,
--Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_rohstoff_bez
--FROM DBX_DATA.art_1 t2
--
--LEFT JOIN DBX_DATA.art_gruppe_attribut_zu_1 t0
--ON t2.mandant_id=t0.mandant_id
--AND t2.art_id=t0.art_id
--
--LEFT JOIN DBX_DATA.art_attribut_spr_zu_1 t1_1
--ON t0.art_attribut_id=t1.art_attribut_id
--
--WHERE t2.loesch_id <> 'L'
--AND (t2.mandant_id, t2.art_id) IN (sel mandant_id, art_id from DBX_DATA.art_wg_zu_per_1 where dat_bis=80991231 and (mandant_id, art_id) in ( SEL mandant_id, art_id FROM DBX_DATA.art_gruppe_attribut_zu_1))
--GROUP BY 1,2;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_DATA.art_art_gruppe_flw_1
SELECT
t2.mandant_id,
t2.art_id,
Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t0.art_attribut_id ELSE '-' END) AS art_gruppe_id,
Max(CASE WHEN t0.art_gruppe_id='FL001' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt / not maintained' END) AS art_gruppe_bez,
Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t0.art_attribut_id ELSE '-' END) AS art_klasse_id,
Max(CASE WHEN t0.art_gruppe_id='FL003' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_klasse_bez,
Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t0.art_attribut_id ELSE '-' END) AS art_rohstoff_id,
Max(CASE WHEN t0.art_gruppe_id='FL002' THEN t1.art_attribut_bez ELSE '-/nicht gepflegt/not maintained' END) AS art_rohstoff_bez,
localtimestamp as td_insert,
localtimestamp as td_update
FROM DBP_DATA.art_1 t2

LEFT JOIN DBP_DATA.art_gruppe_attribut_zu_1 t0
ON t2.mandant_id=t0.mandant_id
AND t2.art_id=t0.art_id

LEFT JOIN DBP_DATA.art_attribut_spr_zu_1 t1_1
ON t0.art_attribut_id=t1.art_attribut_id

WHERE --t2.loesch_id <> 'L' NSR4462627
(t2.mandant_id, t2.art_id) IN (SELECT mandant_id, art_id from DBP_DATA.art_wg_zu_per_1 where dat_bis= to_date('9999-12-31','YYYY-MM_1-DD') and (mandant_id, art_id) in ( SELECT mandant_id, art_id FROM DBP_DATA.art_gruppe_attribut_zu_1))
GROUP BY 1,2;

