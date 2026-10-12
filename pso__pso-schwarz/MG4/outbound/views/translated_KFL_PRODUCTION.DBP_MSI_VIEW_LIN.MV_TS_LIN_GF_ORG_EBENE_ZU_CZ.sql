CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_ts_lin_gf_org_ebene_zu_cz (user_id, hr_objekt_ebene2_id,
hr_objekt_ebene3_id, hr_objekt_ebene4_id, einstiegsebene, mandant_id, kjmo, hr_objekt_ebene11_id, hr_objekt_ebene_gf_01
, hr_objekt_ebene_gf_02, hr_objekt_ebene_gf_03, hr_objekt_ebene_gf_01_bez, hr_objekt_ebene_gf_02_bez,
hr_objekt_ebene_gf_03_bez) AS SELECT DISTINCT v01.user_id,
 v01.hr_objekt_ebene2_id,
 v01.hr_objekt_ebene3_id,
 v01.hr_objekt_ebene4_id,
  CASE
  WHEN v01.hr_objekt_ebene2_id IS NOT NULL
  THEN 2
  WHEN v01.hr_objekt_ebene3_id IS NOT NULL
  THEN 3
  WHEN v01.hr_objekt_ebene4_id IS NOT NULL
  THEN 4
  ELSE NULL
  END AS einstiegsebene,
 v02.mandant_id,
 v02.kjmo,
 v02.hr_objekt_ebene11_id,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v01.hr_objekt_ebene2_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v01.hr_objekt_ebene3_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v01.hr_objekt_ebene4_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_01,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v02.hr_objekt_ebene3_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v02.hr_objekt_ebene4_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v02.hr_objekt_ebene5_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_02,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v02.hr_objekt_ebene4_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v02.hr_objekt_ebene5_id
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v02.hr_objekt_ebene6_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_03,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v02.hr_objekt_ebene2_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v02.hr_objekt_ebene3_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v02.hr_objekt_ebene4_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_01_bez,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v02.hr_objekt_ebene3_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v02.hr_objekt_ebene4_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v02.hr_objekt_ebene5_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_02_bez,
  CASE
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN v02.hr_objekt_ebene4_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN v02.hr_objekt_ebene5_bez
  WHEN CASE
    WHEN v01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN v01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN v01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN v02.hr_objekt_ebene6_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_03_bez
FROM kfl_production_dbp_msi_v_view.v_ts_lin_gf_org_ebene_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_org_einheit_hierarchie AS v02 ON CASE
   WHEN v01.hr_objekt_ebene2_id IS NOT NULL
   THEN v01.hr_objekt_ebene2_id
   WHEN v01.hr_objekt_ebene3_id IS NOT NULL
   THEN v01.hr_objekt_ebene3_id
   WHEN v01.hr_objekt_ebene4_id IS NOT NULL
   THEN v01.hr_objekt_ebene4_id
   ELSE NULL
   END = CASE
   WHEN v01.hr_objekt_ebene2_id IS NOT NULL
   THEN v02.hr_objekt_ebene2_id
   WHEN v01.hr_objekt_ebene3_id IS NOT NULL
   THEN v02.hr_objekt_ebene3_id
   WHEN v01.hr_objekt_ebene4_id IS NOT NULL
   THEN v02.hr_objekt_ebene4_id
   ELSE NULL
   END
 INNER JOIN kfl_production_dbp_view.v_monat AS v03 ON v02.kjmo = v03.kjmo
WHERE v03.akt_mo BETWEEN - 3 AND 0
 AND v02.spr_id = 124;