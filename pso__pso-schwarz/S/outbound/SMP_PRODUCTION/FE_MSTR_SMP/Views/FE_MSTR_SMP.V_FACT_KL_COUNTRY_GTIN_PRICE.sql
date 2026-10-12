CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_gtin_price (country_id, gtin_id, kl_gtin_id,
art_id_ref, art_id_ref_kl, vk_brutto) AS SELECT DISTINCT LAND.country_id,
 ART.gtin_id,
 ART.gtin_id AS kl_gtin_id,
 ART.art_id AS art_id_ref,
 ART.kl_art_id AS art_id_ref_kl,
 MAX(BON.vk_brutto_obb) OVER (PARTITION BY LAND.country_id, ART.kl_art_id RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS vk_brutto
FROM smp_production_data_shared_kfl.dbp_ods_ods_bon_verkauf AS BON
 INNER JOIN smp_production_data_shared_kfl.dbp_data_art AS ART ON BON.kl_art_id = ART.kl_art_id AND BON.mandant_id = ART
    .mandant_id AND ART.dat_bis = DATE '9999-12-31'
 LEFT JOIN smp_production_core_rel.t_country AS LAND ON BON.mandant_id = LAND.division_country_ref AND LAND.division_id
   = 'KFL'
WHERE BON.bon_dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)
 AND BON.mandant_id IN (SELECT division_country_ref
   FROM smp_production_core_rel.t_country
   WHERE division_id = 'KFL')
 AND BON.menge > 0
GROUP BY LAND.country_id,
 kl_gtin_id,
 art_id_ref,
 art_id_ref_kl,
 BON.vk_brutto_obb;