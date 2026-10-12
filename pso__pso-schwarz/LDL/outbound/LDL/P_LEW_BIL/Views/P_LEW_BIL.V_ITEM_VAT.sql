CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_vat (client_id, item_sid, item_name, orig_item_nr, dat_calendar, vat_id,
vat_value, vat_descr, dwh_actual_fg) AS SELECT I.client_id,
 I.item_sid,
 I.item_name,
 COALESCE(I.src_orig_item_nr, I.config_item_cd) AS orig_item_nr,
 CAL.cal_dt AS dat_calendar,
  CASE
  WHEN CAL.cal_dt NOT BETWEEN CLI.migration_dat_valid_from AND CLI.migration_dat_valid_to AND WRWVV_WAWI.vat_id
   IS NOT NULL
  THEN WRWVV_WAWI.vat_id
  WHEN WRWVV_ELWIS.vat_id IS NOT NULL
  THEN WRWVV_ELWIS.vat_id
  ELSE WRWVV_WAWI.vat_id
  END AS vat_id,
  CASE
  WHEN CAL.cal_dt NOT BETWEEN CLI.migration_dat_valid_from AND CLI.migration_dat_valid_to AND WRWVV_WAWI.vat_id
   IS NOT NULL
  THEN WRWVV_WAWI.pct_vat
  WHEN WRWVV_ELWIS.vat_id IS NOT NULL
  THEN WRWVV_ELWIS.pct_vat
  ELSE WRWVV_WAWI.pct_vat
  END AS vat_value,
  CASE
  WHEN CAL.cal_dt NOT BETWEEN CLI.migration_dat_valid_from AND CLI.migration_dat_valid_to AND WRWVV_WAWI.vat_id
   IS NOT NULL
  THEN WRWVV_WAWI.vat_desc
  WHEN WRWVV_ELWIS.vat_id IS NOT NULL
  THEN WRWVV_ELWIS.vat_desc
  ELSE WRWVV_WAWI.vat_desc
  END AS vat_descr,
  CASE
  WHEN CURRENT_DATE = CAL.cal_dt
  THEN 1
  ELSE 0
  END AS dwh_actual_fg
FROM ldl_p_lew_core_ac.v_item AS I
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN DATE '2010-03-01' AND (CURRENT_DATE)
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS CLI ON I.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON I.client_id = C.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_item_tax_country_hist AS TAX_HOME_CNTRY ON I.client_id = TAX_HOME_CNTRY.client_id AND I.item_sid
        = TAX_HOME_CNTRY.item_sid AND TAX_HOME_CNTRY.country_pol_cd = CASE
       WHEN C.client_id = 21
       THEN 'GB'
       ELSE C.country_cd
       END AND CAL.cal_dt BETWEEN TAX_HOME_CNTRY.dwh_valid_from AND TAX_HOME_CNTRY.dwh_valid_to AND TAX_HOME_CNTRY.tax_class_cd
     <> 'X' AND TAX_HOME_CNTRY.deleted_fg = 0
 LEFT JOIN ldl_p_lew_core_ac.v_item_tax_country_hist AS TAX_FOREIGN_CNTRY ON I.client_id = TAX_FOREIGN_CNTRY.client_id
       AND I.item_sid = TAX_FOREIGN_CNTRY.item_sid AND TAX_FOREIGN_CNTRY.country_pol_cd <> CASE
        WHEN C.client_id = 21
        THEN 'GB'
        ELSE C.country_cd
        END AND CAL.cal_dt BETWEEN TAX_FOREIGN_CNTRY.dwh_valid_from AND TAX_FOREIGN_CNTRY.dwh_valid_to AND
     TAX_FOREIGN_CNTRY.tax_class_cd <> 'X' AND TAX_FOREIGN_CNTRY.deleted_fg = 0 AND TAX_HOME_CNTRY.item_sid IS NULL
 LEFT JOIN ldl_p_lew_core_ac.v_item_tax_country_hist AS TAX_FOREIGN_CNTRY_RANK ON TAX_FOREIGN_CNTRY.client_id =
       TAX_FOREIGN_CNTRY_RANK.client_id AND TAX_FOREIGN_CNTRY.item_sid = TAX_FOREIGN_CNTRY_RANK.item_sid AND
      TAX_FOREIGN_CNTRY.country_pol_cd > TAX_FOREIGN_CNTRY_RANK.country_pol_cd AND CAL.cal_dt BETWEEN
     TAX_FOREIGN_CNTRY_RANK.dwh_valid_from AND TAX_FOREIGN_CNTRY_RANK.dwh_valid_to AND TAX_FOREIGN_CNTRY_RANK.tax_class_cd
     <> 'X' AND TAX_FOREIGN_CNTRY_RANK.deleted_fg = 0
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_tax_class AS MAP_MTC ON MAP_MTC.client_id = COALESCE(TAX_HOME_CNTRY.client_id,
    TAX_FOREIGN_CNTRY.client_id) AND MAP_MTC.tax_class_cd = COALESCE(TAX_HOME_CNTRY.tax_class_cd, TAX_FOREIGN_CNTRY.tax_class_cd
    )
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item AS WII ON I.client_id = WII.client_id AND I.item_sid = WII.item_sid AND CAL
   .cal_dt BETWEEN WII.dat_rec_start AND WII.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS WRWVV_ELWIS ON MAP_MTC.client_id = WRWVV_ELWIS.client_id AND
    MAP_MTC.mis_vat_id = WRWVV_ELWIS.vat_id AND CAL.cal_dt BETWEEN WRWVV_ELWIS.dat_rec_start AND WRWVV_ELWIS.dat_rec_end
   
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS WRWVV_WAWI ON WII.client_id = WRWVV_WAWI.client_id AND WII.vat_id
     = WRWVV_WAWI.vat_id AND CAL.cal_dt BETWEEN WRWVV_WAWI.dat_rec_start AND WRWVV_WAWI.dat_rec_end
WHERE TAX_FOREIGN_CNTRY_RANK.client_id IS NULL
 AND COALESCE(WRWVV_ELWIS.vat_id, WRWVV_WAWI.vat_id) IS NOT NULL;