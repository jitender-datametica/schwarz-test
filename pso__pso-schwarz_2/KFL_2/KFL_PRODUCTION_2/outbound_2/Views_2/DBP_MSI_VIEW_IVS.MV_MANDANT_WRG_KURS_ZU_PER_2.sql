CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2 AS SELECT MWT.mandant_id,
 MWT.wrg_id,
 MWT.wrg_typ_id,
  CASE
  WHEN MWT.wrg_typ_id = 0
  THEN LW.umrechnungskurs
  ELSE 1.0000000
  END AS kurs_2,
  1 / CASE
   WHEN MWT.wrg_typ_id = 0
   THEN LW.umrechnungskurs
   ELSE 1.0000000
   END AS umrechnungskurs,
 DATE('1900-01-01') AS kurs_dat_von,
 DATE('9999-12-31') AS kurs_dat_bis
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS MWT
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON MWT.mandant_id = M.mandant_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS LW ON M.default_wrg = LW.von_wrg_id AND LW.nach_wrg_id = 'EUR' AND LW.kurstyp_id
     = 3 AND LW.dat_bis = DATE('9999-12-31');