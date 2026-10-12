CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_fwws_art_2 (mandant_id, nb_id, wup_id, art_id, dat,
dispomerkmal, disponent_id, artikel_exc209_fg, artikel_exc214_fg, tagesartikel_fg, bestandsartikel_fg,
alle_art_o_kdis_fg, alle_art_fg, autodispo_fg_12, bezugsweg_id, autodispo_fg, dispo_1014_fg, art_exc252_fg,
art_exc252_7d_fg, bestand_menge_fg, max_kapa_filter) AS SELECT FWWS.mandant_id,
 FWWS.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 FWWS.art_id,
 FWWS.dat,
 FWWS.dispomerkmal,
 FWWS.disponent_id,
 FWWS.artikel_exc209_fg,
 FWWS.artikel_exc214_fg,
 FWWS.tagesartikel_fg,
 FWWS.bestandsartikel_fg,
 FWWS.alle_art_o_kdis_fg,
 FWWS.alle_art_fg,
 FWWS.autodispo_fg_12,
 FWWS.bezugsweg_id,
 FWWS.autodispo_fg,
 CAST(CASE
   WHEN FWWS.dispomerkmal IN ('10', '14')
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS dispo_1014_fg,
 CAST(CASE
   WHEN EXC.pruef_id = 252
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS art_exc252_fg,
 CAST(CASE
   WHEN EXC7D.pruef_id = 252
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS art_exc252_7d_fg,
 CAST(CASE
   WHEN MBE.menge_lgbest_erp_frei_bme > 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS bestand_menge_fg,
     FWWS.autodispo_fg * CAST(CASE
       WHEN FWWS.dispomerkmal IN ('10', '14')
       THEN 1
       ELSE 0
       END AS BIGNUMERIC) * CAST(CASE
      WHEN EXC.pruef_id = 252
      THEN 1
      ELSE 0
      END AS BIGNUMERIC) * CAST(CASE
     WHEN EXC7D.pruef_id = 252
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) * CAST(CASE
    WHEN MBE.menge_lgbest_erp_frei_bme > 0
    THEN 1
    ELSE 0
    END AS BIGNUMERIC) AS max_kapa_filter
FROM kfl_production_dbp_msi_v_view.v_vis_tag_fwws_art_2 AS FWWS
 LEFT JOIN kfl_production_dbp_view.v_ausnahme_2 AS EXC7D ON DATE_SUB(FWWS.dat, INTERVAL 7 DAY) = EXC7D.dat_plan AND FWWS.mandant_id
        = EXC7D.mandant_id AND FWWS.wup_id = EXC7D.wup_id AND FWWS.art_id = EXC7D.art_id AND EXC7D.pruef_id IN (252) AND
   EXC7D.z_arbeitsgebiet_id = 0
 LEFT JOIN kfl_production_dbp_view.v_ausnahme_2 AS EXC ON FWWS.dat = EXC.dat_plan AND FWWS.mandant_id = EXC.mandant_id AND
      FWWS.wup_id = EXC.wup_id AND FWWS.art_id = EXC.art_id AND EXC.pruef_id IN (252) AND EXC.z_arbeitsgebiet_id = 0
 LEFT JOIN kfl_production_dbp_view.v_marktbestand_erp_2 AS MBE ON FWWS.dat = MBE.dat AND FWWS.mandant_id = MBE.mandant_id
    AND FWWS.wup_id = MBE.wup_id AND FWWS.art_id = MBE.art_id AND MBE.menge_lgbest_erp_frei_bme > 0
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON FWWS.mandant_id = WUP.mandant_id AND FWWS.wup_id = WUP.wup_id;