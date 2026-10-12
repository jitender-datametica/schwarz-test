CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hfm_inventur_termin_wg_wup_zu_per_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 wg_id,
 arthiertyp_id,
 dat_plan_zaehlung,
 inventurart_int_id,
 wrg_id,
 dat_vorletzte_zaehlung,
 umsatz_vk_netto_sum,
 inventur_wert_vk_netto
FROM kfl_production_dbp_data.hfm_inventur_termin_wg_wup_zu_per_2;