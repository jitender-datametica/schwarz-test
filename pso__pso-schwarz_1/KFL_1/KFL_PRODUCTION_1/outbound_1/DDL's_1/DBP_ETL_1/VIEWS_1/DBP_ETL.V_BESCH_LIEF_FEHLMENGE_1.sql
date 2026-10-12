CREATE OR REPLACE VIEW kfl_production_dbp_etl.v_besch_lief_fehlmenge_1 (startdatum, endedatum) AS SELECT DATE_SUB(CURRENT_DATE
  ,INTERVAL 182 DAY) AS startdatum,
 CURRENT_DATE AS endedatum;