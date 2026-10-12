CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_units AS SELECT DISTINCT ITM.client_id,
 CNTRY.src_country_lidl_cd AS country_cd,
 ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_itm_nr,
 ROUND(CAST(ITM.src_matnr AS BIGNUMERIC), 0) AS itm_id,
 BESTEL.uom_cd_base AS basismengeneinheit,
 BESTEL.uom_cd_order AS bestellmenge,
 CAST(DESCR.uom_descr_ext_3ch AS STRING) AS meinh,
 CAST(DESCR.uom_descr_long AS STRING) AS meinh_bez,
 ROUND(CAST(UOM_HIST.conv_to_base_numerator AS BIGNUMERIC), 0) AS zaehler,
 ROUND(CAST(UOM_HIST.conv_to_base_denominator AS BIGNUMERIC), 0) AS nenner,
 SUBSTR(CAST(UOM_HIST.uom_cd_sub AS STRING), 1, 3) AS ext_desc_3ch_sub
FROM ldl_p_lew_core_ac.v_item AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON ITM.client_id = MIG.client_id AND DATE_SUB(CURRENT_DATE,
    INTERVAL 1 DAY) BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_pinfo_header_hist AS BESTEL ON ITM.item_sid = BESTEL.item_sid AND ITM.client_id = BESTEL
    .client_id AND BESTEL.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement AS UOM ON ITM.item_sid = UOM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_country AS CNTRY ON ITM.client_id = CNTRY.country_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist AS UOM_HIST ON ITM.item_sid = UOM_HIST.item_sid AND UOM.uom_sid
     = UOM_HIST.uom_sid AND UOM_HIST.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_unit_of_measurement_descr AS DESCR ON UOM.uom_sid = DESCR.uom_sid AND DESCR.lang_cd IN ('@'
    , 'EN')
WHERE CAST(ITM.log_var_cd AS INTEGER) IN (1, 2, 3);