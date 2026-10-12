CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_crm_l_kundenkarte_1 (kundenkarte_id, mandant_id,
crm_kundenkarte_art_id, crm_kundenkarte_nr, crm_konto_id, gesperrt_fg, zeit_von, zeit_bis, geloescht_fg, td_insert,
td_update) AS SELECT kundenkarte_id,
 mandant_id,
 crm_kundenkarte_art_id,
 crm_kundenkarte_nr,
 crm_konto_id,
 gesperrt_fg,
 zeit_von,
 zeit_bis,
 geloescht_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_l_kundenkarte_1;