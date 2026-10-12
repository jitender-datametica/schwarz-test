CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_termin_art_wup_zu_per_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_plan_zaehlung,
 art_id,
 dat_vorletzte_zaehlung,
 inventurart_int_vorletzte_zaehlung,
 wrg_id,
 umsatz_vk_netto_sum,
 inventur_wert_vk_netto
FROM kfl_production_dbp_data.inventur_termin_art_wup_zu_per_1;