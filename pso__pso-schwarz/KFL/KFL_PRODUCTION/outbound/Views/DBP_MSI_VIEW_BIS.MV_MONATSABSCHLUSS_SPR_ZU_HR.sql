CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_monatsabschluss_spr_zu_hr AS SELECT v01.kj_ker_mo_id AS
 kjmo_abschluss,
   TRIM(V03.mo_bez) || ' ' || CAST(TRIM(SUBSTR(CAST(V02.kj AS STRING), 1, 39)) AS STRING) AS mo_bez_lang
FROM (SELECT MAX(kj_ker_mo_id) AS kj_ker_mo_id
  FROM kfl_production_dbp_view.v_l_buchungsstatus_ker AS V01
  WHERE dat_buchungs_schluss < DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)) AS v01
 INNER JOIN kfl_production_dbp_view.v_monat AS V02 ON v01.kj_ker_mo_id = V02.kjmo
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu AS V03 ON V02.mo_kj = V03.mo_id AND V03.spr_id = 65;