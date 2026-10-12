DROP VIEW kfl_production_dbp_msi_view2.mv_art_vw_list_zu_2;

CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_art_vw_list_zu_2 AS
SELECT
  art_id,
  mandant_id,
  MAX(list_durchg_fg) AS list_durchg_fg
FROM kfl_production_dbp_view.v_sternchen_logik_2 AS lsl
WHERE
  mandant_id = 1 AND CURRENT_DATE BETWEEN dat_von AND dat_bis
GROUP BY
  art_id,
  mandant_id;