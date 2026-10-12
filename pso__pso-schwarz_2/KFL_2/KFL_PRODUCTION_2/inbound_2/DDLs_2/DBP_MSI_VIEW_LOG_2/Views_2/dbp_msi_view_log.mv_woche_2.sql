CREATE OR REPLACE VIEW dbp_msi_view_log.mv_woche_2
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 kjwo
,kj
,wo_kj
,akt_wo
,akt_wo_komplett
,wo_dat_von
,wo_dat_bis
,kjwo_vj
,kj_vj
,wo_vj
,wo_von_bis
,wo_von
,wo_dat_mo
,kw_ist_vj
,kjwo_bez
,kjwo_bez2
)
AS
SELECT
v01.kjwo,
CAST(v01.kjwo / 100 AS INTEGER) AS kj,
CAST(MOD(v01.kjwo, 100) AS INTEGER) AS wo_kj,
v01.akt_wo,
v01.akt_wo_komplett,
v01.wo_dat_von,
v01.wo_dat_bis,
v02.kjwo_vj                   AS kjwo_vj,
CAST(v02.kjwo_vj / 100 AS INTEGER)   AS kj_vj,
CAST(MOD(v02.kjwo_vj, 100 ) AS INTEGER) AS wo_vj,
CAST(TO_VARCHAR(MOD(v01.kjwo,100), '00') || ' (' ||   TO_VARCHAR(v01.wo_dat_von, 'DD.MM.') || '-' ||   TO_VARCHAR(v01.wo_dat_bis,'DD.MM.') || ')' AS VARCHAR(20)) AS wo_von_bis,
Cast(TO_VARCHAR(MOD(v01.kjwo, 100), '00') || ' (' ||   TO_VARCHAR(v01.wo_dat_von, 'DD.MM.') || ')' AS VARCHAR(20)) AS wo_von,
TO_DATE(Substring(v01.wo_dat_von, 1 , 8) || '01', 'yyyy-mm_2-dd') AS wo_dat_mo,
Cast(TO_VARCHAR(wo_kj, '00') || ' | ' || TO_VARCHAR(wo_vj, '00') AS VARCHAR(20)) AS kw_ist_vj,
-- war bisher (in SCM) innerhalb des Attributes Kalenderwoche mit ApplySimple oder anderer Funktion umgesetzt
Cast('KW'AS CHAR(2))|| ' ' || RIGHT(v01.kjwo,2) ||'/'|| LEFT(v01.kjwo, 4) AS kjwo_bez,
Trim(kj) ||' '||wo_von_bis AS kjwo_bez2
FROM dbp_view.v_woche_2 v01
INNER JOIN (SELECT
kjwo AS kjwo_vj,
wo_dat_von + 364 AS wo_dat_von_vj
FROM dbp_view.v_woche_2
            WHERE akt_wo BETWEEN -623 AND 0
           ) v02
ON v01.wo_dat_von = v02.wo_dat_von_vj
WHERE v01.akt_wo BETWEEN -571 AND 55;
