CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_ausstattung AS SELECT W.mandant_id,
 W.wup_id,
 IFNULL(SUM(CASE
    WHEN A.ausstattung_id = 3
    THEN A.anzahl
    ELSE NULL
    END), 0) AS anz_mde_geraete,
 IFNULL(SUM(CASE
    WHEN A.ausstattung_id = 2
    THEN A.anzahl
    ELSE NULL
    END), 0) AS anz_kasse,
 IFNULL(SUM(CASE
    WHEN A.ausstattung_id = 4
    THEN A.anzahl
    ELSE NULL
    END), 0) AS anz_info_kasse,
 IFNULL(SUM(CASE
    WHEN A.ausstattung_id = 5
    THEN A.anzahl
    ELSE NULL
    END), 0) AS anz_leergut_kasse,
  CASE
  WHEN SUM(CASE
     WHEN A.ausstattung_id = 1
     THEN A.anzahl
     ELSE NULL
     END) = 0
  THEN 0
  ELSE 1
  END AS touchscreen_kz
FROM kfl_production_dbp_msi_v_view.v_wup_denorm AS W
 LEFT JOIN kfl_production_dbp_view.v_ausstattung_wup_zu_per AS A ON W.mandant_id = A.mandant_id AND W.wup_id = A.wup_id
  AND A.dat_bis = DATE '9999-12-31'
GROUP BY W.mandant_id,
 W.wup_id;