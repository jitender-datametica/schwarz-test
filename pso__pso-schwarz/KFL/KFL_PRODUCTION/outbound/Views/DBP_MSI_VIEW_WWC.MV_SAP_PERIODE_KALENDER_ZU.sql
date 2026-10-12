CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_sap_periode_kalender_zu (mandant_id, mandant_kbez, krk_id,
buchungsperiode_id, sap_buchungs_jahr, lfgjamon, lfgjamon_mandt, mandant_lfgjamon, kjmo) AS SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.krk_id,
 V01.buchungsperiode_id,
 V01.sap_buchungs_jahr,
   V01.sap_buchungs_jahr * 100 + V01.buchungsperiode_id AS lfgjamon,
   SUBSTR(CAST(V01.sap_buchungs_jahr * 100 + V01.buchungsperiode_id AS STRING), 1, 6) || ' ' || SUBSTR(CAST(TRIM(V02.mandant_kbez) AS STRING)
   , 1, 2) AS lfgjamon_mandt,
 1 AS mandant_lfgjamon,
 V01.kjmo
FROM kfl_production_dbp_view.v_sap_periode_kalender_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.buchungsperiode_id <= 12
 AND V01.krk_id <> 'DE02';