CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_item_1 (division_id, country_id, gtin_id, gtin_name, article_id,
kl_gtin_id, muki_id, art_id_ref_kl, taxonomy_id) AS SELECT DISTINCT GTIN.division_id,
 GTIN.country_id,
 GTIN.gtin_id,
 GTIN.gtin_name,
 GTIN.article_id_ref AS article_id,
 CAST(ART.gtin_id AS STRING) AS kl_gtin_id,
 CAST(ART2.kl_art_id AS STRING) AS muki_id,
 CAST(ROUND(CAST(CASE
     WHEN GTIN.division_id = 'KFL'
     THEN SUBSTR(CAST(ART.kl_art_id AS STRING), 1, 100)
     ELSE GTIN.article_id_ref
     END AS BIGNUMERIC), 0) AS STRING) AS art_id_ref_kl,
 TAX.taxonomy_id
FROM smp_production_core_rel.t_gtin_1 AS GTIN
 INNER JOIN smp_production_core_rel.t_country_1 AS LAND_1 ON GTIN.division_id = LAND.division_id AND GTIN.country_id = LAND_1
   .country_id
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art_1 AS ART_1 ON CAST(GTIN.gtin_id AS FLOAT64) = ART.gtin_id
     -- ON GTIN.ARTICLE_ID_REF = ART.KL_ART_ID
 AND GTIN.division_id = 'KFL' AND LAND.division_country_ref = ART.mandant_id
     AND ART.dat_bis = DATE '9999-12-31'
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art_1 AS ART2 ON ART.mutter_wb_id = ART2.art_id AND ART.mandant_id =
    ART2.mandant_id AND ART.dat_bis = DATE '9999-12-31'
 LEFT JOIN smp_production_core_rel.t_taxonomy_gtin_1 AS TAX ON GTIN.division_id = TAX.division_id AND GTIN.country_id =
    TAX.country_id AND GTIN.gtin_id = TAX.gtin_id;