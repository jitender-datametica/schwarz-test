CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_AGGREGAT_SPR_ZU_1
AS
-- SPRACHE Bezeichnungen fuer Gesamt - Bereich - Detail
-- Denormaliserte Variante >> Internationalisierung : Gesamt anzupassen!
-- 20120126 Initial
-- 20120213 Optimierung + Erweiterung Grund
-- 20120416 Anpassung Grund + Ebenen
-- 2014KW20 : Performance Teil 1 (UNION reduziert, JOIN mandant_ebene)
-- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

SELECT
-- Ebene 2x : Detail
s01.mandant_id, s02.sb_ebene, s01.beurteilung_detail_id             AS sb_id, MAX(CASE WHEN s01.spr_id =  22 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez      --standard=deutsch
, MAX(CASE WHEN s01.spr_id =  22 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_de   --deutsch
, MAX(CASE WHEN s01.spr_id = 124 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_cz   --tschechisch
, MAX(CASE WHEN s01.spr_id =  90 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_pl   --polnisch
, MAX(CASE WHEN s01.spr_id = 108 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_sk   --slowakisch
, MAX(CASE WHEN s01.spr_id =  65 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_hr   --kroatisch
, MAX(CASE WHEN s01.spr_id =  95 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_ro   --rumänisch
, MAX(CASE WHEN s01.spr_id =  18 THEN s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez_bg   --bulgarisch
, MAX(CASE WHEN spr_id =  22 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2     --standard=deutsch
, MAX(CASE WHEN spr_id =  22 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_de  --deutsch
, MAX(CASE WHEN spr_id = 124 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_cz  --tschechisch
, MAX(CASE WHEN spr_id =  90 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_pl  --polnisch
, MAX(CASE WHEN spr_id = 108 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_sk  --slowakisch
, MAX(CASE WHEN spr_id =  65 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_hr  --kroatisch
, MAX(CASE WHEN spr_id =  95 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_ro  --rumänisch
, MAX(CASE WHEN spr_id =  18 THEN '   - ' || s01.beurteilung_detail_bez ELSE NULL END) AS sb_bez2_bg  --bulgarisch
FROM dbp_view.v_sb_beurteil_detail_spr_zu_1 s01
JOIN dbp_view.v_sb_mandant_ebene_1 s02
ON s01.mandant_id = s02.mandant_id
AND s02.sb_ebene IN (20,21,22)
GROUP BY
s01.mandant_id
,s02.sb_ebene
,s01.beurteilung_detail_id
UNION ALL
-- Ebene 1x : Bereich
SELECT
s01.mandant_id, s02.sb_ebene, s01.beurteilung_bereich_id          AS sb_id, MAX(CASE WHEN s01.spr_id =  22 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez      --standard=deutsch
, MAX(CASE WHEN s01.spr_id =  22 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_de   --deutsch
, MAX(CASE WHEN s01.spr_id = 124 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_cz   --tschechisch
, MAX(CASE WHEN s01.spr_id =  90 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_pl   --polnisch
, MAX(CASE WHEN s01.spr_id = 108 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_sk   --slowakisch
, MAX(CASE WHEN s01.spr_id =  65 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_hr   --kroatisch
, MAX(CASE WHEN s01.spr_id =  95 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_ro   --rumänisch
, MAX(CASE WHEN s01.spr_id =  18 THEN s01.beurteilung_bereich_bez   ELSE NULL END) AS sb_bez_bg   --bulgarisch
, MAX(CASE WHEN spr_id =  22 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2     --standard=deutsch
, MAX(CASE WHEN spr_id =  22 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_de  --deutsch
, MAX(CASE WHEN spr_id = 124 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_cz  --tschechisch
, MAX(CASE WHEN spr_id =  90 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_pl  --polnisch
, MAX(CASE WHEN spr_id = 108 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_sk  --slowakisch
, MAX(CASE WHEN spr_id =  65 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_hr  --kroatisch
, MAX(CASE WHEN spr_id =  95 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_ro  --rumänisch
, MAX(CASE WHEN spr_id =  18 THEN  '  ' || s01.beurteilung_bereich_bez  ELSE NULL END) AS sb_bez2_bg  --bulgarisch
FROM dbp_view.v_sb_beurteil_bereich_spr_zu_1 s01
JOIN dbp_view.v_sb_mandant_ebene_1 s02
ON s01.mandant_id = s02.mandant_id
AND s02.sb_ebene IN (10,11,12)
GROUP BY
s01.mandant_id
,s02.sb_ebene
,s01.beurteilung_bereich_id
UNION ALL
-- Ebene 0x : Gesamt
SELECT
s02.mandant_id, s02.sb_ebene, -1::INTEGER       AS sb_id, 'Gesamt'           AS sb_bez, 'Gesamt'           AS sb_bez_de, 'Celkem'           AS sb_bez_cz, 'Suma'           AS sb_bez_pl, 'Celkom'           AS sb_bez_sk, 'Ukupno'           AS sb_bez_hr, 'Total'          AS sb_bez_ro, /*_UNICODE '041E04310449043E'xcv */ '' AS sb_bez_bg, 'Gesamt'           AS sb_bez2, 'Gesamt'           AS sb_bez2_de
, 'Celkem'           AS sb_bez2_cz, 'Suma'           AS sb_bez2_pl, 'Celkom'           AS sb_bez2_sk, 'Ukupno'           AS sb_bez2_hr, 'Total'          AS sb_bez2_ro, /*_UNICODE '041E04310449043E'xcv */ '' AS sb_bez2_bg
FROM dbp_view.v_sb_mandant_ebene_1 s02
WHERE
s02.sb_ebene IN (0,1,2);