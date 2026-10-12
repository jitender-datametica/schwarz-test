-- Erweiterung um Dummywert loesch_fg - AblÃ¶se Writeback - sschuecke 11.09.2014
-- Ã×nderung Wegfall Dialogtabelle und Vereinfachung Pflege - cbru1709 09.05.2018
CREATE OR REPLACE VIEW `kfl_production_dbp_msi_view_ais_int.mv_gruppe_mandant_zek_matrix`
AS
SELECT 
  cx.gruppe_id,
  cx.mandant_id,
  cx.zek_id,
  
  (CASE 
    WHEN (
      SELECT COUNT(*) 
      FROM `kfl_production_dbp_security.gruppe_zek_zu` AS x
      WHERE x.gruppe_id = cx.gruppe_id 
        AND x.zek_id = cx.zek_id 
        AND x.mandant_id = cx.mandant_id
    ) > 0 THEN 1 
    ELSE 0 
  END) AS PflegeFlag
FROM (
  SELECT 
    v01.gruppe_id,
    v03.mandant_id,
    v02.zek_id
  FROM `kfl_production_dbp_security.gruppe` AS v01
  CROSS JOIN `kfl_production_dbp_msi_view_ais_int.mv_zek_security` AS v02
  JOIN `kfl_production_dbp_msi_view_ais_int.mv_mandant` AS v03
    ON v02.mandant_id = v03.mandant_id

    --Ausschluss der DUMMY-ID 0
  WHERE v01.gruppe_id <> 0

--Ausschluss von Elterngruppen    
    AND v01.gruppe_id NOT IN (
      SELECT gruppe_parent_id 
      FROM `kfl_production_dbp_security.gruppe_gruppe_zu`
    )
--AP0172759/SPEC0207789 Umstellung zek_id auf STRING(3) / sschuecke 30.10.2023
--Ausschluss der DUMMY-ID 99    
    AND v02.zek_id <> '999'
) AS cx

UNION ALL

SELECT 
  v01.gruppe_id,
  v02.mandant_id,
  '-1' AS zek_id,
  0 AS PflegeFlag
FROM `kfl_production_dbp_security.gruppe` AS v01
CROSS JOIN `kfl_production_dbp_msi_view_ais_int.mv_mandant` AS v02
WHERE v01.gruppe_id <> 0
  AND v01.gruppe_id NOT IN (
    SELECT gruppe_id 
    FROM `kfl_production_dbp_security.gruppe_zek_zu` 
    WHERE alle_zek_fg = 1 AND zek_id = '-1'
  )
--Ausschluss von Elterngruppen
  AND v01.gruppe_id NOT IN (
    SELECT gruppe_parent_id 
    FROM `kfl_production_dbp_security.gruppe_gruppe_zu`
  );