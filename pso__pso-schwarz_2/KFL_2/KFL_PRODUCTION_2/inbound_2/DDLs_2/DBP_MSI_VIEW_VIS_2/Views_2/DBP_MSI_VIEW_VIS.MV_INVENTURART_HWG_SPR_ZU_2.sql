CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_HWG_SPR_ZU_2 as
   -- LOOKUP-SPRACHE : Inventurart (INT) pro HWG
   -- haendisch zugeordnet
   -- 2017.0620 : Initial, VTC Inventur_2
   -- 2017.0815 : Uebersetzungen/mehrsprachig
   -- 2017.1211 : neue Inventurart

   SELECT
   inventur_hwg_id, MAX(inventurart_hwg_bez)    AS inventurart_hwg_bez, MAX(inventurart_hwg_bez_cz) AS inventurart_hwg_bez_cz, MAX(inventurart_hwg_bez_sk) AS inventurart_hwg_bez_sk, MAX(inventurart_hwg_bez_hr) AS inventurart_hwg_bez_hr, MAX(inventurart_hwg_bez_pl) AS inventurart_hwg_bez_pl, MAX(inventurart_hwg_bez_ro) AS inventurart_hwg_bez_ro, MAX(inventurart_hwg_bez_bg) AS inventurart_hwg_bez_bg, MAX(inventurart_hwg_bez_de) AS inventurart_hwg_bez_de
   FROM
   (
   SELECT
   ias.inventurart_int_id * 100 + wgh.wg_hierarchie_id::INTEGER AS inventur_hwg_id, CASE WHEN ias.spr_id=22 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food Frische' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'WG Inventur_2'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'WG Inventur_2'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Nebengeschäft'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'Interne Inventur_2' END
   END::VARCHAR (100) AS inventurart_hwg_bez, CASE WHEN ias.spr_id=124 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food Frische' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'WG inventura'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'WG inventura'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'filiálka'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'interně inventura' end
   END::VARCHAR (100) AS inventurart_hwg_bez_cz, CASE WHEN ias.spr_id=108 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food Frische' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'WG inventúra_2'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'WG inventúra_2'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Prídavny predaj'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'Interne inventúra_2' end
   END::VARCHAR (100) AS inventurart_hwg_bez_sk, CASE WHEN ias.spr_id=65 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food Frische'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food Frische' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'WG inventura'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'WG inventura'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Nebengeschäft'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'Interno inventura' end
   END::VARCHAR (100) AS inventurart_hwg_bez_hr, CASE WHEN ias.spr_id=90 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Świeże'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food Świeże'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food Świeże' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'inwentaryz. GT'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'inwentaryz. GT'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Działalność dodatkowa'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'inwentaryz. wewnętrznie' end
   END::VARCHAR (100) AS inventurart_hwg_bez_pl, CASE WHEN ias.spr_id=95 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ultra-Proaspete'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Food proaspete'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Food proaspete' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Food'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Food' || ' ' || 'inventar GM'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Nonfood' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Nonfood' || ' ' || 'inventar GM'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Altele'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'inventar intern' end
   END::VARCHAR (100) AS inventurart_hwg_bez_ro, CASE WHEN ias.spr_id=18 THEN CASE
   WHEN wgh.wg_hierarchie_id IN (1,2,3,4) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)   THEN 'Ултра свежи'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (1,2,3,6,7)        THEN 'Свежи храни'
   WHEN wgh.wg_hierarchie_id IN (5,6,17) AND ias.inventurart_int_id IN (4,5)              THEN 'Свежи храни' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Храни'|| ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (7,8,9,10,11) AND ias.inventurart_int_id IN (7)           THEN 'Храни' || ' ' || 'ПГ Инвент.'
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (1,2,3,4,5,6) THEN 'Нехрани' || ' ' || ias.inventurart_int_bez
   WHEN wgh.wg_hierarchie_id IN (12,13,14,15) AND ias.inventurart_int_id IN (7)           THEN 'Нехрани' || ' ' || 'ПГ Инвент.'
   WHEN wgh.wg_hierarchie_id IN (16) AND ias.inventurart_int_id IN (1,2,3,4,5,6,7)        THEN 'Допълнит. дейности'
   WHEN ias.inventurart_int_id IN (8)                               THEN 'Historie GJ'
   ELSE 'Вътрешна инвент.' end
   END::VARCHAR (100) AS inventurart_hwg_bez_bg, inventurart_hwg_bez AS inventurart_hwg_bez_de
   FROM dbp_view.v_wg_hierarchie_zu_per_2  wgh
   CROSS JOIN dbp_view.v_inventurart_int_spr_zu_2  ias

   WHERE wgh.arthiertyp_id = 5 AND wgh.wg_hierarchie_ebene_id = 3 -- HWG
   AND wgh.dat_bis = '9999-12-31'

   ) sub01

   GROUP BY inventur_hwg_id;