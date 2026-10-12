CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tp_objekt_per (mandant_id, tp_objekt_id, dat_von,
techn_platz_id, dat_bis, tp_objekt_typ, hersteller_name, hersteller_land_id, hersteller_typ_bez, hersteller_serial_id,
bau_kj, bau_kjmo, bau_mo, bau_date, dat_gewaehrleistung_start, dat_gewaehrleistung_start_bez, dat_gewaehrleistung_ende,
dat_gewaehrleistung_ende_bez, tp_objekt_nr, werk_id) AS SELECT TP_O_PER.mandant_id,
 TP_O_PER.tp_objekt_id,
 TP_O_PER.dat_von,
 TP_O_PER.techn_platz_id,
 TP_O_PER.dat_bis,
 TP_O_PER.tp_objekt_typ,
 TP_O_PER.hersteller_name,
 TP_O_PER.hersteller_land_id,
 TP_O_PER.hersteller_typ_bez,
 TP_O_PER.hersteller_serial_id,
 IF(TP_O_PER.bau_kj = 0, NULL, TP_O_PER.bau_kj) AS bau_kj,
 TP_O_PER.bau_kjmo,
  CASE
  WHEN LENGTH(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39)) = 6
  THEN RIGHT(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39), 2)
  ELSE NULL
  END AS bau_mo,
  CASE
  WHEN LENGTH(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39)) = 6
  THEN CASE
   WHEN RIGHT(SUBSTR(CAST(TP_O_PER.bau_kjmo AS STRING), 1, 39), 2) = '00'
   THEN NULL
   ELSE DATE(CONCAT(TP_O_PER.bau_kjmo, '01'))
   END
  ELSE NULL
  END AS bau_date,
 TP_O_PER.dat_gewaehrleistung_start,
  CASE
  WHEN TP_O_PER.dat_gewaehrleistung_start = DATE '1900-01-01'
  THEN NULL
  ELSE TP_O_PER.dat_gewaehrleistung_start
  END AS dat_gewaehrleistung_start_bez,
 TP_O_PER.dat_gewaehrleistung_ende,
  CASE
  WHEN TP_O_PER.dat_gewaehrleistung_ende = DATE '1900-01-01'
  THEN NULL
  ELSE TP_O_PER.dat_gewaehrleistung_ende
  END AS dat_gewaehrleistung_ende_bez,
 TP_O_PER.tp_objekt_nr,
 IN_W.werk_id
FROM kfl_production_dbp_view.v_tp_objekt_per AS TP_O_PER
 INNER JOIN kfl_production_dbp_view.v_techn_platz_per AS TECH_PL ON TP_O_PER.mandant_id = TECH_PL.mandant_id AND
    TP_O_PER.techn_platz_id = TECH_PL.techn_platz_id AND TECH_PL.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_in_werk AS IN_W ON TECH_PL.mandant_id = IN_W.mandant_id AND TECH_PL.werk_instandhaltung_plan
    = IN_W.werk_nr
WHERE TP_O_PER.dat_bis = DATE '9999-12-31';