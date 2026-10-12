CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS SELECT MWT.mandant_id,
 MWT.wrg_id,
 CAST(CASE
   WHEN MWT.wrg_typ_id = 0
   THEN LW.umrechnungskurs
   ELSE 1
   END AS BIGNUMERIC) AS kurs,
  1 / CAST(CASE
    WHEN MWT.wrg_typ_id = 0
    THEN LW.umrechnungskurs
    ELSE 1
    END AS BIGNUMERIC) AS umrechnungskurs
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu AS MWT
 INNER JOIN kfl_production_dbp_view.v_mandant AS M ON MWT.mandant_id = M.mandant_id
 INNER JOIN kfl_production_dbp_view.v_kurs AS LW ON M.default_wrg = LW.von_wrg_id AND LW.nach_wrg_id = 'EUR' AND LW.kurstyp_id
     = 3 AND LW.dat_bis = DATE '9999-12-31'
WHERE MWT.wrg_typ_id = 0 AND MWT.wrg_id = 'EUR'
 OR MWT.wrg_typ_id = 1 AND MWT.wrg_id <> 'EUR';