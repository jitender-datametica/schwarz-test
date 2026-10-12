CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_flaeche_typ_spr_zu_pl AS SELECT DE.ginfo_flaeche_typ_id,
 DE.mandant_id,
 COALESCE(ls.ginfo_flaeche_typ_bez, DE.ginfo_flaeche_typ_bez) AS ginfo_flaeche_typ_bez
FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_ginfo_flaeche_typ_spr_zu
  WHERE spr_id = 90) AS ls ON DE.ginfo_flaeche_typ_id = ls.ginfo_flaeche_typ_id AND DE.mandant_id = ls.mandant_id
WHERE DE.spr_id = 22;