CREATE OR REPLACE VIEW idq_production_dq_reports.v_dq_rep_ldl_wawi_era_gesellschaft_1 (country_id, calculation_time, land_1
, gesellschaftsbezeichnung, client_id, gesellschaft, artikelnummer, artikelbezeichnung, uwg, artikelfamilie, artikelart
, palletenfaktoren, relevanzkriterien, item_status, geaendert_am, kassensperre, sort_prio) AS SELECT country_id,
 calculation_time,
 land_1,
 gesellschaftsbezeichnung,
 client_id,
 gesellschaft,
 artikelnummer,
 artikelbezeichnung,
 uwg,
 artikelfamilie,
 artikelart,
 palletenfaktoren,
 relevanzkriterien,
 item_status,
 geaendert_am,
 kassensperre,
  CASE
  WHEN item_status = '1'
  THEN 100
  WHEN item_status = '2'
  THEN 200
  WHEN item_status = '3'
  THEN 300
  WHEN item_status = '4'
  THEN 400
  WHEN item_status = '5'
  THEN 500
  WHEN item_status = '6'
  THEN 600
  WHEN item_status = '7'
  THEN 700
  WHEN item_status = '8'
  THEN 800
  WHEN item_status = '9'
  THEN 900
  WHEN item_status = '10'
  THEN 1000
  WHEN item_status = '11'
  THEN 1100
  WHEN item_status = '11.5'
  THEN 1150
  WHEN item_status = '12'
  THEN 1200
  WHEN item_status = '13'
  THEN 1300
  WHEN item_status = '14'
  THEN 1400
  WHEN item_status = '15'
  THEN 1500
  ELSE NULL
  END AS sort_prio
FROM idq_production_dq_reports.dq_rep_ldl_wawi_era_gesellschaft_1;