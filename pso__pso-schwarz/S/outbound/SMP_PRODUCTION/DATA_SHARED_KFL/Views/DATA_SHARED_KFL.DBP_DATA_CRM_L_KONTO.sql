CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_crm_l_konto (crm_konto_id, crm_kunde_id, crm_konto_typ_id
, crm_kundenprogramm_id, zeit_von, zeit_bis, geloescht_fg, crm_konto_nr, td_insert, td_update) AS SELECT crm_konto_id,
 crm_kunde_id,
 crm_konto_typ_id,
 crm_kundenprogramm_id,
 zeit_von,
 zeit_bis,
 geloescht_fg,
 crm_konto_nr,
 td_insert,
 td_update
FROM kfl_production_dbp_data.crm_l_konto;