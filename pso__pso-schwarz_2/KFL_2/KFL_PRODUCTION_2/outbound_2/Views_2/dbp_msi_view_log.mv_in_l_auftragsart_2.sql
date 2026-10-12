CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_l_auftragsart_2 (auftragsart_id, ausfuhrender,
technikbereich_bez) AS SELECT auftragsart_id,
  CASE
  WHEN auftragsart_id IN ('CS37', 'CS47', 'CS57', 'CS77', 'CS35', 'CS45')
  THEN 'Extern'
  WHEN auftragsart_id IN ('CS34', 'CS44', 'CS36', 'CS46', 'CS56', 'CS76')
  THEN 'Intern'
  ELSE ''
  END AS ausfuhrender,
  CASE
  WHEN auftragsart_id IN ('CS34', 'CS35')
  THEN 'FFZ Drittkunden'
  WHEN auftragsart_id IN ('CS36', 'CS37')
  THEN 'FFZ'
  WHEN auftragsart_id IN ('CS34', 'CS35')
  THEN 'FFZ Drittkunden'
  WHEN auftragsart_id IN ('CS44', 'CS45')
  THEN 'HT Drittkunden'
  WHEN auftragsart_id IN ('CS46', 'CS47')
  THEN 'HT'
  WHEN auftragsart_id IN ('CS55', 'CS56', 'CS57')
  THEN 'AT'
  WHEN auftragsart_id IN ('CS76', 'CS77')
  THEN 'Reinigung'
  ELSE ''
  END AS technikbereich_bez
FROM kfl_production_dbp_view.v_in_l_auftragsart_2;