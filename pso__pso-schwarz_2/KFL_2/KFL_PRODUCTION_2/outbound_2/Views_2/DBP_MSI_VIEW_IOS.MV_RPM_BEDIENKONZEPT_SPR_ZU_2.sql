CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_bedienkonzept_spr_zu_2 AS SELECT emt.projekt_id AS
 rpm_projekt_id,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bedien_insel,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bedien_insel_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_bockw,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bockw_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_bulk_food,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_BULK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_bulk_food_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_discount_backshop,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_discount_backshop_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_feinkost,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FEINK' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_feinkost_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_fisch,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fisch_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_fleisch,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_fleisch_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_frische_baecker,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_frische_baecker_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_gefluegel,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_GEFL' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_gefluegel_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_imbiss,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_imbiss_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_kaese,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_KAESE' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_kaese_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_leergut,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_leergut_bg,
 MIN(CASE
   WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
   THEN A.bedienkonzept_auspr_bez
   ELSE NULL
   END) AS emt_bed_konzept_wurst,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 124
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_cz,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 108
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_sk,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 65
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_hr,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 90
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_pl,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 95
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_ro,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 24
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_en,
 COALESCE(MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 18
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END), MIN(CASE
    WHEN L.bedienkonzept_bez = 'ZPPM_WURST' AND A.spr_id = 22
    THEN A.bedienkonzept_auspr_bez
    ELSE NULL
    END)) AS emt_bed_konzept_wurst_bg
FROM (SELECT DISTINCT RI.techn_platz_id,
   I.projekt_id,
   B.dat_bedienkonzept AS emt_dat_bedienkonzept,
   B.bedienkonzept_id AS emt_bedienkonzept_id,
   B.bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id
  FROM kfl_production_dbp_view.v_rpm_immobilie_per_2 AS RI
   INNER JOIN kfl_production_dbp_view.v_rpm_element_per_2 AS I ON RI.rpm_hierarchie_id = I.rpm_immobilie_id AND I.rpm_status_id
      NOT IN (1, 4, 5, 6)
   INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu_2 AS RP ON I.rpm_phase_id = RP.rpm_phase_id AND I.rpm_projekt_typ_id
       = RP.rpm_projekt_typ_id AND RP.spr_id = 22
   INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per_2 AS B ON I.rpm_hierarchie_id = B.rpm_hierarchie_id
  WHERE B.rpm_tab_id = 3
   AND B.dat_bis = DATE '9999-12-31'
   AND I.dat_bis = DATE '9999-12-31'
   AND (B.dat_bedienkonzept >= CURRENT_DATE OR B.dat_bedienkonzept = DATE '1900-01-01')
   AND RI.dat_bis = DATE '9999-12-31') AS emt
 INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept_2 AS L ON emt.emt_bedienkonzept_id = L.bedienkonzept_id
 INNER JOIN kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu_2 AS A ON emt.emt_bedienkonzept_id = A.bedienkonzept_id
  AND emt.emt_bedienkonzept_auspr_id = A.bedienkonzept_auspr_id
GROUP BY rpm_projekt_id;