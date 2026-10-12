CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM
AS
   SELECT
   item.client_id,
   item.item_sid,
   item.src_matnr,
   item.src_orig_item_nr,
   item.src_dat_valid_from,
   item.src_case_size,
   item.item_name,
   itemh.item_fam_grp_sid,
   sitmgh_asis.sub_item_grp_sid AS sub_item_grp_sid_asis,
   sitmgh_asis.item_grp_int_sid AS item_grp_int_sid_asis,
   itemh.item_type_sid,
   itemh.item_grp_sid,
   itemh.pack_type_sid,
   itemh.uom_sid_base,
   itemh.uom_sid_sales,
   itemh.brand_sid,
   itemh.uom_cd_base,
   itemh.uom_cd_sales,
   itemh.gross_content_val,
   itemh.pack_cont_qty,
   item.config_item_cd,
   itemh.state_bges_cd,
   itemh.hazardous_material_cd,
   item.log_var_cd,
   itemh.pricing_ref_item_cd,
   itemh.uom_sid_packaging,
   itemh.uom_cd_packaging,
   itemh.deleted_fg,
   itemh.dwh_valid_from,
   itemh.dwh_valid_to,
   CASE WHEN Current_Date BETWEEN itemh.dwh_valid_from AND itemh.dwh_valid_to
     THEN 1
     ELSE 0
     END AS dwh_actual_fg,
   CASE WHEN itemh.deleted_fg = 0 AND Current_Date >= item.src_dat_valid_from
     THEN 1
     ELSE 0
     END AS active_fg,
   CASE WHEN Current_Date < item.src_dat_valid_from -- Pruefung ob das Gueltigkeitsdatum in der Zukunft liegt
     THEN 0
     ELSE 1
     END AS active_future_fg,
   item.dwh_updated,
   item.dwh_created,
   item.dwh_load_id
   FROM p_lew_core_ac.v_item AS item
   INNER JOIN p_lew_core_ac.v_item_hist AS itemh
   ON item.client_id = itemh.client_id
   AND item.item_sid = itemh.item_sid
-- Ermittlung der Parent-Item-Hierarchie als ASIS-Sicht für Subitemgroup und International Itemgroup (auch für Historie). Left-Outer-Join zu Parents notwendig, weil die Referenz nicht zwingend bestehen muss. Es kann freihängende Items / Family Groups geben
   LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist AS itmfgh_asis
   ON itemh.client_id = itmfgh_asis.client_id
   AND itemh.item_fam_grp_sid = itmfgh_asis.item_fam_grp_sid
   AND Current_Date BETWEEN itmfgh_asis.dwh_valid_from AND itmfgh_asis.dwh_valid_to
   LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_hist AS sitmgh_asis
   ON itmfgh_asis.client_id = sitmgh_asis.client_id
   AND itmfgh_asis.sub_item_grp_sid = sitmgh_asis.sub_item_grp_sid
   AND Current_Date BETWEEN sitmgh_asis.dwh_valid_from AND sitmgh_asis.dwh_valid_to
-- Rows mit einer nicht numerischen src_matnr werden nicht selektiert 
WHERE
   TRY_CAST(item.src_matnr AS DECIMAL(20)) IS NOT NULL
   OR item.src_matnr IS NULL
;