CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_auftragsart_spr_zu_en AS SELECT DE.auftragsart_id,
 COALESCE(ls.auftragsart_bez, DE.auftragsart_bez) AS auftragsart_bez
FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_in_auftragsart_spr_zu
  WHERE spr_id = 24
  QUALIFY (RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id IS NULL, mandant_id)) = 1) AS ls ON DE.auftragsart_id
   = ls.auftragsart_id
WHERE DE.spr_id = 22
QUALIFY (RANK() OVER (PARTITION BY DE.auftragsart_id ORDER BY DE.mandant_id IS NULL, DE.mandant_id)) = 1;