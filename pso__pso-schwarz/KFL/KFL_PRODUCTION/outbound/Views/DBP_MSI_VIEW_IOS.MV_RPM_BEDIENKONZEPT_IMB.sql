CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_bedienkonzept_imb AS SELECT imb.techn_platz_id AS
 rpm_techn_platz_id,
 NULL AS rpm_projekt_id,
 MA.mandant_kbez,
 MA.mandant_id,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bedien_insel_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_bockw_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BULK'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_bulk_food_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_discount_backshop_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FEINK'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_feinkost_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FISCH'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_fisch_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_fleisch_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_frische_baecker_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_GEFL'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_gefluegel_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_imbiss_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_KAESE'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_kaese_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_leergut_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_WURST'
   THEN imb.imb_dat_bedienkonzept
   ELSE NULL
   END) AS imb_bed_konzept_wurst_dat
FROM (SELECT I.techn_platz_id,
   NULL AS projekt_id,
   B.dat_bedienkonzept AS imb_dat_bedienkonzept,
   B.bedienkonzept_id AS imb_bedienkonzept_id,
   B.bedienkonzept_auspr_id AS imb_bedienkonzept_auspr_id
  FROM kfl_production_dbp_view.v_rpm_immobilie_per AS I
   INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per AS B ON I.rpm_hierarchie_id = B.rpm_hierarchie_id
  WHERE B.rpm_tab_id = 2
   AND B.dat_bis = DATE '9999-12-31'
   AND I.dat_bis = DATE '9999-12-31'
   AND B.dat_bedienkonzept < CURRENT_DATE) AS imb
 INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept AS L ON imb.imb_bedienkonzept_id = L.bedienkonzept_id
 LEFT JOIN kfl_production_dbp_view.v_mandant AS MA ON LEFT(imb.techn_platz_id, 2) = CASE
   WHEN TRIM(MA.mandant_kbez) = 'D'
   THEN 'DE'
   ELSE CAST(TRIM(MA.mandant_kbez) AS STRING)
   END
 INNER JOIN kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu AS AI ON imb.imb_bedienkonzept_id = AI.bedienkonzept_id
     AND imb.imb_bedienkonzept_auspr_id = AI.bedienkonzept_auspr_id AND AI.spr_id = 22
GROUP BY rpm_techn_platz_id,
 rpm_projekt_id,
 MA.mandant_kbez,
 MA.mandant_id;