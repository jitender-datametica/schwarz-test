CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_bau_gv_per_1 (projekt_id, projekt_nr, dat_von, bau_gv_dok_id
, dat_bis, dok_ersteller_name, datzeit_erstellung, dok_aenderer_name, datzeit_aenderung, dok_gueltig_bis,
dok_aktenzeichen, dok_dat_eingang, dokumentart_bez, dokument_unterart_bez, dok_relevanz_kz, cpr_systemstatus1_id,
bau_gv_abgebrochen, aktuelles_datum, mandant_id) AS SELECT V01.projekt_id,
 V02.cpr_ext_id AS projekt_nr,
 V01.dat_von,
 V01.bau_gv_dok_id,
 V01.dat_bis,
 V01.dok_ersteller_name,
 V01.datzeit_erstellung,
 V01.dok_aenderer_name,
 V01.datzeit_aenderung,
 V01.dok_gueltig_bis,
 V01.dok_aktenzeichen,
 V01.dok_dat_eingang,
 V01.dokumentart_bez,
 V01.dokument_unterart_bez,
 V01.dok_relevanz_kz,
 COALESCE(V02.cpr_systemstatus1_id, 4) AS cpr_systemstatus1_id,
  CASE
  WHEN (V02.cpr_systemstatus1_id IS NULL OR V02.cpr_systemstatus1_id = 4) AND V01.dok_gueltig_bis > CURRENT_DATE
  THEN 1
  ELSE 0
  END AS bau_gv_abgebrochen,
 CURRENT_DATE AS aktuelles_datum,
 V02.mandant_id
FROM kfl_production_dbp_view.v_cpr_bau_gv_per_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS V02 ON V01.projekt_id = V02.projekt_id AND V02.dat_bis =
   DATE '9999-12-31'
WHERE V01.dok_ordner_id <> 'X'
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.dok_status_id = 'E0001';