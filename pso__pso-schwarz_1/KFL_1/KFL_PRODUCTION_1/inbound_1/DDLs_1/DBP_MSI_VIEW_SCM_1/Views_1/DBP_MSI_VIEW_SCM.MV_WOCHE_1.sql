CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WOCHE_1 AS
SELECT
  v01.kjwo
  -- Anpassung für Snowflake, da ursprüngliche TD-Logik so nicht funktioniert
  ,LEFT(v01.kjwo, 4) :: INTEGER AS kj
  ,MOD(v01.kjwo, 100::INTEGER) AS wo_kj
  ,v01.akt_wo
  ,v01.akt_wo_komplett
  ,v01.wo_dat_von
  ,v01.wo_dat_bis
  ,v02.kjwo_vj AS kjwo_vj
  ,v02.kjwo_vj / 100 :: INTEGER AS kj_vj
  ,MOD(v02.kjwo_vj, 100 :: INTEGER) AS wo_vj
  ,LTRIM(TO_VARCHAR(MOD(v01.kjwo, 100), '00')) || ' (' || TO_VARCHAR(v01.wo_dat_von, 'DD.MM.') || '-' || TO_VARCHAR(v01.wo_dat_bis, 'DD.MM.') || ')' AS wo_von_bis
  ,LTRIM(TO_VARCHAR(MOD(v01.kjwo, 100), '00')) || ' (' || TO_VARCHAR(v01.wo_dat_von, 'DD.MM.') || ')' AS wo_von
  ,CAST(
    SUBSTRING(v01.wo_dat_von, 1, 8) || '01' AS VARCHAR
  ) AS wo_dat_mo
  ,TO_VARCHAR(wo_kj, '00') || ' | ' || TO_VARCHAR(wo_vj, '00') :: VARCHAR(20) AS kw_ist_vj
FROM
  dbp_view.v_woche_1 v01
  JOIN (
    SELECT
      kjwo AS kjwo_vj
      ,wo_dat_von + 364 AS wo_dat_von_vj
    FROM
      dbp_view.v_woche_1
    WHERE
      akt_wo BETWEEN -623
      AND 0
  ) v02 ON v01.wo_dat_von = v02.wo_dat_von_vj
WHERE
  v01.akt_wo BETWEEN -571
  AND 55;