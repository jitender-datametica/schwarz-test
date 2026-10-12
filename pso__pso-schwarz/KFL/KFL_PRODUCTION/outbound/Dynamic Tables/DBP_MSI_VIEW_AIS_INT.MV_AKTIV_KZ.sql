CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ais_int.mv_aktiv_kz (
  mandant_id BIGNUMERIC(38, 0),
  aktiv_kz STRING(1)
) AS
SELECT
  mandant_id, 
  aktiv_kz
FROM (
  SELECT
    v01.mandant_id,
    COALESCE(CASE WHEN COUNT(v02.wup_id) > 0 THEN 'X' ELSE NULL END, '') AS aktiv_kz
  FROM kfl_production_dbp_view.v_art AS v01
  LEFT JOIN kfl_production_dbp_view.v_art_list_wup_zu_per AS v02
    ON v01.mandant_id = v02.mandant_id
    AND v01.art_id = v02.art_id
    AND v02.dat_von <= CURRENT_DATE
    AND v02.dat_bis >= CURRENT_DATE
  GROUP BY
    v01.mandant_id,
    v01.art_id
) AS a
GROUP BY
  mandant_id,
  aktiv_kz;