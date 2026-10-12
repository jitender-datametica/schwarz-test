CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_org_wh_contact_2 AS
SELECT WH.client_id,
 WH.src_wh_id AS wh_id,
 WH.dwh_valid_from AS dat_rec_start,
 WH.dwh_valid_to AS dat_rec_end,
 WH.zip_code AS zipcode,
 WH.city,
 WH.street,
 WH.phone_number AS phone,
 WH.postbox AS zipcode_postbox,
 WH.postbox,
 WH.fax_number AS fax,
 WH_CON.modem
FROM ldl_p_lew_bil_ac.v_warehouse_contact_2 AS WH
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_contact_2 AS WH_CON ON WH.loc_sid_wh = WH_CON.wh_loc_sid AND WH.client_id =
    WH_CON.client_id AND CURRENT_DATE BETWEEN WH_CON.dat_rec_start AND WH_CON.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_2 AS WH_WAWI ON WH.loc_sid_wh = WH_WAWI.wh_loc_sid AND WH.client_id = WH_WAWI.client_id
     AND CURRENT_DATE BETWEEN WH_WAWI.dat_rec_start AND WH_WAWI.dat_rec_end
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON WH.client_id = MIG.client_id
WHERE WH.dwh_actual_fg = 1
 AND WH.src_wh_id > 0
 AND (WH_WAWI.wawi_data_fg = 1 OR CASE
     WHEN MIG.active_fg = 1 AND WH.global_loc_id_length = 7 AND WH.global_loc_type_cd = '9' AND COALESCE(WH.country_pol_cd
       , WH_WAWI.country_cd) IS NOT NULL
     THEN 1
     ELSE 0
     END = 1);


