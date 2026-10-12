CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_ods_bon_kopf_kunde_tag_sum_2 AS SELECT crm_kunde_id,
 crm_loyaltyaccount_id,
 kundenkarte_id,
 crm_kundenkarte_art_id,
 wup_id,
 nb_id,
 mandant_id,
 dat,
 anz_bons,
 ums_brutto,
 ums_netto
FROM kfl_production_dbp_data.crm_ods_bon_kopf_kunde_tag_sum_2;