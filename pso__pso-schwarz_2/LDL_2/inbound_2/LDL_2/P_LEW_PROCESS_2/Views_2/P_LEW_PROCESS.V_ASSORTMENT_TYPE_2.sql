CREATE OR REPLACE VIEW P_LEW_PROCESS.V_ASSORTMENT_TYPE_2
AS
   SELECT CAST(listing_type_id AS CHAR(2)) AS assortment_type_cd,
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
   FROM p_lew_core_ac.v_wawi_ref_itm_list_type_2
   WHERE language_id=23
   GROUP BY listing_type_id;