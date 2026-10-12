CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_ts_lin_gf_org_ebene_zu_hr_2 AS SELECT DISTINCT V01.user_id,
 V01.hr_objekt_ebene2_id,
 V01.hr_objekt_ebene3_id,
 V01.hr_objekt_ebene4_id,
  CASE
  WHEN V01.hr_objekt_ebene2_id IS NOT NULL
  THEN 2
  WHEN V01.hr_objekt_ebene3_id IS NOT NULL
  THEN 3
  WHEN V01.hr_objekt_ebene4_id IS NOT NULL
  THEN 4
  ELSE NULL
  END AS einstiegsebene,
 V02.mandant_id,
 V02.kjmo,
 V02.hr_objekt_ebene11_id,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V01.hr_objekt_ebene2_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V01.hr_objekt_ebene3_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V01.hr_objekt_ebene4_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_01,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V02.hr_objekt_ebene3_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V02.hr_objekt_ebene4_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V02.hr_objekt_ebene5_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_02,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V02.hr_objekt_ebene4_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V02.hr_objekt_ebene5_id
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V02.hr_objekt_ebene6_id
  ELSE NULL
  END AS hr_objekt_ebene_gf_03,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V02.hr_objekt_ebene2_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V02.hr_objekt_ebene3_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V02.hr_objekt_ebene4_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_01_bez,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V02.hr_objekt_ebene3_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V02.hr_objekt_ebene4_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V02.hr_objekt_ebene5_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_02_bez,
  CASE
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 2
  THEN V02.hr_objekt_ebene4_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 3
  THEN V02.hr_objekt_ebene5_bez
  WHEN CASE
    WHEN V01.hr_objekt_ebene2_id IS NOT NULL
    THEN 2
    WHEN V01.hr_objekt_ebene3_id IS NOT NULL
    THEN 3
    WHEN V01.hr_objekt_ebene4_id IS NOT NULL
    THEN 4
    ELSE NULL
    END = 4
  THEN V02.hr_objekt_ebene6_bez
  ELSE NULL
  END AS hr_objekt_ebene_gf_03_bez
FROM kfl_production_dbp_msi_v_view.v_ts_lin_gf_org_ebene_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_org_einheit_hierarchie_2 AS V02 ON CASE
   WHEN V01.hr_objekt_ebene2_id IS NOT NULL
   THEN V01.hr_objekt_ebene2_id
   WHEN V01.hr_objekt_ebene3_id IS NOT NULL
   THEN V01.hr_objekt_ebene3_id
   WHEN V01.hr_objekt_ebene4_id IS NOT NULL
   THEN V01.hr_objekt_ebene4_id
   ELSE NULL
   END = CASE
   WHEN V01.hr_objekt_ebene2_id IS NOT NULL
   THEN V02.hr_objekt_ebene2_id
   WHEN V01.hr_objekt_ebene3_id IS NOT NULL
   THEN V02.hr_objekt_ebene3_id
   WHEN V01.hr_objekt_ebene4_id IS NOT NULL
   THEN V02.hr_objekt_ebene4_id
   ELSE NULL
   END
 INNER JOIN kfl_production_dbp_view.v_monat_2 AS V03 ON V02.kjmo = V03.kjmo
WHERE V03.akt_mo BETWEEN - 3 AND 0
 AND V02.spr_id = 65;