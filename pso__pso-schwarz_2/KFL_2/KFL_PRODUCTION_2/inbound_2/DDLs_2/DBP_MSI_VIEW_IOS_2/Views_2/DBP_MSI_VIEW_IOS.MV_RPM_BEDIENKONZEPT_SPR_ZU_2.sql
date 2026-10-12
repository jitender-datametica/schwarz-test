CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_BEDIENKONZEPT_SPR_ZU_2
AS
   SELECT
   emt.projekt_id AS rpm_projekt_id,

   --emt_bedien_insel
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bedien_insel,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bedien_insel_bg,

   --emt_bed_konzept_bockw
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_bockw,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bockw_bg,

   --emt_bed_konzept_bulk_food
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_bulk_food,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_bulk_food_bg,

   --emt_discount_backshop
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_discount_backshop,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_discount_backshop_bg,

   --emt_bed_konzept_feinkost
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_feinkost,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_feinkost_bg,

   --emt_bed_konzept_fisch
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_fisch,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fisch_bg,

   --emt_bed_konzept_fleisch
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_fleisch,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_fleisch_bg,

   --emt_frische_baecker
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_frische_baecker,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_frische_baecker_bg,

   --emt_bed_konzept_gefluegel
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_gefluegel,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_gefluegel_bg,

   --emt_imbiss
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_imbiss,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_imbiss_bg,

   --emt_bed_konzept_kaese
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_kaese,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_kaese_bg,

   --emt_bed_konzept_leergut
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_leergut,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_leergut_bg,

   --emt_bed_konzept_wurst
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END) AS emt_bed_konzept_wurst,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 124 THEN a.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 108 THEN a.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 65 THEN a.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 90 THEN a.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 95 THEN a.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 24 THEN a.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 18 THEN a.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND a.spr_id = 22 THEN a.bedienkonzept_auspr_bez END))  AS emt_bed_konzept_wurst_bg

   FROM
   (
   SELECT DISTINCT techn_platz_id, projekt_id, dat_bedienkonzept AS emt_dat_bedienkonzept,
   bedienkonzept_id AS emt_bedienkonzept_id, bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id
   FROM dbp_view.v_rpm_immobilie_per_2 ri
   INNER JOIN dbp_view.v_rpm_element_per_2 i
   ON ri.rpm_hierarchie_id =i.rpm_immobilie_id
   AND  i.rpm_status_id NOT IN (1,4,5,6)
   INNER JOIN dbp_view.v_rpm_phase_spr_zu_2 rp
   ON rp.rpm_phase_id = i.rpm_phase_id
   AND rp.rpm_projekt_typ_id = i.rpm_projekt_typ_id
   AND rp.spr_id = 22
   INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per_2 b
   ON i.rpm_hierarchie_id = b.rpm_hierarchie_id
   WHERE b.rpm_tab_id = 3
   AND  b.dat_bis='9999-12-31'
   AND i.dat_bis='9999-12-31'
   AND (dat_bedienkonzept  >= CURRENT_DATE
   OR dat_bedienkonzept  = '1900-01-01' )
   AND ri.dat_bis='9999-12-31'
   ) AS emt
   INNER JOIN dbp_view.v_l_bedienkonzept_2 l
   ON emt_bedienkonzept_id = l.bedienkonzept_id
   INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu_2 a
   ON emt_bedienkonzept_id = a.bedienkonzept_id
   AND emt_bedienkonzept_auspr_id = a.bedienkonzept_auspr_id
   --AND a.spr_id = 22

   --WHERE emt.techn_platz_id = 'DE-0001'

   GROUP BY
   rpm_projekt_id;