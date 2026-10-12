CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_inventur_det_kmo (mandant_id, wup_id, nb_id, zeitpunkt_inv,
dat_buch, art_id, wrg_id, menge_inv, bestand_wert, wert_eingabe) AS SELECT KMO1.mandant_id,
 KMO1.wup_id,
 KMO1.nb_id,
 KMO1.zeitpunkt_inv,
 DATE(KMO1.zeitpunkt_inv) AS dat_buch,
 KMO1.art_id,
 KMO1.wrg_id,
 KMO1.menge_inv,
 KMO1.bestand_wert,
 KMO1.wert_eingabe
FROM kfl_production_dbp_data.inventur_det_kmo AS KMO1
 INNER JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   DATE(zeitpunkt_inv) AS dat_buch,
   art_id,
   wrg_id,
   MAX(zeitpunkt_inv) AS maxzeit
  FROM kfl_production_dbp_data.inventur_det_kmo AS KMO2
  GROUP BY mandant_id,
   wup_id,
   art_id,
   wrg_id,
   nb_id,
   dat_buch) AS kmo2 ON KMO1.zeitpunkt_inv = kmo2.maxzeit AND KMO1.mandant_id = kmo2.mandant_id AND KMO1.wup_id = kmo2.wup_id
       AND KMO1.nb_id = kmo2.nb_id AND KMO1.art_id = kmo2.art_id AND KMO1.wrg_id = kmo2.wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON KMO1.mandant_id = WUP.mandant_id AND KMO1.wup_id = WUP.wup_id;