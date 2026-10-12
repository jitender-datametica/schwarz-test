CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_l_contidlayout_2 AS SELECT DISTINCT CASE
  WHEN containertyp_id IN (1, 2, 3, 5, 7, 14, 15, 17, 30)
  THEN '1'
  WHEN containertyp_id IN (4, 6, 8, 9, 10, 16)
  THEN '2'
  ELSE '99'
  END AS layoutid,
  CASE
  WHEN CAST(CASE
     WHEN containertyp_id IN (1, 2, 3, 5, 7, 14, 15, 17, 30)
     THEN '1'
     WHEN containertyp_id IN (4, 6, 8, 9, 10, 16)
     THEN '2'
     ELSE '99'
     END AS INTEGER) IN (1)
  THEN 'Etikett'
  WHEN CAST(CASE
     WHEN containertyp_id IN (1, 2, 3, 5, 7, 14, 15, 17, 30)
     THEN '1'
     WHEN containertyp_id IN (4, 6, 8, 9, 10, 16)
     THEN '2'
     ELSE '99'
     END AS INTEGER) IN (2)
  THEN 'Plakat'
  WHEN CAST(CASE
     WHEN containertyp_id IN (1, 2, 3, 5, 7, 14, 15, 17, 30)
     THEN '1'
     WHEN containertyp_id IN (4, 6, 8, 9, 10, 16)
     THEN '2'
     ELSE '99'
     END AS INTEGER) IN (99)
  THEN 'Restmenge'
  ELSE 'NA'
  END AS layout
FROM kfl_production_dbp_view.v_eps_containertyp_spr_zu_2;