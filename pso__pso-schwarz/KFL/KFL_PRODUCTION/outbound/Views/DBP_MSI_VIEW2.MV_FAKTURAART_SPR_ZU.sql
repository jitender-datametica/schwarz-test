CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_fakturaart_spr_zu (mandant_id, fakturaart_id, spr_id,
fakturaart_bez, f_soll_haben) AS SELECT mandant_id,
 fakturaart_id,
 spr_id,
 fakturaart_bez,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZLG2', 'G2', 'ZLRE', 'ZLIG', 'ZLLS', 'ZLUS')
  THEN '-'
  ELSE '+'
  END AS f_soll_haben
FROM kfl_production_dbp_view.v_fakturaart_spr_zu
WHERE spr_id = 22
 AND fakturaart_id IN ('G2', 'L2', 'S1', 'S2', 'ZF1', 'ZIV', 'ZIVS', 'ZLF2', 'ZLG2', 'ZLIG', 'ZLL2', 'ZLLS', 'ZLRE',
   'ZLRS', 'ZLS2', 'ZLUL', 'ZLUS')
 AND mandant_id = 1;