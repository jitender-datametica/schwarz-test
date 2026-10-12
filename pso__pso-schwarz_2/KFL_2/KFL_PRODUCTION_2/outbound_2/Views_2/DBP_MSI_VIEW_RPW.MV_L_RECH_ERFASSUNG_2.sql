CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_rech_erfassung_2 (mandant_id, erfassung_id, system_id, edi_fg
) AS SELECT mandant_id,
 erfassung_id,
 7 AS system_id,
  CASE
  WHEN erfassung_id IN ('MED', 'DED')
  THEN 'EDI'
  ELSE 'NonEDI'
  END AS edi_fg
FROM kfl_production_dbp_view.v_l_rech_erfassung_2
WHERE mandant_id = 1;