CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_init_lief_modus_kz_spr_zu AS SELECT 'S' AS init_lief_modus_kz
 ,
 'Simulation' AS init_lief_modus_kz_bez,
 'Simulation' AS init_lief_modus_kz_bez_de,
 'simulation' AS init_lief_modus_kz_bez_cz,
 'simulation' AS init_lief_modus_kz_bez_sk,
 'simulation' AS init_lief_modus_kz_bez_hr,
 'simulation' AS init_lief_modus_kz_bez_pl,
 'simulare' AS init_lief_modus_kz_bez_ro,
 'Симулация' AS init_lief_modus_kz_bez_bg
UNION ALL
SELECT 'O' AS init_lief_modus_kz,
 'Bestellung' AS init_lief_modus_kz_bez,
 'Bestellung' AS init_lief_modus_kz_bez_de,
 'Bestellung' AS init_lief_modus_kz_bez_cz,
 'order' AS init_lief_modus_kz_bez_sk,
 'order' AS init_lief_modus_kz_bez_hr,
 'order' AS init_lief_modus_kz_bez_pl,
 'comanda' AS init_lief_modus_kz_bez_ro,
 'Поръчка' AS init_lief_modus_kz_bez_bg;