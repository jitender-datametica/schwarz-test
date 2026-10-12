CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_kostenrechnung (buchungskreis_id_ker, buchungsperiode_id
, gj, kjmo, kostenart_id, krk_id, mandant_id, pc_id, plan_fg, planvariante_id, kostenrechnung_betrag_org, wrg_id_orig,
max_dat, default_wrg) AS SELECT V01.buchungskreis_id_ker,
 V01.buchungsperiode_id,
 V01.gj,
 V01.kj_ker_mo_id AS kjmo,
 V01.kostenart_id,
 V01.krk_id,
 V01.mandant_id,
 V01.pc_id,
 V01.plan_fg,
 V01.planvariante_id,
 V01.kostenrechnung_betrag AS kostenrechnung_betrag_org,
 V01.wrg_id AS wrg_id_orig,
 v450.max_dat,
 V100.default_wrg
FROM kfl_production_dbp_view.v_kostenrechnung AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN (SELECT MAX(dat) AS max_dat,
   MAX(kjmo) AS kjmo,
   gjmo
  FROM kfl_production_dbp_view.v_tag
  GROUP BY gjmo) AS v450 ON v450.gjmo = CASE
   WHEN V01.buchungsperiode_id > 12
   THEN V01.gj * 100 + 12
   ELSE V01.gj * 100 + V01.buchungsperiode_id
   END;