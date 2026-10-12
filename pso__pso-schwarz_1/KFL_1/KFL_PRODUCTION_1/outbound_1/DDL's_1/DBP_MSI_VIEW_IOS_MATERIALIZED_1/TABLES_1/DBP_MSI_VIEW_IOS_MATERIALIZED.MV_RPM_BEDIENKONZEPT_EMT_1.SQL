CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_rpm_bedienkonzept_emt_1 (
rpm_techn_platz_id STRING(30) COLLATE 'und:ci',
rpm_projekt_id STRING(32) COLLATE 'und:ci',
mandant_kbez STRING(12) COLLATE 'und:ci',
mandant_id INTEGER,
emt_bedien_insel_dat DATE,
emt_bed_konzept_bockw_dat DATE,
emt_bed_konzept_bulk_food_dat DATE,
emt_discount_backshop_dat DATE,
emt_bed_konzept_feinkost_dat DATE,
emt_bed_konzept_fisch_dat DATE,
emt_bed_konzept_fleisch_dat DATE,
emt_frische_baecker_dat DATE,
emt_bed_konzept_gefluegel_dat DATE,
emt_imbiss_dat DATE,
emt_bed_konzept_kaese_dat DATE,
emt_bed_konzept_leergut_dat DATE,
emt_bed_konzept_wurst_dat DATE
);