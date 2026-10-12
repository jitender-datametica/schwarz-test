CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_campaign_receipt_cnt_1 (division_id, country_id, campaign_id,
gtin_id, receipt_cnt, receipt_shopper_cnt) AS SELECT division_id,
 country_id,
 campaign_id,
 gtin_id,
 receipt_cnt,
 receipt_shopper_cnt
FROM smp_production_core.t_dooh_campaign_receipt_cnt_1;