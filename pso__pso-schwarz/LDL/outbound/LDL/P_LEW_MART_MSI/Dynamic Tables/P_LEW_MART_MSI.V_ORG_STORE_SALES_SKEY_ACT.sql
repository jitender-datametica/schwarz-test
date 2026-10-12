CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_org_store_sales_skey_act AS
SELECT W.client_id,
 W.st_loc_sid AS store_id,
 WH.src_wh_id AS sales_wh_id,
 S.orig_store_nr
FROM ldl_p_lew_core_ac.v_wawi_org_wh_store AS W
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act AS S ON W.client_id = S.client_id AND W.st_loc_sid = S.st_loc_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON W.client_id = WH.client_id AND W.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE W.wh_type_id = 1
 AND CURRENT_DATE BETWEEN W.dat_rec_start AND W.dat_rec_end
  -- The following line may be subject to change regarding OP#198066, patch 833

 AND WH.src_wh_id <> S.orig_store_nr -- The following line ensures that the primary key is not violated.

QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(W.client_id AS STRING), CAST(W.st_loc_sid AS STRING) ORDER BY W.dat_rec_end
      IS NULL, W.dat_rec_end, W.dat_rec_start IS NULL, W.dat_rec_start, W.wh_loc_sid IS NULL, W.wh_loc_sid)) = 1;