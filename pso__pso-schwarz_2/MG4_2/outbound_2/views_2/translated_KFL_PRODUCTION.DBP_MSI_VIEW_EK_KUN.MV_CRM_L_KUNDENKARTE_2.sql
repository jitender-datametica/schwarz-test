CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kundenkarte_2 (kundenkarte_id, mandant_id,
crm_kundenkarte_art_id, crm_kundenkarte_nr, crm_konto_id, gesperrt_fg, zeit_von, zeit_bis, geloescht_fg_kundenkarte) AS
SELECT kundenkarte_id,
 mandant_id,
 crm_kundenkarte_art_id,
 crm_kundenkarte_nr,
 crm_konto_id,
 gesperrt_fg,
 zeit_von,
 zeit_bis,
 geloescht_fg AS geloescht_fg_kundenkarte
FROM kfl_production_dbp_view.v_crm_l_kundenkarte_2;