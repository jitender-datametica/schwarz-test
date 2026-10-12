CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rohstoff_1 (rohstoff_nr, rohstoff_cluster_id,
rohstoff_basis_einh_name, rohstoff_bez, rohstoff_kfl_bez, rohstoffkategorie, rohstoff_beschreibung_txt,
rohstoff_qualitaet_txt, rohstoff_herkunftsort_name, rohstoff_lieferort_name, rohstoff_quell_bez) AS SELECT V01.rohstoff_nr
 ,
 V02.rohstoff_cluster_id,
 V01.rohstoff_basis_einh_name,
 V01.rohstoff_bez,
 V02.rohstoff_kfl_bez,
 V02.rohstoff_kategorie_kfl_name AS rohstoffkategorie,
 V01.rohstoff_beschreibung_txt,
 TRIM(V02.rohstoff_qualitaet_txt) AS rohstoff_qualitaet_txt,
 V01.rohstoff_herkunftsort_name,
 V01.rohstoff_lieferort_name,
 V02.rohstoff_quell_bez
FROM kfl_production_dbp_data.rohstoff_1 AS V01
 LEFT JOIN kfl_production_dbp_msi_data.ts_rohstoff_monitoring_anzeige_1 AS V02 ON V01.rohstoff_nr = V02.rohstoff_nr
WHERE CURRENT_DATE BETWEEN V02.dat_anzeige_von AND V02.dat_anzeige_bis
GROUP BY V01.rohstoff_nr,
 V02.rohstoff_cluster_id,
 V01.rohstoff_basis_einh_name,
 V01.rohstoff_bez,
 V02.rohstoff_kfl_bez,
 rohstoffkategorie,
 V01.rohstoff_beschreibung_txt,
 rohstoff_qualitaet_txt,
 V01.rohstoff_herkunftsort_name,
 V01.rohstoff_lieferort_name,
 V02.rohstoff_quell_bez
ORDER BY V01.rohstoff_nr NULLS LAST;