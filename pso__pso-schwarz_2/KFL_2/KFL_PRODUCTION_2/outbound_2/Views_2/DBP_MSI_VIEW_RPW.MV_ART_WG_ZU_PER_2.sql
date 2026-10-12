CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_art_wg_zu_per_2 (art_id, mandant_id, wug_id, wg_id, dat_von,
arthiertyp_id, dat_bis, system_id) AS (((SELECT art_id,
    mandant_id,
    wug_id,
    wg_id,
    dat_von,
    arthiertyp_id,
    dat_bis,
    7 AS system_id
   FROM kfl_production_dbp_view.v_art_wg_zu_per_2
   WHERE mandant_id = 1
    AND arthiertyp_id = 2
    AND dat_bis = DATE '9999-12-31'
   UNION DISTINCT
   SELECT art_id - 1 AS art_id,
    mandant_id,
    wug_id,
    wg_id,
    dat_von,
    arthiertyp_id,
    dat_bis,
    7 AS system_id
   FROM kfl_production_dbp_view.v_art_wg_zu_per_2
   WHERE mandant_id = 1
    AND arthiertyp_id = 2
    AND dat_bis = DATE '9999-12-31'
    AND art_id BETWEEN - 999000 AND (- 1000))
  UNION DISTINCT
  SELECT art_id - 2 AS art_id,
   mandant_id,
   wug_id,
   wg_id,
   dat_von,
   arthiertyp_id,
   dat_bis,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_wg_zu_per_2
  WHERE mandant_id = 1
   AND arthiertyp_id = 2
   AND dat_bis = DATE '9999-12-31'
   AND art_id BETWEEN - 999000 AND (- 1000))
 UNION DISTINCT
 SELECT art_id - 3 AS art_id,
  mandant_id,
  wug_id,
  wg_id,
  dat_von,
  arthiertyp_id,
  dat_bis,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_wg_zu_per_2
 WHERE mandant_id = 1
  AND arthiertyp_id = 2
  AND dat_bis = DATE '9999-12-31'
  AND art_id BETWEEN - 999000 AND (- 1000))
UNION DISTINCT
SELECT art_id - 9 AS art_id,
 mandant_id,
 wug_id,
 wg_id,
 dat_von,
 arthiertyp_id,
 dat_bis,
 7 AS system_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND art_id BETWEEN - 999000 AND (- 1000);