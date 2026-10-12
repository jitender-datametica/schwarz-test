CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MONAT_SPR_ZU_2
(
mo_gj
,mo_kj
,mo_bez
,mo_bez_cz
,mo_bez_sk
,mo_bez_hr
,mo_bez_pl
,mo_bez_ro
,mo_bez_en
,mo_bez_bg
,kjmo
,kj
,gj
,gjmo
,mo_bez_lang
,mo_bez_lang_cz
,mo_bez_lang_sk
,mo_bez_lang_hr
,mo_bez_lang_pl
,mo_bez_lang_ro
,mo_bez_lang_en
,mo_bez_lang_bg
,v_mo_bez_lang
,v_mo_bez_lang_cz
,v_mo_bez_lang_sk
,v_mo_bez_lang_hr
,v_mo_bez_lang_pl
,v_mo_bez_lang_ro
,v_mo_bez_lang_en
,v_mo_bez_lang_bg


)
AS
   SELECT
  m.mo_gj, s.mo_id, MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END) AS mo_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN s.spr_id = 124 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN s.spr_id = 108 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN s.spr_id = 65 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN s.spr_id = 90 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN s.spr_id = 95 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN s.spr_id = 24 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN s.spr_id = 18 THEN s.mo_bez ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN s.mo_bez ELSE NULL END)) AS mo_bez_bg    -- BG
   , m.kjmo, m.kj, m.gj, gjmo, MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END) AS mo_bez_lang                 -- standard == DE
   , COALESCE(MAX(CASE WHEN s.spr_id = 124 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_cz    -- CZ
   , COALESCE(MAX(CASE WHEN s.spr_id = 108 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_sk    -- SK
   , COALESCE(MAX(CASE WHEN s.spr_id = 65 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_hr    -- HR
   , COALESCE(MAX(CASE WHEN s.spr_id = 90 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_pl    -- PL
   , COALESCE(MAX(CASE WHEN s.spr_id = 95 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_ro    -- RO
   , COALESCE(MAX(CASE WHEN s.spr_id = 24 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_en    -- EN
   , COALESCE(MAX(CASE WHEN s.spr_id = 18 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s.mo_bez)|| ' ' ||TRIM(m.kj) ELSE NULL END)) AS mo_bez_lang_bg    -- BG
   , MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END) AS v_mo_bez_lang                 -- standard == DE
   , COALESCE(MAX(CASE WHEN s.spr_id = 124 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_cz    -- CZ
   , COALESCE(MAX(CASE WHEN s.spr_id = 108 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_sk    -- SK
   , COALESCE(MAX(CASE WHEN s.spr_id = 65 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_hr    -- HR
   , COALESCE(MAX(CASE WHEN s.spr_id = 90 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_pl    -- PL
   , COALESCE(MAX(CASE WHEN s.spr_id = 95 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_ro    -- RO
   , COALESCE(MAX(CASE WHEN s.spr_id = 24 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_en    -- EN
   , COALESCE(MAX(CASE WHEN s.spr_id = 18 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END), MAX(CASE WHEN s.spr_id =  22 THEN TRIM(s2.mo_bez)|| ' ' ||TRIM(CASE WHEN s.mo_id = 1 THEN m.kj-1 ELSE m.kj END) ELSE NULL END)) AS v_mo_bez_lang_bg    -- BG

   FROM dbp_view.v_monat_spr_zu_2 s
   JOIN dbp_view.v_monat_spr_zu_2 s2
   ON CASE WHEN s.mo_id = 1 THEN 12 ELSE s.mo_id -1 END = s2.mo_id
   AND s.spr_id = s2.spr_id
   JOIN dbp_view.v_monat_2 m
   ON s.mo_id=m.mo_kj

   GROUP BY
   m.mo_gj
   ,s.mo_id
   ,m.kjmo
   ,m.kj
   ,m.gj
   ,gjmo;