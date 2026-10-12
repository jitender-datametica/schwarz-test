create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_INIT_LIEF_MODUS_KZ_SPR_ZU_2(
	INIT_LIEF_MODUS_KZ,
	INIT_LIEF_MODUS_KZ_BEZ,
	INIT_LIEF_MODUS_KZ_BEZ_DE,
	INIT_LIEF_MODUS_KZ_BEZ_CZ,
	INIT_LIEF_MODUS_KZ_BEZ_SK,
	INIT_LIEF_MODUS_KZ_BEZ_HR,
	INIT_LIEF_MODUS_KZ_BEZ_PL,
	INIT_LIEF_MODUS_KZ_BEZ_RO,
	INIT_LIEF_MODUS_KZ_BEZ_BG
) as
 --2024-10-10, AP0215121, SPEC0270688, dknop, initial
    
    SELECT
    'S' AS init_lief_modus_kz
   ,'Simulation' AS init_lief_modus_kz_bez
   ,'Simulation' AS init_lief_modus_kz_bez_de
   ,'simulation' AS init_lief_modus_kz_bez_cz
   ,'simulation' AS init_lief_modus_kz_bez_sk
   ,'simulation' AS init_lief_modus_kz_bez_hr
   ,'simulation' AS init_lief_modus_kz_bez_pl
   ,'simulare'   AS init_lief_modus_kz_bez_ro
   ,'Симулация'  AS init_lief_modus_kz_bez_bg
   
   UNION
   
   SELECT
    'O' AS init_lief_modus_kz
   ,'Bestellung' AS init_lief_modus_kz_bez
   ,'Bestellung' AS init_lief_modus_kz_bez_de
   ,'Bestellung' AS init_lief_modus_kz_bez_cz
   ,'order' AS init_lief_modus_kz_bez_sk
   ,'order' AS init_lief_modus_kz_bez_hr
   ,'order' AS init_lief_modus_kz_bez_pl
   ,'comanda'   AS init_lief_modus_kz_bez_ro
   ,'Поръчка'  AS init_lief_modus_kz_bez_bg;