CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_kassenabschluss (mandant_id, wup_id, dat, wrg_id,
umsatz_brutto, anz_kunden, anz_kunden_imbiss, anz_scans, sum_scan_sek, sum_scan_min) AS SELECT K.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 K.bon_dat AS dat,
 krs.nach_wrg_id AS wrg_id,
 SUM(K.umsatz_brutto * krs.umrechnungskurs) AS umsatz_brutto,
 SUM(K.anz_kunden) AS anz_kunden,
 SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss,
 SUM(K.anz_scans) AS anz_scans,
 SUM(K.sum_scan_sek) AS sum_scan_sek,
 SUM(K.sum_scan_sek / 60) AS sum_scan_min
FROM kfl_production_dbp_v_ods.v_ods_bon_kassenabschluss AS K
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_zu_per AS WRG ON K.mandant_id = WRG.mandant_id AND K.bon_dat BETWEEN
   WRG.dat_von AND WRG.dat_bis
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS nach_wrg_id,
    1.00000 AS umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS krs ON WRG.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON K.mandant_id = WUP.mandant_id AND K.wup_id = WUP.wup_id
GROUP BY K.mandant_id,
 wup_id,
 dat,
 wrg_id;