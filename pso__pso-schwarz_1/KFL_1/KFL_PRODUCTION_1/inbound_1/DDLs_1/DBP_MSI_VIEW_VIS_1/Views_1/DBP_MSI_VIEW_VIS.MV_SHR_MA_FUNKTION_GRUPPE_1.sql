CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SHR_MA_FUNKTION_GRUPPE_1 as
   -- LOOKUP/SPRACHE
   -- MA Funktionsgruppen / Bezeichnung (mehrsprachig)
   -- 2017.1109 ssch0611 : initial

   SELECT
   smfg.shr_ma_funktion_gruppe_id, CASE WHEN shr_ma_funktion_gruppe_id < 0 THEN 1000 - smfg.shr_ma_funktion_gruppe_id ELSE smfg.shr_ma_funktion_gruppe_id END AS shr_ma_funktion_sort_id, COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez     -- default (DE)
   , COALESCE(MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_sk  -- SK
   , COALESCE(MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END), COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id))) AS shr_ma_funktion_gruppe_bez_bg  -- BG
   , COALESCE(MAX(CASE WHEN smfg.spr_id =  22 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id = 124 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id = 108 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  65 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  90 THEN smfg.shr_ma_funktion_gruppe_bez END), MAX(CASE WHEN smfg.spr_id =  95 THEN smfg.shr_ma_funktion_gruppe_bez END),
   MAX(CASE WHEN smfg.spr_id =  18 THEN smfg.shr_ma_funktion_gruppe_bez END),
   'MA-Funktion ' || TRIM(smfg.shr_ma_funktion_gruppe_id)) AS shr_ma_funktion_gruppe_bez_de  -- Dummy_1

   FROM dbp_view.v_shr_ma_funktion_gruppe_spr_zu_1  smfg

   GROUP BY 1
   ;