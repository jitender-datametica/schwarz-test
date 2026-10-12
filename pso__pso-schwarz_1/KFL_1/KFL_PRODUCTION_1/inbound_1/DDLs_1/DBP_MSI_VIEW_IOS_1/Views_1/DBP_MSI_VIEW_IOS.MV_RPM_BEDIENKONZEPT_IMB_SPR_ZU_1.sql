CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_BEDIENKONZEPT_IMB_SPR_ZU_1 as
   SELECT
   imb.techn_platz_id AS rpm_techn_platz_id,
   --imb_bedien_insel
   --imb_bedien_insel
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bedien_insel,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BEDINS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bedien_insel_bg,

   --imb_bed_konzept_bockw
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_bockw,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BOCKW' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bockw_bg,

   --imb_bed_konzept_bulk_food
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_bulk_food,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_BULK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_bulk_food_bg,

   --imb_discount_backshop
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_discount_backshop,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_discount_backshop_bg,

   --imb_bed_konzept_feinkost
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_feinkost,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FEINK' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_feinkost_bg,

   --imb_bed_konzept_fisch
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_fisch,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fisch_bg,

   --imb_bed_konzept_fleisch
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_fleisch,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_fleisch_bg,

   --imb_frische_baecker
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_frische_baecker,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_frische_baecker_bg,

   --imb_bed_konzept_gefluegel
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_gefluegel,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_GEFL' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_gefluegel_bg,

   --imb_imbiss
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_imbiss,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_IMBISS' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_imbiss_bg,

   --imb_bed_konzept_kaese
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_kaese,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_KAESE' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_kaese_bg,

   --imb_bed_konzept_leergut
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_leergut,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_leergut_bg,

   --imb_bed_konzept_wurst
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END) AS imb_bed_konzept_wurst,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 124 THEN ai.bedienkonzept_auspr_bez END),  --cz
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_cz,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 108 THEN ai.bedienkonzept_auspr_bez END),  --sk
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_sk,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 65 THEN ai.bedienkonzept_auspr_bez END),  --hr
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_hr,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 90 THEN ai.bedienkonzept_auspr_bez END),  --pl
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_pl,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 95 THEN ai.bedienkonzept_auspr_bez END),  --ro
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_ro,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 24 THEN ai.bedienkonzept_auspr_bez END),  --en
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_en,
   COALESCE(MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 18 THEN ai.bedienkonzept_auspr_bez END),  --bg
   MIN(CASE WHEN bedienkonzept_bez = 'ZPPM_WURST' AND ai.spr_id = 22 THEN ai.bedienkonzept_auspr_bez END))  AS imb_bed_konzept_wurst_bg


   FROM
   (
   SELECT techn_platz_id, NULL AS projekt_id, dat_bedienkonzept AS imb_dat_bedienkonzept,
   bedienkonzept_id AS imb_bedienkonzept_id, bedienkonzept_auspr_id AS imb_bedienkonzept_auspr_id
   FROM dbp_view.v_rpm_immobilie_per_1 i
   INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per_1 b
   ON i.rpm_hierarchie_id = b.rpm_hierarchie_id

   --IMMOBILIE
   WHERE b.rpm_tab_id = 2
   AND b.dat_bis='9999-12-31'
   AND i.dat_bis='9999-12-31'
   AND dat_bedienkonzept < CURRENT_DATE
   ) AS imb
   INNER JOIN dbp_view.v_l_bedienkonzept_1 l
   ON imb_bedienkonzept_id = l.bedienkonzept_id
   INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu_1 ai
   ON imb_bedienkonzept_id = ai.bedienkonzept_id
   AND imb_bedienkonzept_auspr_id = ai.bedienkonzept_auspr_id
   --AND ai.spr_id = 22

   --WHERE imb.techn_platz_id = 'DE-0001'
   GROUP BY
   rpm_techn_platz_id;