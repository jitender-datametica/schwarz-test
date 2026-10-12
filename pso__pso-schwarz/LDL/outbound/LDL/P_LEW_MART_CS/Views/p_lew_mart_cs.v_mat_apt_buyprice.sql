/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_BUYPRICE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  14.04.2021    Ulrich, Ross                 Remove "AND s2.sup_name IS NOT NULL" to get more supplier from AT 
#                                                  https://jira.schwarz/browse/DDLE-2086
#  1.2  23.01.2025    Ulrich, Ross                 Add column price_special_cond Special Conditions like Zoll, Entsorgung Papier/Kunststoff...
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/704040
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_buyprice (client_id, country_iso_cd, wh_id, org_item_nr,
valid_from_item, case_size, org_supplier_nr, valid_from, valid_until, price_buying, price_special_cond,
currency_iso_code, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT bp.client_id,
 bp.country_iso_cd,
 bp.wh_id,
 bp.org_item_nr,
 bp.valid_from_item,
 bp.case_size,
 bp.org_supplier_nr,
 bp.valid_from,
 bp.valid_until,
 bp.price_buying,
  CASE
  WHEN bp.currency_iso_code = 'EUR'
  THEN sc.price_special_cond_eur
  ELSE sc.price_special_cond
  END AS price_special_cond,
 bp.currency_iso_code,
 bp.dwh_updated,
 bp.dwh_created,
 bp.dwh_load_id,
 bp.load_id,
 bp.src_id
FROM (SELECT IBP.client_id,
   I.src_country_lidl_cd AS country_iso_cd,
   COALESCE(LOC.src_wh_id, LOC.loc_sid) AS wh_id,
   I.orig_item_nr AS org_item_nr,
   IBP.dat_valid_from AS valid_from_item,
   COALESCE(I.case_size, 0) AS case_size,
   s.orig_supplier_nr AS org_supplier_nr,
   IBP.dat_valid_from AS valid_from,
   IBP.dat_valid_until AS valid_until,
   IBP.price_buying,
   C.curr_iso_cd AS currency_iso_code,
   CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_updated,
   CAST('1900-01-01 00:00:00' AS DATETIME) AS dwh_created,
   IBP.load_id AS dwh_load_id,
   CAST(- 1 AS BIGNUMERIC) AS load_id,
   2 AS src_id
  FROM ldl_p_lew_bil_ac.v_itm_sup_wh_buying_price AS IBP
   INNER JOIN (SELECT client_id,
     sup_sid,
     COALESCE(sup_sid, - 1) AS orig_supplier_nr
    FROM ldl_p_lew_bil_ac.v_supplier
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
    GROUP BY client_id,
     sup_sid) AS s ON IBP.client_id = s.client_id AND IBP.sup_sid = s.sup_sid
   INNER JOIN ldl_p_lew_core_ac.v_supplier AS S2 ON IBP.client_id = S2.client_id AND IBP.sup_sid = S2.sup_sid
   INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON IBP.client_id = I.client_id AND IBP.item_sid = I.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON IBP.client_id = LOC.client_id AND IBP.wh_loc_sid = LOC.loc_sid AND
     LOC.wh_store_mark = 'B'
   INNER JOIN ldl_p_lew_core_ac.v_currency AS C ON IBP.client_id = C.client_id AND IBP.curr_sid = C.curr_sid
  WHERE IBP.item_sid > 0
   AND IBP.sup_sid > 0
   AND CURRENT_DATE BETWEEN IBP.dat_rec_start AND IBP.dat_rec_end
   AND (I.itemstatus_cd > 3 AND I.itemstatus_cd < 10)
   AND I.buying_list_type_id > 0
   AND IBP.price_buying IS NOT NULL
   AND C.curr_iso_cd IS NOT NULL
  GROUP BY IBP.client_id,
   country_iso_cd,
   wh_id,
   org_item_nr,
   valid_from_item,
   case_size,
   org_supplier_nr,
   valid_from,
   valid_until,
   IBP.price_buying,
   currency_iso_code,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   load_id,
   src_id
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IBP.client_id AS STRING), CAST(wh_id AS STRING), org_item_nr,
        valid_from_item, CAST(case_size AS STRING), CAST(org_supplier_nr AS STRING) ORDER BY valid_from_item IS NULL,
        valid_from_item, valid_until IS NULL, valid_until, IBP.price_buying IS NULL, IBP.price_buying)) = 1) AS bp
 LEFT JOIN (SELECT IR.client_id,
   COALESCE(C0.src_wh_id, IR.wh_loc_sid) AS wh_id,
   ROUND(SAFE_CAST(D.src_orig_item_nr AS BIGNUMERIC), 0) AS org_item_nr,
   IR.sup_sid AS org_supplier_nr,
   IR.case_size_dec AS case_size,
   IR.dat_formdate,
   IR.receipt_id_rcv,
   SUM(IR.price_buying_rcv) AS price_special_cond,
   SUM(IR.price_buying_euro_rcv) AS price_special_cond_eur
  FROM ldl_p_lew_core.t_wawi_mov_item_wh_receiving AS IR
   LEFT JOIN ldl_p_lew_core.t_wawi_itm_sup_spcond_type AS B ON IR.receipt_special_con_fg = B.spcond_type_id AND IR.client_id
      = B.client_id
   LEFT JOIN ldl_p_lew_core.t_wawi_itm_sup_spcond_subtype AS BB ON IR.client_id = BB.client_id AND B.spcond_subtype_id =
      BB.spcond_subtype_id AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN BB.dat_rec_start AND BB.dat_rec_end
   LEFT JOIN ldl_p_lew_core.t_location AS C0 ON IR.client_id = C0.client_id AND IR.wh_loc_sid = C0.loc_sid AND C0.wh_store_mark
      = 'B'
   LEFT JOIN ldl_p_lew_core.t_item AS D ON IR.client_id = D.client_id AND IR.item_sid = D.item_sid
  WHERE IR.receipt_pos_stock_relevant_fg = 0
   AND IR.receipt_special_con_fg <> 0
   AND IR.link_receipt_pos_nr_rcv = 0
   AND IR.val_buying_euro > 0
  GROUP BY IR.client_id,
   wh_id,
   org_item_nr,
   org_supplier_nr,
   case_size,
   IR.dat_formdate,
   IR.receipt_id_rcv
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IR.client_id AS STRING), CAST(COALESCE(wh_id) AS STRING), CAST(org_item_nr AS STRING)
        , CAST(COALESCE(case_size, 0) AS STRING), CAST(COALESCE(org_supplier_nr, - 1) AS STRING) ORDER BY IR.dat_formdate
        IS NULL, IR.dat_formdate, IR.receipt_id_rcv IS NULL, IR.receipt_id_rcv)) = 1) AS sc ON bp.client_id = sc.client_id
        AND bp.wh_id = sc.wh_id AND bp.org_item_nr = sc.org_item_nr AND bp.org_supplier_nr = sc.org_supplier_nr AND bp.case_size
     = sc.case_size AND bp.valid_from_item <= sc.dat_formdate;