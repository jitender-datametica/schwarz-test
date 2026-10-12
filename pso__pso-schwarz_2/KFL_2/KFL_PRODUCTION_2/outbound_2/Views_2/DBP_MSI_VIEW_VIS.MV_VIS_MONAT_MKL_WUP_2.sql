CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_mkl_wup_2 (mandant_id, nb_id, wup_id, kjmo,
dat_aenderung_min, dat_aenderung_max, dat_we_min, dat_we_max, anz_fehler, anz_kopf_fehler, anz_pos_fehler, anz_rech_pos
) AS SELECT mkl.mandant_id,
 mkl.nb_id,
 mkl.wup_id,
 mkl.kjmo,
 mkl.dat_aenderung_min,
 mkl.dat_aenderung_max,
 mkl.dat_we_min,
 mkl.dat_we_max,
 mkl.anz_fehler,
 mkl.anz_kopf_fehler,
 mkl.anz_pos_fehler,
 fwws.anz_rech_pos
FROM (SELECT MKL.mandant_id,
   MKL.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   TT.kjmo,
   MIN(MKL.dat_aenderung) AS dat_aenderung_min,
   MAX(MKL.dat_aenderung) AS dat_aenderung_max,
   MIN(MKL.dat_we) AS dat_we_min,
   MAX(MKL.dat_we) AS dat_we_max,
   COUNT(*) AS anz_fehler,
   SUM(PC.kopf_fehler_fg) AS anz_kopf_fehler,
   SUM(PC.pos_fehler_fg) AS anz_pos_fehler
  FROM kfl_production_dbp_view.v_vis_mengen_korrektur_liste_2 AS MKL
   INNER JOIN kfl_production_dbp_view.v_vis_l_problemcode_2 AS PC ON MKL.mandant_id = PC.mandant_id AND MKL.problemcode_id
      = PC.problemcode_id
   INNER JOIN kfl_production_dbp_view.v_tag_2 AS TT ON MKL.dat_aenderung = TT.dat
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON MKL.mandant_id = WUP.mandant_id AND MKL.wup_id = WUP.wup_id
  WHERE MKL.anzeigen_fg = 1
  GROUP BY MKL.mandant_id,
   MKL.nb_id,
   wup_id,
   TT.kjmo) AS mkl
 INNER JOIN (SELECT V01.mandant_id,
   WUP0.aktuell_wup_id AS wup_id,
   V01.kjmo,
   SUM(V01.anz_rech_pos) AS anz_rech_pos
  FROM kfl_production_dbp_msi_v_view.v_vis_monat_fwws_wup_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP0 ON V01.mandant_id = WUP0.mandant_id AND V01.wup_id = WUP0.wup_id
  GROUP BY V01.mandant_id,
   wup_id,
   V01.kjmo) AS fwws ON mkl.mandant_id = fwws.mandant_id AND mkl.wup_id = fwws.wup_id AND mkl.kjmo = fwws.kjmo;