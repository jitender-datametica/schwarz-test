CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_rohertrag_plan_ist_1 (mandant_id, in_art_id, gjmo,
plan_fg, werk_id, rohertrag_betrag_org, wrg_id_org, wrg_id, max_dat, default_wrg) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 v450.gjmo,
 V01.plan_fg,
 V01.werk_id,
 V01.rohertrag_betrag AS rohertrag_betrag_org,
 V01.wrg_id AS wrg_id_org,
 V01.wrg_id,
 v450.max_dat,
 V100.default_wrg
FROM kfl_production_dbp_view.v_flw_rohertrag_plan_ist_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN (SELECT MAX(dat) AS max_dat,
   MAX(kjmo) AS kjmo,
   gjmo
  FROM kfl_production_dbp_view.v_tag_1
  GROUP BY gjmo) AS v450 ON v450.gjmo = CASE
   WHEN V01.buchungsperiode_id > 12
   THEN V01.gj * 100 + 12
   ELSE V01.gj * 100 + V01.buchungsperiode_id
   END;