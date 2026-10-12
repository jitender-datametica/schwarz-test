CREATE OR REPLACE VIEW ldl_p_lew_process.v_assortment_type AS SELECT SUBSTR(CAST(listing_type_id AS STRING), 1, 2) AS
 assortment_type_cd,
 MAX(listing_type_desc) AS assortment_type_descr,
 MAX(listing_type_desc) AS assortment_type_descr_de,
 NULL AS assortment_type_descr_en,
 NULL AS assortment_type_descr_bg,
 NULL AS assortment_type_descr_cs,
 NULL AS assortment_type_descr_da,
 NULL AS assortment_type_descr_el,
 NULL AS assortment_type_descr_es,
 NULL AS assortment_type_descr_fi,
 NULL AS assortment_type_descr_fr,
 NULL AS assortment_type_descr_hr,
 NULL AS assortment_type_descr_hu,
 NULL AS assortment_type_descr_it,
 NULL AS assortment_type_descr_lt,
 NULL AS assortment_type_descr_nl,
 NULL AS assortment_type_descr_pl,
 NULL AS assortment_type_descr_pt,
 NULL AS assortment_type_descr_ro,
 NULL AS assortment_type_descr_sh,
 NULL AS assortment_type_descr_sk,
 NULL AS assortment_type_descr_sl,
 NULL AS assortment_type_descr_sv
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type
WHERE language_id = 23
GROUP BY listing_type_id;