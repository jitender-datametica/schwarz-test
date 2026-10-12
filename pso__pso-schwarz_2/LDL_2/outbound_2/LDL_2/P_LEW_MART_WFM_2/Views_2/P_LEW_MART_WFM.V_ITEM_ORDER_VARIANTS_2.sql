-- base quantity, filter for valid rows in where condition

CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_order_variants_2 (client_id, mandant_2, betriebsgesellschaft, sammelartikel
, artikelvariante, artikelart, belieferart, bestellbereich, valid_var, artikelstatus, basis_me, anliefer_me, zaehler,
nenner, unter_me, log_variante) AS -- base quantity, filter for valid rows in where condition
 -- remove duplicates

-- CROSS JOIN for filtering only sap countries
 -- AND trycast(itm.src_matnr AS INTEGER ) is not null

-- fetching the cross-configurable item_2 for each variant (config_item_cd is null for the cross_configurable item_2 itself) and filter for numeric business keys

-- CROSS JOIN against location_2 with filter to only fetch entries for the "Vorlagefiliale"
 SELECT itm_info_per_loc.client_id
 ,
 itm_info_per_loc.ec_cd AS mandant_2,
 ROUND(CAST(SUBSTR(LOC.global_loc_id, 4, 4) AS BIGNUMERIC), 0) AS betriebsgesellschaft,
 ROUND(CAST(itm_info_per_loc.artikel_2 AS BIGNUMERIC), 0) AS sammelartikel,
 ROUND(CAST(itm_info_per_loc.vart AS BIGNUMERIC), 0) AS artikelvariante,
 itm_info_per_loc.aart AS artikelart,
 ITM_INFO_PER_LOC2.source_of_supply_cd AS belieferart,
 OA.order_area_nr AS bestellbereich,
 COLLATE(LTRIM(COLLATE(ITM_INFO_PER_LOC2.rounding_profile_cd, ''), 'Y'), 'und:ci') AS valid_var,
  CASE
  WHEN itm_state.item_marked_for_deletion_fg = 1
  THEN '70'
  ELSE itm_state.item_status_cd
  END AS artikelstatus,
 itm_info_per_loc.uom_cd_base AS basis_me,
 ITM_UOM.uom_cd AS anliefer_me,
 ITM_UOM.conv_to_base_numerator AS zaehler,
 ITM_UOM.conv_to_base_denominator AS nenner,
 COALESCE(ITM_UOM.uom_cd_sub, '---') AS unter_me,
 itm_info_per_loc.log_var_cd AS log_variante
