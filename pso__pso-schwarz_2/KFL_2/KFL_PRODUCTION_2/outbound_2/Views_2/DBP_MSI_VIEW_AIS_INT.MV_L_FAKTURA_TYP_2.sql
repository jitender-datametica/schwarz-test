CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_faktura_typ_2 (mandant_id, faktura_typ_id, retoure_fg) AS
SELECT mandant_id,
 faktura_typ_id,
  CASE
  WHEN faktura_typ_id IN ('O', 'S')
  THEN 1
  ELSE 0
  END AS retoure_fg
FROM kfl_production_dbp_view.v_besch_faktura_2 AS V01
WHERE mandant_id = 1
GROUP BY mandant_id,
 faktura_typ_id;