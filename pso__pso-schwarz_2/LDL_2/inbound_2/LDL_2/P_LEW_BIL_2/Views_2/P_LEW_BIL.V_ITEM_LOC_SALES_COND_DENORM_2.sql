CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_LOC_SALES_COND_DENORM_2 as
   /*
   #DescStart#
   #$Revision: 6283 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   #DescEnd#
   */
   SELECT
   client_id,
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
     WHEN cond_val is NOT null THEN 1
     WHEN cond_val_cmpy is NOT null THEN 2
     WHEN cond_val_ent is NOT null THEN 3
     ELSE 4
   END as val_lev,
   CASE
     WHEN cond_val_adv is NOT null THEN 1
     WHEN cond_val_adv_cmpy is NOT null AND val_lev > 1 THEN 2
     WHEN cond_val_adv_ent is NOT null AND val_lev > 2 THEN 3
     ELSE 4
   END as val_adv_lev,

   COALESCE(cond_val_adv, cond_val, cond_val_adv_cmpy, cond_val_cmpy, cond_val_adv_ent, cond_val_ent) as cond_val_eff_calc,
   COALESCE(net_val_adv, net_val, net_val_adv_cmpy, net_val_cmpy, net_val_adv_ent, net_val_ent) as net_val_eff_calc,

   CASE
     WHEN val_adv_lev = 1 THEN cond_val_adv
     WHEN val_adv_lev = 2 THEN cond_val_adv_cmpy
     WHEN val_adv_lev = 3 THEN cond_val_adv_ent
     ELSE null
   END as cond_val_adv_calc,
   COALESCE(cond_val, cond_val_cmpy, cond_val_ent) as cond_val_calc,

   CASE
     WHEN val_adv_lev = 1 THEN net_val_adv
     WHEN val_adv_lev = 2 THEN net_val_adv_cmpy
     WHEN val_adv_lev = 3 THEN net_val_adv_ent
     ELSE null
   END as net_val_adv_calc,
   COALESCE(net_val, net_val_cmpy, net_val_ent) as net_val_calc,

   CASE
     WHEN val_adv_lev = 1 THEN tax_rate_adv
     WHEN val_adv_lev = 2 THEN tax_rate_adv_cmpy
     WHEN val_adv_lev = 3 THEN tax_rate_adv_ent
     ELSE null
   END as tax_rate_adv_calc,
   COALESCE(tax_rate, tax_rate_cmpy, tax_rate_ent) as tax_rate_calc,

   CASE
     WHEN val_adv_lev = 1 THEN reason_price_modifi_adv
     WHEN val_adv_lev = 2 THEN reason_price_modifi_adv_cmpy
     WHEN val_adv_lev = 3 THEN reason_price_modifi_adv_ent
     ELSE null
   END as reason_price_modifi_adv_calc

   FROM p_lew_bil.t_item_loc_sales_cond_denorm_2;