FROM (SELECT ITM_INFO_PER_LOC.client_id,
   CLNT.elwis_dwh_ec_cd AS ec_cd,
   ITM_INFO_PER_LOC.item_sid,
   ITM_INFO_PER_LOC.loc_sid,
   ITM_INFO_PER_LOC.order_area_sid,
   ITM_INFO_PER_LOC.item_status_cd,
   ITM_INFO_PER_LOC.source_of_supply_cd,
   ITM_INFO_PER_LOC.rounding_profile_cd,
   ITM_INFO_PER_LOC.item_marked_for_deletion_fg,
   ITM.log_var_cd,
   MAX(ITM2.item_sid) AS item_sid2,
   ITM_BASE_ITEM.src_matnr AS artikel_2,
   ITM.src_matnr AS vart,
   ITM_TYPE.src_mtart AS aart,
   ITM_HIST.uom_cd_base
  FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS ITM_INFO_PER_LOC
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS CLNT ON ITM_INFO_PER_LOC.client_id = CLNT.client_id AND
     CURRENT_DATE BETWEEN CLNT.migration_dat_valid_from AND CLNT.migration_dat_valid_to
     -- fetching item_2 information for each entry of item_info_per_location_hist, filter for log_var_cd in list and numeric business keys

     
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM ON ITM_INFO_PER_LOC.client_id = ITM.client_id AND ITM_INFO_PER_LOC.item_sid
       = ITM.item_sid AND CAST(ITM.log_var_cd AS INTEGER) IN (1, 2, 3)
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITM_BASE_ITEM ON ITM.client_id = ITM_BASE_ITEM.client_id AND COALESCE(ITM.config_item_cd
      , ITM.src_matnr) = ITM_BASE_ITEM.src_matnr -- AND trycast(itm_base_item.src_matnr AS INTEGER ) is not null

   LEFT JOIN ldl_p_lew_core_ac.v_item_2 AS ITM2 ON ITM.client_id = ITM2.client_id AND COALESCE(ITM.config_item_cd, ITM.src_matnr
       ) = COALESCE(ITM2.config_item_cd, ITM2.src_matnr) AND CAST(ITM2.log_var_cd AS FLOAT64) = 2
     -- fetching historical information for the cross-configurable item_2 for the current date

   INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM_HIST ON ITM_BASE_ITEM.client_id = ITM_HIST.client_id AND
      ITM_BASE_ITEM.item_sid = ITM_HIST.item_sid AND CURRENT_DATE BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
     -- fetching the item_2 type

   INNER JOIN ldl_p_lew_core_ac.v_item_type_2 AS ITM_TYPE ON ITM_HIST.client_id = ITM_TYPE.client_id AND ITM_HIST.item_type_sid
      = ITM_TYPE.item_type_sid
  WHERE CURRENT_DATE BETWEEN ITM_INFO_PER_LOC.dwh_valid_from AND ITM_INFO_PER_LOC.dwh_valid_to
  GROUP BY ITM_INFO_PER_LOC.client_id,
   ec_cd,
   ITM_INFO_PER_LOC.item_sid,
   ITM_INFO_PER_LOC.loc_sid,
   ITM_INFO_PER_LOC.order_area_sid,
   ITM_INFO_PER_LOC.item_status_cd,
   ITM_INFO_PER_LOC.source_of_supply_cd,
   ITM_INFO_PER_LOC.rounding_profile_cd,
   ITM_INFO_PER_LOC.item_marked_for_deletion_fg,
   ITM.log_var_cd,
   artikel_2,
   vart,
   aart,
   ITM_HIST.uom_cd_base) AS itm_info_per_loc
 LEFT JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS ITM_INFO_PER_LOC2 ON itm_info_per_loc.client_id =
     ITM_INFO_PER_LOC2.client_id AND itm_info_per_loc.loc_sid = ITM_INFO_PER_LOC2.loc_sid AND itm_info_per_loc.item_sid2
     = ITM_INFO_PER_LOC2.item_sid AND CURRENT_DATE BETWEEN ITM_INFO_PER_LOC2.dwh_valid_from AND ITM_INFO_PER_LOC2.dwh_valid_to
   -- CROSS JOIN against location_2 with filter to only fetch entries for the "Vorlagefiliale"

 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON itm_info_per_loc.client_id = LOC.client_id AND itm_info_per_loc.loc_sid
      = LOC.loc_sid AND LOC.wh_store_mark = 'A' AND CAST(LOC.global_loc_type_cd AS FLOAT64) = 8
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_2 AS ST2WH ON LOC.client_id = ST2WH.client_id AND LOC.loc_sid = ST2WH.loc_sid_store
     AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to -- adding order_area information

 LEFT JOIN ldl_p_lew_core_ac.v_order_area_2 AS OA ON ITM_INFO_PER_LOC2.client_id = OA.client_id AND ITM_INFO_PER_LOC2.order_area_sid
    = OA.order_area_sid
   -- fetching historical information of the relation between items and their measures for the current date

 INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS ITM_UOM ON itm_info_per_loc.client_id = ITM_UOM.client_id
     AND itm_info_per_loc.item_sid = ITM_UOM.item_sid AND CURRENT_DATE BETWEEN ITM_UOM.dwh_valid_from AND ITM_UOM.dwh_valid_to
   -- fetching information of the measurement units

 INNER JOIN ldl_p_lew_core_ac.v_unit_of_measurement_2 AS UOM ON ITM_UOM.client_id = UOM.client_id AND ITM_UOM.uom_sid =
   UOM.uom_sid
 LEFT JOIN (SELECT ITM_LOC.client_id,
   ITM_LOC.item_sid,
   ITM_LOC.loc_sid,
   ITM_LOC.item_status_cd,
   ITM_LOC.item_marked_for_deletion_fg
  FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS ITM_LOC
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC0 ON ITM_LOC.client_id = LOC0.client_id AND ITM_LOC.loc_sid = LOC0.loc_sid
       AND LOC0.wh_store_mark = 'B'
  WHERE CURRENT_DATE BETWEEN ITM_LOC.dwh_valid_from AND ITM_LOC.dwh_valid_to) AS itm_state ON itm_info_per_loc.client_id
      = itm_state.client_id AND ST2WH.loc_sid_wh = itm_state.loc_sid AND itm_info_per_loc.item_sid = itm_state.item_sid
  AND CAST(itm_info_per_loc.log_var_cd AS FLOAT64) = 3;