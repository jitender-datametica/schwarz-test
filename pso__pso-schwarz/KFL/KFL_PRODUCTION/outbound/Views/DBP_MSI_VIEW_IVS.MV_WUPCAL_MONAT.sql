CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_wupcal_monat AS SELECT IO.mandant_id,
 IO.immo_objekt_id,
 wc.wup_id,
 wc.gj,
 wc.kjmo,
 wc.anzahl_oeff_tage,
 wc.bonanzahl AS anzahl_kunden
FROM kfl_production_dbp_view.v_ivs_immo_objekt_per AS IO
 LEFT JOIN (SELECT WC0.mandant_id,
   WC0.wup_id,
   ZEIT0.gj,
   ZEIT0.kjmo,
   SUM(WC0.offen) AS anzahl_oeff_tage,
   SUM(WC0.bonanzahl) AS bonanzahl
  FROM kfl_production_dbp_view.v_wupcal AS WC0
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT0 ON WC0.dat = ZEIT0.dat
  WHERE WC0.nb_id = 0
  GROUP BY WC0.mandant_id,
   WC0.wup_id,
   ZEIT0.kjmo,
   ZEIT0.gj) AS wc ON IO.immo_objekt_bez = wc.wup_id AND IO.mandant_id = wc.mandant_id
WHERE IO.dat_bis = DATE '9999-12-31';