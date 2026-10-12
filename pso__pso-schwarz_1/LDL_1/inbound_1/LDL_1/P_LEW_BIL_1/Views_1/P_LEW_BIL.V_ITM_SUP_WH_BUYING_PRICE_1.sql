CREATE OR REPLACE VIEW P_LEW_BIL.V_ITM_SUP_WH_BUYING_PRICE_1 as
SELECT	
       client_id,	
       wh_loc_sid,	
       item_sid,	
       sup_sid,	
       dat_rec_start,	
       dat_rec_end,	
       dat_valid_from,	
       dat_valid_until,	
       dat_valid_until_group,	
       curr_sid,	
       group_nr,	
       delivery_item_cd,	
       dur_shelflife_cust,	
       period_id_shelflife_cust,	
       dur_shelflife_store,	
       period_id_shelflife_store,	
       dur_shelflife_wh,	
       period_id_shelflife_wh,	
       price_buying,	
       price_buying_special,	
       currency_nr_special,	
       origin_country_cd,	
       load_id	
  FROM (	
      SELECT	
            denorm.client_id,	
            denorm.loc_sid                                AS wh_loc_sid,	
            denorm.item_sid,	
            denorm.sup_sid,	
            denorm.startDuration                          AS dat_rec_start,	
            denorm.endDuration-1                          AS dat_rec_end,	
            denorm.startDuration                          AS dat_valid_from,	
            denorm.endDuration-1                          AS dat_valid_until,	
            --PERIOD_BEGIN_UDF(denorm.duration)             AS dat_rec_start,	
            --End(denorm.duration)-1                        AS dat_rec_end,	
            --PERIOD_BEGIN_UDF(denorm.duration)             AS dat_valid_from,	
            --End(denorm.duration)-1                        AS dat_valid_until,	
            NULL                                          AS dat_valid_until_group,	
            denorm.curr_sid,	
            NULL                                          AS group_nr,	
            CAST(NULL AS VARCHAR(3))                      AS delivery_item_cd,	
            CAST(denorm.shelflife_cust_val AS CHAR(20))   AS dur_shelflife_cust,	
            CAST(denorm.shelflife_cust_cd  AS INTEGER)    AS period_id_shelflife_cust,	
            CAST(denorm.shelflife_loc_val  AS CHAR(20))   AS dur_shelflife_store,	
            CAST(denorm.shelflife_loc_cd   AS INTEGER)    AS period_id_shelflife_store,	
            CAST(denorm.shelflife_vz_val   AS CHAR(20))   AS dur_shelflife_wh,	
            CAST(denorm.shelflife_vz_cd    AS INTEGER)    AS period_id_shelflife_wh,	
            denorm.condition_val                          AS price_buying,	
            NULL                                          AS price_buying_special,	
            NULL                                          AS currency_nr_special,	
            CAST(NULL AS VARCHAR(3))                      AS origin_country_cd,	
            NULL                                          AS load_id	
            FROM (	
                    SELECT 	
                            client_id,	
                            item_sid,	
                            sup_sid,	
                            loc_sid,	
                            condition_val,	
                            curr_sid,	
                            shelflife_cust_val,	
                            shelflife_cust_cd,	
                            shelflife_loc_val,	
                            shelflife_loc_cd,	
                            shelflife_vz_val,	
                            shelflife_vz_cd,	
                            pur_valid_from,	
                            pur_valid_to,	
                            ilh_valid_from,	
                            ilh_valid_to,	
                            min_pur_valid_from,	
                            max_pur_valid_to,	
                            MAX(CASE WHEN min_pur_valid_from >= ilh_valid_from	
                                            THEN  min_pur_valid_from	
                                            ELSE ilh_valid_from	
                                END)   as startDuration,	
                            MIN(CASE WHEN max_pur_valid_to <= ilh_valid_to	
                                            THEN max_pur_valid_to	
                                            ELSE ilh_valid_to	
                                END) +1  as endDuration	
                    FROM (	
                            SELECT	
                                a.client_id,	
                                a.item_sid,	
                                a.sup_sid,	
                                a.loc_sid,	
                                b.condition_val,	
                                b.curr_sid,	
                                ilh.shelflife_cust_val,	
                                ilh.shelflife_cust_cd,	
                                ilh.shelflife_loc_val,	
                                ilh.shelflife_loc_cd,	
                                ilh.shelflife_vz_val,	
                                ilh.shelflife_vz_cd,	
                                a.dwh_valid_from              AS pur_valid_from,	
                                a.dwh_valid_to                AS pur_valid_to,	
                                ilh.dwh_valid_from            AS ilh_valid_from,	
                                ilh.dwh_valid_to              AS ilh_valid_to,	
                                min(a.dwh_valid_from)         AS min_pur_valid_from,	
                                max(a.dwh_valid_to)           AS max_pur_valid_to	
                            FROM p_lew_core_ac.v_purchase_info_hist_1 a	
                            INNER JOIN p_lew_core_ac.v_purchase_condition_hist_1 b	
                                ON a.client_id = b.client_id  AND a.pur_cond_sid = b.pur_cond_sid	
                            LEFT OUTER JOIN p_lew_core_ac.v_item_info_per_location_hist_1 ilh	
                                ON a.client_id = ilh.client_id AND a.item_sid = ilh.item_sid AND a.loc_sid = ilh.loc_sid	
                                --AND (a.dwh_valid_from, a.dwh_valid_to) OVERLAPS (ilh.dwh_valid_from, ilh.dwh_valid_to)	
                                  AND p_lew_bil.check_overlap(a.dwh_valid_from, a.dwh_valid_to, ilh.dwh_valid_from, ilh.dwh_valid_to)          	
                            INNER JOIN p_lew_process_ac.v_sap_migration_client_1 mig	
                                ON a.client_id = mig.client_id AND mig.migrated_fg = 1	
                            GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16	
                        ) dt_in	
                    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18	
                ) denorm	
        ) dt_a	
        	
UNION	
	
SELECT	
wawi.client_id,	
   wawi.wh_loc_sid,	
   wawi.item_sid,	
   wawi.sup_sid,	
   wawi.dat_rec_start,	
   wawi.dat_rec_end,	
   wawi.dat_valid_from,	
   wawi.dat_valid_until,	
   wawi.dat_valid_until_group,	
   cur.curr_sid,	
   wawi.group_nr,	
   wawi.delivery_item_cd,	
   wawi.dur_shelflife_cust,	
   wawi.period_id_shelflife_cust,	
   wawi.dur_shelflife_store,	
   wawi.period_id_shelflife_store,	
   wawi.dur_shelflife_wh,	
   wawi.period_id_shelflife_wh,	
   wawi.price_buying,	
   wawi.price_buying_special,	
   wawi.currency_nr_special,	
   wawi.origin_country_cd,	
   wawi.load_id	
	
  FROM p_lew_core_ac.v_wawi_itm_sup_wh_buying_price_1 wawi	
   INNER JOIN p_lew_process_ac.v_sap_migration_client_1 mig	
   ON wawi.client_id = mig.client_id	
   AND mig.migrated_fg = 0	
   INNER JOIN p_lew_core_ac.v_wawi_ref_wawi_currency_1 wawi_cur	
   ON wawi.client_id = wawi_cur.client_id	
   AND wawi.currency_nr = wawi_cur.currency_nr	
   INNER JOIN p_lew_core_ac.v_currency_1 cur	
   ON wawi.client_id = cur.client_id	
   AND wawi_cur.currency_iso_cd = cur.curr_iso_cd	
;