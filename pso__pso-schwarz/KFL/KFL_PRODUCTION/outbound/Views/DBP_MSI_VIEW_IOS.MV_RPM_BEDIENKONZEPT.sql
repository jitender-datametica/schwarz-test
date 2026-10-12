CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_bedienkonzept AS SELECT emt.techn_platz_id AS
 rpm_techn_platz_id,
 emt.projekt_id AS rpm_projekt_id,
 MA.mandant_kbez,
 MA.mandant_id,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bedien_insel_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_bockw_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BULK'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_bulk_food_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_discount_backshop_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FEINK'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_feinkost_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FISCH'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_fisch_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_fleisch_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_frische_baecker_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_GEFL'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_gefluegel_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_imbiss_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_KAESE'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_kaese_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_leergut_dat,
 MAX(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_WURST'
   THEN emt.emt_dat_bedienkonzept
   ELSE NULL
   END) AS emt_bed_konzept_wurst_dat
FROM (SELECT DISTINCT RI.techn_platz_id,
   I.projekt_id,
   B.dat_bedienkonzept AS emt_dat_bedienkonzept,
   B.bedienkonzept_id AS emt_bedienkonzept_id,
   B.bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id
  FROM kfl_production_dbp_view.v_rpm_immobilie_per AS RI
   INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS I ON RI.rpm_hierarchie_id = I.rpm_immobilie_id AND I.rpm_status_id
      NOT IN (1, 4, 5, 6)
   INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS RP ON I.rpm_phase_id = RP.rpm_phase_id AND I.rpm_projekt_typ_id
       = RP.rpm_projekt_typ_id AND RP.spr_id = 22
   INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per AS B ON I.rpm_hierarchie_id = B.rpm_hierarchie_id
  WHERE B.rpm_tab_id = 3
   AND B.dat_bis = DATE '9999-12-31'
   AND I.dat_bis = DATE '9999-12-31'
   AND (B.dat_bedienkonzept >= CURRENT_DATE OR B.dat_bedienkonzept = DATE '0101-01-01')
   AND RI.dat_bis = DATE '9999-12-31') AS emt
 INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept AS L ON emt.emt_bedienkonzept_id = L.bedienkonzept_id
 LEFT JOIN kfl_production_dbp_view.v_mandant AS MA ON LEFT(emt.techn_platz_id, 2) = CASE
   WHEN TRIM(MA.mandant_kbez) = 'D'
   THEN 'DE'
   ELSE CAST(TRIM(MA.mandant_kbez) AS STRING)
   END
 INNER JOIN kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu AS A ON emt.emt_bedienkonzept_id = A.bedienkonzept_id
   AND emt.emt_bedienkonzept_auspr_id = A.bedienkonzept_auspr_id AND A.spr_id = 22
GROUP BY rpm_techn_platz_id,
 rpm_projekt_id,
 MA.mandant_kbez,
 MA.mandant_id;