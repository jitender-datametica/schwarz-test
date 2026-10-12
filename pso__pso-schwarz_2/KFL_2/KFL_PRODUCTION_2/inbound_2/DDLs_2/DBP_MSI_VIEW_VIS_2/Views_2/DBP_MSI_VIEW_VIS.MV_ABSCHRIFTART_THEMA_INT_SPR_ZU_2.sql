CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_THEMA_INT_SPR_ZU_2 as
   -- SPRACHE Abschriftart Thema Int
   -- 2017-0221 : Initial

   SELECT
   atis.abschriftart_thema_int_id, MAX(CASE WHEN spr_id =  22 THEN abschriftart_thema_int_bez END)                                          AS abschriftart_thema_int_bez     -- default (DE)
   , MAX(CASE WHEN spr_id =  22 THEN abschriftart_thema_int_bez END)                                          AS abschriftart_thema_int_bez_de  -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_sk  -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN abschriftart_thema_int_bez END), abschriftart_thema_int_bez_de) AS abschriftart_thema_int_bez_bg  -- BG

   FROM dbp_view.v_abschriftart_thema_int_spr_zu_2  atis

   GROUP BY 1
   ;