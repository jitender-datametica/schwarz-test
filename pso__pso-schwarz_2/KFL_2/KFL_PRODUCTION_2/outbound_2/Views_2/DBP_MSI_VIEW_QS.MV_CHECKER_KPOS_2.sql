CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_checker_kpos_2 AS SELECT t1.mandant_id,
 t1.wup_id,
 t1.dat_booking,
 t2.umsatz_brutto_kassenabschluss,
 t2.anz_kunden_kassenabschluss,
 t2.anz_kunden_imbiss_kassenabschluss,
 t3.bonanzahl,
 t3.bonanzahl_imbiss,
 SUM(t1.umsatz_brutto_verkauf) AS umsatz_brutto_all,
  t2.umsatz_brutto_kassenabschluss - SUM(t1.umsatz_brutto_verkauf) AS differenz,
    (t2.umsatz_brutto_kassenabschluss - SUM(t1.umsatz_brutto_verkauf)) / IF(t2.umsatz_brutto_kassenabschluss = 0, NULL,
    t2.umsatz_brutto_kassenabschluss) * 100 AS `%-abw`
FROM (SELECT K.mandant_id,
    K.wup_id,
    K.dat_booking,
    SUM(V.umsatz_brutto) AS umsatz_brutto_verkauf
   FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS K
    INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf_2 AS V ON K.bon_id = V.bon_id AND K.mandant_id = V.mandant_id
     AND K.wup_id = V.wup_id
   WHERE K.turnover_fg = 1
    AND (K.mandant_id, K.wup_id, K.dat_booking) IN (SELECT (K0.mandant_id, K0.wup_id, K0.dat_booking)
      FROM kfl_production_dbp_v_ods.v_bon_load_status_2 AS B
       INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_transaction_2 AS K0 ON B.xml_name = K0.datei_name
      WHERE K0.kassensystem_name = 'KPOS'
      GROUP BY K0.mandant_id,
       K0.wup_id,
       K0.dat_booking)
    AND (K.mandant_id, K.wup_id, K.bon_id) NOT IN (SELECT (mandant_id, wup_id, bon_id)
      FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2)
   GROUP BY K.mandant_id,
    K.wup_id,
    K.dat_booking
   UNION DISTINCT
   SELECT K.mandant_id,
    K.wup_id,
    K.dat_booking,
    SUM(V.umsatz_brutto) AS umsatz_brutto_verkauf
   FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS K
    INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_retoure_2 AS V ON K.bon_id = V.bon_id AND K.mandant_id = V.mandant_id
     AND K.wup_id = V.wup_id
   WHERE K.turnover_fg = 1
    AND (K.mandant_id, K.wup_id, K.bon_dat) IN (SELECT (K1.mandant_id, K1.wup_id, K1.dat_booking)
      FROM kfl_production_dbp_v_ods.v_bon_load_status_2 AS B0
       INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_transaction_2 AS K1 ON B0.xml_name = K1.datei_name
      WHERE K1.kassensystem_name = 'KPOS'
      GROUP BY K1.mandant_id,
       K1.wup_id,
       K1.dat_booking)
    AND (K.mandant_id, K.wup_id, K.bon_id) NOT IN (SELECT (mandant_id, wup_id, bon_id)
      FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2)
   GROUP BY K.mandant_id,
    K.wup_id,
    K.dat_booking) AS t1_2
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   bon_dat,
   COUNT(bon_id) AS anz_end_of_days,
   SUM(anz_kunden) AS anz_kunden_kassenabschluss,
   SUM(anz_kunden_imbiss) AS anz_kunden_imbiss_kassenabschluss,
   SUM(umsatz_brutto) AS umsatz_brutto_kassenabschluss
  FROM kfl_production_dbp_v_ods.v_ods_bon_kassenabschluss_2 AS K
  WHERE (mandant_id, wup_id, bon_dat) IN (SELECT (K3.mandant_id, K3.wup_id, K3.dat_booking)
     FROM kfl_production_dbp_v_ods.v_bon_load_status_2 AS B1
      INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_transaction_2 AS K3 ON B1.xml_name = K3.datei_name
     WHERE K3.kassensystem_name = 'KPOS'
     GROUP BY K3.mandant_id,
      K3.wup_id,
      K3.dat_booking)
  GROUP BY mandant_id,
   wup_id,
   bon_dat) AS t2 ON t1.mandant_id = t2.mandant_id AND t1.wup_id = t2.wup_id AND t1.dat_booking = t2.bon_dat
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   dat,
   bonanzahl,
   bonanzahl_imbiss
  FROM kfl_production_dbp_view.v_wupcal_2 AS K
  WHERE (mandant_id, wup_id, dat) IN (SELECT (K5.mandant_id, K5.wup_id, K5.dat_booking)
     FROM kfl_production_dbp_v_ods.v_bon_load_status_2 AS B2
      INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_transaction_2 AS K5 ON B2.xml_name = K5.datei_name
     WHERE K5.kassensystem_name = 'KPOS'
     GROUP BY K5.mandant_id,
      K5.wup_id,
      K5.dat_booking)) AS t3 ON t1.mandant_id = t3.mandant_id AND t1.wup_id = t3.wup_id AND t1.dat_booking = t3.dat
GROUP BY t1.mandant_id,
 t1.wup_id,
 t1.dat_booking,
 t2.anz_kunden_kassenabschluss,
 t2.anz_kunden_imbiss_kassenabschluss,
 t2.umsatz_brutto_kassenabschluss,
 t3.bonanzahl,
 t3.bonanzahl_imbiss
HAVING t2.umsatz_brutto_kassenabschluss - umsatz_brutto_all <> 0 OR t2.umsatz_brutto_kassenabschluss IS NULL OR
 umsatz_brutto_all IS NULL;