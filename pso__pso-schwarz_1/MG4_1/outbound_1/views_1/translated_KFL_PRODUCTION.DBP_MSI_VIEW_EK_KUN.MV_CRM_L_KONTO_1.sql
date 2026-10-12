CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_konto_1 (crm_konto_id, crm_kunde_id, crm_konto_typ_id,
crm_kundenprogramm_id, zeit_von, zeit_bis, dat_bis, geloescht_fg_konto) AS SELECT crm_konto_id,
 crm_kunde_id,
 crm_konto_typ_id,
 crm_kundenprogramm_id,
 zeit_von,
 zeit_bis,
 DATE(zeit_bis) AS dat_bis,
 geloescht_fg AS geloescht_fg_konto
FROM kfl_production_dbp_view.v_crm_l_konto_1;