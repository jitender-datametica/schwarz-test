CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_auftraggeber_2 (auftraggeber_id, mandant_id, nb_id,
auftraggeber_bez, vs_id, wup_typ_id, vkl_id, dat_bis, breitengrad, laengengrad) AS SELECT CAST(wup_id AS STRING) AS
 auftraggeber_id,
 mandant_id,
 nb_id,
  CASE
  WHEN nb_id = - 1
  THEN '---'
  ELSE wup_standort
  END AS auftraggeber_bez,
 vs_id,
 wup_typ_id,
 vkl_id,
 dat_bis,
 breitengrad,
 laengengrad
FROM kfl_production_dbp_view.v_wup_2
WHERE nb_id IN (0, 99, 2, - 111) AND wup_id > 0
 OR nb_id = - 1 AND wup_id = 0
UNION ALL
SELECT CAST(REPLACE(kunde_nr, '0000', '000') AS STRING) AS auftraggeber_id,
 mandant_id,
 0 AS nb_id,
 kunde_name AS auftraggeber_bez,
 0 AS vs_id,
 0 AS wup_typ_id,
 - 1 AS vkl_id,
 DATE('9999-12-31') AS dat_bis,
 CAST(NULL AS BIGNUMERIC) AS breitengrad,
 CAST(NULL AS BIGNUMERIC) AS laengengrad
FROM kfl_production_dbp_view.v_in_kunde_2
WHERE mandant_id = 1
 AND (SUBSTR(kunde_nr, 1, 5) = '97000' OR SUBSTR(kunde_nr, 1, 5) = '94000');