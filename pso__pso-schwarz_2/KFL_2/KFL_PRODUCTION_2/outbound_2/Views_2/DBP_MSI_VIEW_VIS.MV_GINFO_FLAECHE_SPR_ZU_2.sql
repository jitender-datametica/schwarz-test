CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ginfo_flaeche_spr_zu_2 AS SELECT DISTINCT GFP.mandant_id,
 0 AS flaeche_quelle_id,
 GFP.ginfo_flaeche_typ_id,
 GFP.ginfo_flaeche_id,
 gfsz.ginfo_flaeche_bez
FROM kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS GFP
 INNER JOIN (SELECT mandant_id,
   ginfo_flaeche_typ_id,
   ginfo_flaeche_id,
   MAX(ginfo_flaeche_bez) AS ginfo_flaeche_bez
  FROM kfl_production_dbp_view.v_ginfo_flaeche_spr_zu_2
  GROUP BY mandant_id,
   ginfo_flaeche_typ_id,
   ginfo_flaeche_id) AS gfsz ON GFP.mandant_id = gfsz.mandant_id AND GFP.ginfo_flaeche_id = gfsz.ginfo_flaeche_id AND
   GFP.ginfo_flaeche_typ_id = gfsz.ginfo_flaeche_typ_id
WHERE GFP.dat_bis = DATE '9999-12-31';