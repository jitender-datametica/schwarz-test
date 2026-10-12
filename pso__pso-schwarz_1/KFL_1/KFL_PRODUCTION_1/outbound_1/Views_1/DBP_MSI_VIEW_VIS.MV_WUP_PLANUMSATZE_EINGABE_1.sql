CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_planumsatze_eingabe_1 AS SELECT V2.kjmo,
 V1.mandant_id,
 V1.wup_id,
 V1.wrg_id,
 SUM(CASE
   WHEN V1.ums_netto_plan_man <> 0
   THEN V1.ums_netto_plan_man
   ELSE V1.ums_netto_plan
   END) AS wst_ums_netto_plan_filiale,
 SUM(CASE
   WHEN CAST(V1.ums_netto_plan_man_meldeschluss AS INTEGER) <> 0
   THEN CAST(V1.ums_netto_plan_man_meldeschluss AS BIGNUMERIC)
   ELSE V1.ums_netto_plan
   END) AS wst_ums_netto_plan_filiale_meldeschluss,
  CASE
  WHEN SUM(CASE
     WHEN V1.ums_netto_plan_man <> 0
     THEN V1.ums_netto_plan_man
     ELSE V1.ums_netto_plan
     END) = SUM(CASE
     WHEN CAST(V1.ums_netto_plan_man_meldeschluss AS INTEGER) <> 0
     THEN CAST(V1.ums_netto_plan_man_meldeschluss AS BIGNUMERIC)
     ELSE V1.ums_netto_plan
     END)
  THEN 0
  ELSE 1
  END AS anpassung_co_wert,
  CASE
  WHEN SUM(CASE
     WHEN V1.ums_netto_plan_man <> 0
     THEN V1.ums_netto_plan_man
     ELSE V1.ums_netto_plan
     END) = SUM(CASE
     WHEN CAST(V1.ums_netto_plan_man_meldeschluss AS INTEGER) <> 0
     THEN CAST(V1.ums_netto_plan_man_meldeschluss AS BIGNUMERIC)
     ELSE V1.ums_netto_plan
     END)
  THEN 1
  ELSE 0
  END AS ubernahme_co
FROM kfl_production_dbp_msi_view_vis.mv_wup_stunden_tag_1 AS V1
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_tag_1 AS V2 ON V1.dat = V2.dat
GROUP BY V2.kjmo,
 V1.mandant_id,
 V1.wup_id,
 V1.wrg_id
HAVING wst_ums_netto_plan_filiale <> 0;



