CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_loc_sales_cond_denorm AS SELECT client_id,
 loc_sid,
 item_sid,
 uom_sid_cond,
 curr_cd,
 cond_val_adv,
 cond_val,
 cond_val_adv_cmpy,
 cond_val_cmpy,
 cond_val_adv_ent,
 cond_val_ent,
 net_val_adv,
 net_val,
 net_val_adv_cmpy,
 net_val_cmpy,
 net_val_adv_ent,
 net_val_ent,
 tax_rate_adv,
 tax_rate,
 tax_rate_adv_cmpy,
 tax_rate_cmpy,
 tax_rate_adv_ent,
 tax_rate_ent,
 reason_price_modifi_adv,
 reason_price_modifi_adv_cmpy,
 reason_price_modifi_adv_ent,
 dwh_valid_from,
 dwh_valid_to,
  CASE
  WHEN cond_val IS NOT NULL
  THEN 1
  WHEN cond_val_cmpy IS NOT NULL
  THEN 2
  WHEN cond_val_ent IS NOT NULL
  THEN 3
  ELSE 4
  END AS val_lev,
  CASE
  WHEN cond_val_adv IS NOT NULL
  THEN 1
  WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
     WHEN cond_val IS NOT NULL
     THEN 1
     WHEN cond_val_cmpy IS NOT NULL
     THEN 2
     WHEN cond_val_ent IS NOT NULL
     THEN 3
     ELSE 4
     END > 1
  THEN 2
  WHEN cond_val_adv_ent IS NOT NULL AND CASE
     WHEN cond_val IS NOT NULL
     THEN 1
     WHEN cond_val_cmpy IS NOT NULL
     THEN 2
     WHEN cond_val_ent IS NOT NULL
     THEN 3
     ELSE 4
     END > 2
  THEN 3
  ELSE 4
  END AS val_adv_lev,
 COALESCE(cond_val_adv, cond_val, cond_val_adv_cmpy, cond_val_cmpy, cond_val_adv_ent, cond_val_ent) AS cond_val_eff_calc
 ,
 COALESCE(net_val_adv, net_val, net_val_adv_cmpy, net_val_cmpy, net_val_adv_ent, net_val_ent) AS net_val_eff_calc,
  CASE
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 1
  THEN cond_val_adv
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 2
  THEN cond_val_adv_cmpy
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 3
  THEN cond_val_adv_ent
  ELSE NULL
  END AS cond_val_adv_calc,
 COALESCE(cond_val, cond_val_cmpy, cond_val_ent) AS cond_val_calc,
  CASE
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 1
  THEN net_val_adv
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 2
  THEN net_val_adv_cmpy
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 3
  THEN net_val_adv_ent
  ELSE NULL
  END AS net_val_adv_calc,
 COALESCE(net_val, net_val_cmpy, net_val_ent) AS net_val_calc,
  CASE
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 1
  THEN tax_rate_adv
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 2
  THEN tax_rate_adv_cmpy
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 3
  THEN tax_rate_adv_ent
  ELSE NULL
  END AS tax_rate_adv_calc,
 COALESCE(tax_rate, tax_rate_cmpy, tax_rate_ent) AS tax_rate_calc,
  CASE
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 1
  THEN reason_price_modifi_adv
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 2
  THEN reason_price_modifi_adv_cmpy
  WHEN CASE
    WHEN cond_val_adv IS NOT NULL
    THEN 1
    WHEN cond_val_adv_cmpy IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 1
    THEN 2
    WHEN cond_val_adv_ent IS NOT NULL AND CASE
       WHEN cond_val IS NOT NULL
       THEN 1
       WHEN cond_val_cmpy IS NOT NULL
       THEN 2
       WHEN cond_val_ent IS NOT NULL
       THEN 3
       ELSE 4
       END > 2
    THEN 3
    ELSE 4
    END = 3
  THEN reason_price_modifi_adv_ent
  ELSE NULL
  END AS reason_price_modifi_adv_calc
FROM ldl_p_lew_bil.t_item_loc_sales_cond_denorm;