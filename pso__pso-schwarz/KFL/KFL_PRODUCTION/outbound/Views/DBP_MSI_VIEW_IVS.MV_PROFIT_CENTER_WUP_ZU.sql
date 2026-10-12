CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_profit_center_wup_zu (krk_id, mandant_id, pc_id, system_id,
wup_id, nb_id, eroeffnungsdatum, schliessungsdatum, startdate, expansionsflag) AS SELECT P.krk_id,
 P.mandant_id,
 P.pc_id,
 P.system_id,
 P.wup_id,
 P.nb_id,
 W.dat_von AS eroeffnungsdatum,
 W.dat_bis AS schliessungsdatum,
 H.startdate,
  CASE
  WHEN W.dat_von > CAST(H.startdate AS DATE)
  THEN 1
  WHEN W.dat_bis < CURRENT_DATE
  THEN 2
  WHEN W.dat_von IS NULL
  THEN 3
  ELSE 0
  END AS expansionsflag
FROM kfl_production_dbp_view.v_profit_center AS P
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON P.wup_id = W.wup_id AND P.mandant_id = W.mandant_id AND P.nb_id = W.nb_id
   
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_expansionshilfe AS H ON P.krk_id = H.krk_id;