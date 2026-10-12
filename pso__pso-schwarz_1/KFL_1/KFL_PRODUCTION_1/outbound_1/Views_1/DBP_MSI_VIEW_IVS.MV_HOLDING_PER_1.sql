CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_holding_per_1 AS SELECT V01.mandant_id,
 V01.konzessionaer_id AS holding_id,
  CASE
  WHEN V01.konzessionaer_id = '0'
  THEN 'keine Holding'
  ELSE V01.konzessionaer_name
  END AS holding_name,
 CAST(CASE
   WHEN V01.konzessionaer_id = '0'
   THEN 0
   ELSE 1
   END AS BIGNUMERIC) AS holding_fg,
 V01.dat_von,
 V01.dat_bis,
 V01.land_id,
 V01.konzessionaer_plz AS holding_plz,
 V01.konzessionaer_ort AS holding_ort,
 V01.konzessionaer_strasse AS holding_strasse,
 V01.konzessionaer_rechtsform AS holding_rechtsform,
 V01.dat_insolvenz_eintritt AS holding_dat_insolvenz,
 V01.konzessionaer_topmieter_fg AS holding_topmieter_fg,
 COALESCE(V01.konzessionaer_branche_id, '145') AS holding_branche_id
FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1 AS V01
 INNER JOIN (SELECT mandant_id,
   konzessionaer_holding_id
  FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_1
  WHERE konzessionaer_holding_id <> konzessionaer_gruppe_id
   AND dat_bis = DATE '9999-12-31'
  GROUP BY mandant_id,
   konzessionaer_holding_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.konzessionaer_id = v02.konzessionaer_holding_id
   
WHERE V01.dat_bis = DATE '9999-12-31';