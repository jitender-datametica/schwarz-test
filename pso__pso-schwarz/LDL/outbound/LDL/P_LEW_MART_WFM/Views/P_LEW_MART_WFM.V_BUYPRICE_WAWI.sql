CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_buyprice_wawi AS SELECT CTY.country_iso_cd AS land,
 COALESCE(WH_LOC.src_wh_id, - 1) AS whid,
 CAST(I.orig_item_nr AS BIGNUMERIC) AS orig_item_nr,
 ROUND(CAST(SUP.orig_supplier_nr AS BIGNUMERIC), 0) AS supplier_nr,
 BP.dat_valid_from AS valid_from,
 BP.dat_valid_until AS valid_until,
 CAST(BP.price_buying / (CUR.unit_currency_exchange * CUR.rate_currency_exchange) AS NUMERIC) AS buyprice,
 ROUND(CAST(BP.price_buying AS NUMERIC), 4) AS buyprice_orig,
 C.currency_iso_cd AS currency_iso
FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_buying_price AS BP
 INNER JOIN ldl_p_lew_core_ac.v_location AS WH_LOC ON BP.client_id = WH_LOC.client_id AND BP.wh_loc_sid = WH_LOC.loc_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey AS I ON BP.client_id = I.client_id AND BP.item_sid = I.item_sid AND
   CURRENT_DATE BETWEEN I.dat_rec_start AND I.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate AS CUR ON BP.client_id = CUR.client_id AND BP.currency_nr =
   CUR.currency_nr
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item AS IITEM ON BP.client_id = IITEM.client_id AND BP.item_sid = IITEM.item_sid
     AND CURRENT_DATE BETWEEN IITEM.dat_rec_start AND IITEM.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_sup_supplier_skey AS SUP ON BP.client_id = SUP.client_id AND BP.sup_sid = SUP.sup_sid
     AND CURRENT_DATE BETWEEN SUP.dat_rec_start AND SUP.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency AS C ON BP.client_id = C.client_id AND BP.currency_nr = C.currency_nr
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS CC ON BP.client_id = CC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CTY ON CC.country_id = CTY.country_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS SAP_MIGRATION_CLIENT ON BP.client_id = SAP_MIGRATION_CLIENT.client_id
    AND (CURRENT_DATE < SAP_MIGRATION_CLIENT.migration_dat_valid_from OR CURRENT_DATE > SAP_MIGRATION_CLIENT.migration_dat_valid_to
     )
WHERE BP.dat_valid_from >= DATE_SUB(CURRENT_DATE, INTERVAL 1095 DAY)
 AND BP.dat_valid_from BETWEEN CUR.dat_valid_from AND CUR.dat_valid_until
 AND CURRENT_DATE BETWEEN I.dat_rec_start AND I.dat_rec_end
 AND CURRENT_DATE BETWEEN SUP.dat_rec_start AND SUP.dat_rec_end
 AND CURRENT_DATE BETWEEN IITEM.dat_rec_start AND IITEM.dat_rec_end
 AND IITEM.subitemgroup_id BETWEEN 100 AND 128
QUALIFY 1 = (ROW_NUMBER() OVER (PARTITION BY CTY.country_iso_cd, CAST(COALESCE(WH_LOC.src_wh_id, - 1) AS STRING), CAST(CAST(I.orig_item_nr AS BIGNUMERIC)
       AS STRING), CAST(ROUND(ROUND(CAST(SUP.orig_supplier_nr AS BIGNUMERIC), 0), 0) AS STRING), BP.dat_valid_from
    ORDER BY CAST(BP.price_buying / (CUR.unit_currency_exchange * CUR.rate_currency_exchange) AS NUMERIC) IS NULL, CAST(BP.price_buying / (CUR.unit_currency_exchange * CUR.rate_currency_exchange) AS NUMERIC)
      , BP.dat_valid_until IS NULL, BP.dat_valid_until));