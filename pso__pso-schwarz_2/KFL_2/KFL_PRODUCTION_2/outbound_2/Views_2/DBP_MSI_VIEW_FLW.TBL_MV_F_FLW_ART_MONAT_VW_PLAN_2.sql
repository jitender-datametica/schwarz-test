CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_art_monat_vw_plan_2 (mandant_id, in_art_id, werk_id,
gjmo, in_vw_id, wa_betrag_org, wa_menge_kg, wa_menge_bme, wrg_id_orig, default_wrg, wrg_id, max_dat) AS SELECT V01.mandant_id
 ,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 v450.gjmo,
 V01.flw_vw_id AS in_vw_id,
 V01.wa_menge_kg AS wa_betrag_org,
 V01.wa_menge_bme AS wa_menge_kg,
 V01.wa_betrag AS wa_betrag_org0,
 V01.wrg_id AS wrg_id_orig,
 V100.default_wrg,
 V01.wrg_id,
 v450.max_dat
FROM kfl_production_dbp_view.v_flw_art_monat_vw_plan_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN (SELECT MAX(dat) AS max_dat,
   kjmo,
   MAX(gjmo) AS gjmo
  FROM kfl_production_dbp_view.v_tag_2
  GROUP BY kjmo) AS v450 ON V01.kjmo = v450.kjmo;