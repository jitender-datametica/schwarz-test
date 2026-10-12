CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_WOCHE_1
AS
SELECT
v01.kjwo,
v01.kjwo / 100::INTEGER   AS kj,
MOD( v01.kjwo, 100::INTEGER) AS wo_kj,
v01.akt_wo,
v01.akt_wo_komplett,
v01.wo_dat_von,
v01.wo_dat_bis,
v02.kjwo_vj                   AS kjwo_vj,
v02.kjwo_vj / 100::INTEGER   AS kj_vj,
MOD( v02.kjwo_vj, 100::INTEGER) AS wo_vj,
MOD(v01.kjwo, 100) /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99' NOT SUPPORTED. ***/ || ' (' ||v01.wo_dat_von /*** MSC-WARNING - MSCEWI1033 - FORMAT 'DD.MM.' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ || '-' ||v01.wo_dat_bis /*** MSC-WARNING - MSCEWI1033 - FORMAT 'DD.MM.' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ || ')'::VARCHAR(20) AS wo_von_bis,
MOD(v01.kjwo, 100) /*** MSC-WARNING - MSCEWI2025 - OUTPUT FORMAT '99' NOT SUPPORTED. ***/ || ' (' ||v01.wo_dat_von /*** MSC-WARNING - MSCEWI1033 - FORMAT 'DD.MM.' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ || ')'::VARCHAR(20) AS wo_von,
TO_DATE(SUBSTRING(v01.wo_dat_von, 1, 8) ||'01', 'yyyy-mm_1-dd') AS wo_dat_mo,
wo_kj /*** MSC-WARNING - MSCEWI1033 - FORMAT '99' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ || ' | ' ||wo_vj /*** MSC-WARNING - MSCEWI1033 - FORMAT '99' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/::VARCHAR(20) AS kw_ist_vj
FROM dbp_view.v_woche_1 v01
JOIN
(SELECT
kjwo AS kjwo_vj,
wo_dat_von + 364 AS wo_dat_von_vj
FROM dbp_view.v_woche_1
WHERE akt_wo BETWEEN -623 AND 0
) v02
ON v01.wo_dat_von = v02.wo_dat_von_vj
WHERE v01.akt_wo BETWEEN -571 AND 55;


