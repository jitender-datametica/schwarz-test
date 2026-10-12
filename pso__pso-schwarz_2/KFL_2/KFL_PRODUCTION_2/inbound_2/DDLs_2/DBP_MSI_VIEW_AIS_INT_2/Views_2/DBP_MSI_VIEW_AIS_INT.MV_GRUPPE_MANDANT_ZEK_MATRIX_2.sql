CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_MANDANT_ZEK_MATRIX_2
-- Erweiterung um Dummywert loesch_fg - AblÃ¶se Writeback - sschuecke 11.09.2014
-- Ã×nderung Wegfall Dialogtabelle und Vereinfachung Pflege - cbru1709 09.05.2018
(
  gruppe_id
, mandant_id
, zek_id
, PflegeFlag
) AS

SELECT 
  gruppe_id
, mandant_id
, zek_id
, (CASE WHEN (SELECT COUNT(*) FROM dbp_security.gruppe_zek_zu_2 x
WHERE x.gruppe_id = cx.gruppe_id AND x.zek_id = cx.zek_id AND x.mandant_id = cx.mandant_id) > 0
THEN 1 ELSE 0 END) AS PflegeFlag

FROM (
SELECT v01.gruppe_id
, v03.mandant_id
, v02.zek_id


FROM ( dbp_security.gruppe_2 v01
CROSS JOIN dbp_msi_view_ais_int.mv_zek_security_2 v02 )
JOIN dbp_msi_view_ais_int.mv_mandant_2 v03
ON (v02.mandant_id = v03.mandant_id)

--Ausschluss der DUMMY_2-ID 0
WHERE v01.gruppe_id <> 0
--Ausschluss von Elterngruppen
AND v01.gruppe_id NOT IN (SELECT v02.gruppe_parent_id FROM dbp_security.gruppe_gruppe_zu_2 v02)

--AP0172759/SPEC0207789 Umstellung zek_id auf VARCHAR(3) / sschuecke 30.10.2023
--Ausschluss der DUMMY_2-ID 99
AND v02.zek_id <> '999') cx

UNION

SELECT v01.gruppe_id
, v02.mandant_id
, '-1' AS zek_id
, 0 AS PflegeFlag

FROM dbp_security.gruppe_2 v01
CROSS JOIN dbp_msi_view_ais_int.mv_mandant_2 v02
WHERE v01.gruppe_id <> 0
AND v01.gruppe_id NOT IN (SELECT gruppe_id FROM dbp_security.gruppe_zek_zu_2 WHERE alle_zek_fg = 1 AND zek_id = '-1')
--Ausschluss von Elterngruppen
AND v01.gruppe_id NOT IN (SELECT gruppe_parent_id FROM dbp_security.gruppe_gruppe_zu_2);