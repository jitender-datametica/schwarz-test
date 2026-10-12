CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_stunden_tag_2 AS WITH CTE AS (SELECT IFNULL(B.wup_id, A.wup_id) AS
   wup_id,
   IFNULL(B.nb_id, A.nb_id) AS nb_id,
   IFNULL(B.mandant_id, A.mandant_id) AS mandant_id,
   IFNULL(B.dat, A.dat) AS dat,
   B.stunden_markt,
   A.stunden_sonstige,
   A.stunden_plan,
   B.stunden_co5_sonstige,
   B.ums_netto_plan,
   A.ums_netto_plan_man,
   IFNULL(B.wrg_id, A.wrg_id) AS wrg_id,
   A.stunden_sonstige_plan,
   B.stunden_co1_iks,
   B.stunden_co2_ea,
   B.stunden_co3_anue,
   B.stunden_co4_reinigung,
   B.stunden_plan_pep,
   B.stunden_plan_meldeschluss_plus1,
   B.ums_netto_plan_man_meldeschluss_plus2,
   B.stunden_co_ist,
   B.stunden_co_plan,
   B.stunden_plan_meldeschluss_plus2,
   B.ums_netto_plan_man_meldeschluss_plus1,
   B.stunden_co_plan_plus1,
   B.stunden_co_plan_plus2,
   B.stunden_sonstige_plan_plus1,
   B.stunden_sonstige_plan_plus2,
   B.stunden_plan_ssm,
   A.stunden_versetzung
  FROM kfl_production_dbp_data.wup_stunden_tag_2 AS B
   FULL JOIN kfl_production_dbp_view.v_wup_stunden_tag_union_land_2 AS A ON B.wup_id = A.wup_id AND B.nb_id = A.nb_id AND
       B.mandant_id = A.mandant_id AND B.dat = A.dat AND B.wrg_id = A.wrg_id) (SELECT *
  FROM CTE);