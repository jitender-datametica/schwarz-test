CREATE OR REPLACE VIEW ldl_p_lew_bil.v_adv_orig_item_advertising_2 (client_id, wh_id, orig_item_nr, dat_valid_from,
dat_adv, repeat_fg, currency_iso_cd, rec_src_fg_std, rec_src_fg_apt) AS SELECT client_id,
 wh_id,
 orig_item_nr,
 dat_valid_from,
 dat_adv,
 repeat_fg,
 currency_iso_cd,
 MAX(rec_src_fg_std) AS rec_src_fg_std,
 MAX(rec_src_fg_apt) AS rec_src_fg_apt
FROM (SELECT ADV.client_id,
    COALESCE(L.src_orig_wh_nr, ADV.wh_loc_sid) AS wh_id,
    IIS.orig_item_nr,
    IIS.dat_valid_from,
    ADV.dat_adv,
    ADV.repeat_fg,
    CRY.currency_iso_cd,
    ADV.dat_dayend,
    1 AS rec_src_fg_std,
    0 AS rec_src_fg_apt
   FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_2 AS ADV
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON ADV.client_id = CRY.client_id AND
      CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS IIS ON ADV.item_sid = IIS.item_sid AND ADV.client_id = IIS.client_id
      
    INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON ADV.wh_loc_sid = L.loc_sid
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ADV.client_id AS STRING), CAST(wh_id AS STRING), CAST(IIS.orig_item_nr AS STRING)
         , IIS.dat_valid_from, ADV.dat_adv, CRY.currency_iso_cd ORDER BY ADV.dat_dayend IS NULL, ADV.dat_dayend)) = 1
   UNION ALL
   SELECT APT.client_id,
    COALESCE(L.src_orig_wh_nr, APT.wh_loc_sid) AS wh_id,
    iis.orig_item_nr,
    iis.dat_valid_from,
    APT.dat_adv,
    0 AS repeat_fg,
    CRY.currency_iso_cd,
    DATE(NULL) AS dat_dayend,
    0 AS rec_src_fg_std,
    1 AS rec_src_fg_apt
   FROM ldl_p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_2 AS APT
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_2 AS SKY ON APT.client_id = SKY.client_id AND APT.orig_item_nr = SKY
       .orig_item_nr AND APT.dat_adv < SKY.dat_rec_end
    INNER JOIN (SELECT A.client_id,
      COALESCE(WAWI.dat_valid_from, A.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, PARSE_DATE('%d.%m.%Y'
        , '31.12.9999')) AS dat_valid_from,
      A.item_sid,
      ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr
     FROM ldl_p_lew_core_ac.v_item_2 AS A
      INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS B ON A.client_id = B.client_id AND A.item_sid = B.item_sid AND
        CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
      LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WAWI ON A.client_id = WAWI.client_id AND A.item_sid = WAWI.item_sid
        
      LEFT JOIN (SELECT A0.client_id,
        A0.item_sid,
        B0.src_dat_valid_from
       FROM ldl_p_lew_core_ac.v_item_2 AS A0
        INNER JOIN ldl_p_lew_core_ac.v_item_2 AS B0 ON A0.client_id = B0.client_id AND B0.item_sid_config = COALESCE(A0.item_sid_config
            , A0.item_sid) AND B0.src_dat_valid_from IS NOT NULL
       WHERE NOT EXISTS (SELECT 1
         FROM ldl_p_lew_core_ac.v_item_2 AS C
         WHERE client_id = A0.client_id
          AND item_sid_config = COALESCE(A0.item_sid_config, A0.item_sid)
          AND (src_dat_valid_from > A0.src_dat_valid_from OR src_dat_valid_from = A0.src_dat_valid_from AND item_sid >
               A0.item_sid))) AS dwf1 ON A.client_id = dwf1.client_id AND A.item_sid = dwf1.item_sid
      LEFT JOIN (SELECT client_id,
        ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
        MAX(src_dat_valid_from) AS src_dat_valid_from
       FROM ldl_p_lew_core_ac.v_item_2 AS C
       WHERE src_dat_valid_from IS NOT NULL
        AND CAST(src_case_size AS FLOAT64) >= 0
       GROUP BY client_id,
        origi) AS dwf2 ON A.client_id = dwf2.client_id AND dwf2.origi = ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd
            , A.src_matnr) AS BIGNUMERIC), 0) AND A.log_var_cd IS NOT NULL) AS iis ON SKY.client_id = iis.client_id AND
       SKY.item_sid = iis.item_sid AND APT.dat_adv BETWEEN iis.dat_valid_from AND SKY.dat_rec_end
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON APT.client_id = CRY.client_id AND
      CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
    INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON APT.wh_loc_sid = L.loc_sid
   WHERE CURRENT_DATE BETWEEN APT.dat_rec_start AND APT.dat_rec_end
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(APT.client_id AS STRING), CAST(wh_id AS STRING), CAST(SKY.item_sid AS STRING)
         , APT.dat_adv, CRY.currency_iso_cd ORDER BY SKY.dat_rec_end IS NULL, SKY.dat_rec_end)) = 1) AS adv_union
GROUP BY client_id,
 wh_id,
 orig_item_nr,
 dat_valid_from,
 dat_adv,
 repeat_fg,
 currency_iso_cd;