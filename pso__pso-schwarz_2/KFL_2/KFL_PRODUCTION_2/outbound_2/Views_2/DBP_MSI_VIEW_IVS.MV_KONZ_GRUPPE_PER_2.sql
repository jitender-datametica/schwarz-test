CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_konz_gruppe_per_2 AS SELECT V01.mandant_id,
 COALESCE(V01.konzessionaer_gruppe_id, '0') AS konz_gruppe_id,
 kfl_production_dbp_process.transcriptc(COALESCE(V01.konzessionaer_name, v02.konz_gruppe_name, '')) AS konz_gruppe_name,
 COALESCE(v02.holding_id, '0') AS holding_id,
 COALESCE(v02.konz_gruppe_anz, 0) AS konz_gruppe_anz,
 V01.dat_von,
 V01.dat_bis,
 V01.land_id,
 COALESCE(v02.konz_gruppe_plz, V01.konzessionaer_plz) AS konz_gruppe_plz,
 kfl_production_dbp_process.transcriptc(COALESCE(v02.konz_gruppe_ort, V01.konzessionaer_ort)) AS konz_gruppe_ort,
 kfl_production_dbp_process.transcriptc(COALESCE(v02.konz_gruppe_strasse, V01.konzessionaer_strasse)) AS konz_gruppe_strasse,
 COALESCE(v02.konz_gruppe_rechtsform, V01.konzessionaer_rechtsform) AS konz_gruppe_rechtsform,
 COALESCE(v02.konz_gruppe_dat_insolvenz, V01.dat_insolvenz_eintritt) AS konz_gruppe_dat_insolvenz,
 COALESCE(v02.konz_gruppe_topmieter_fg, V01.konzessionaer_topmieter_fg) AS konz_gruppe_topmieter_fg,
 COALESCE(v02.konz_gruppe_branche_id, V01.konzessionaer_branche_id, '000') AS konz_gruppe_branche_id
FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_2 AS V01
 LEFT JOIN (SELECT mandant_id,
   konzessionaer_gruppe_id AS konz_gruppe_id,
    CASE
    WHEN konzessionaer_holding_id <> konzessionaer_gruppe_id
    THEN konzessionaer_holding_id
    ELSE '0'
    END AS holding_id,
   MAX(konzessionaer_name) AS konz_gruppe_name,
   COUNT(konzessionaer_id) AS konz_gruppe_anz,
   MAX(konzessionaer_plz) AS konz_gruppe_plz,
   MAX(konzessionaer_ort) AS konz_gruppe_ort,
   MAX(konzessionaer_strasse) AS konz_gruppe_strasse,
   MAX(konzessionaer_rechtsform) AS konz_gruppe_rechtsform,
   MAX(dat_insolvenz_eintritt) AS konz_gruppe_dat_insolvenz,
   MAX(konzessionaer_topmieter_fg) AS konz_gruppe_topmieter_fg,
   MAX(konzessionaer_branche_id) AS konz_gruppe_branche_id
  FROM kfl_production_dbp_view.v_ivs_konzessionaer_per_2
  WHERE dat_bis = DATE '9999-12-31'
   AND konzessionaer_gruppe_id <> konzessionaer_id
   AND konzessionaer_id <> '0'
  GROUP BY mandant_id,
   konz_gruppe_id,
   holding_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.konzessionaer_gruppe_id = v02.konz_gruppe_id
WHERE V01.dat_bis = DATE '9999-12-31'
 AND (V01.konzessionaer_gruppe_id = V01.konzessionaer_id OR V01.konzessionaer_id = '0');