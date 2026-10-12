CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_PROJEKT_BAUABSCHNITT_SPR_ZU_2
AS
   SELECT

   v02.projekt_id,
   CASE  WHEN  v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN v02.projekt_id || v02.projekt_phase_id
   ELSE v02.projekt_id || '0000' END  AS bauabschnitt_id
   , COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN v05.cpr_phase_bez
   ELSE v04.cpr_projekt_bez END, ' ') AS bauabschnitt_bez
   , COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' ')  AS bauabschnitt_langtext, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  124 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  124 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_cz, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  108 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  108 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_sk, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  65 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  65 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_hr, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  90 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  90 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_pl, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  95 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  95 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_ro, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  24 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  24 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_en, COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  18 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  18 THEN v04.cpr_projekt_langtext  ELSE NULL END) END,
   --deutsch als Fallback
   COALESCE(CASE WHEN v03.cpr_suchfeld_id = 161 AND v02.teil_massn_kz > 1
   THEN MAX(CASE WHEN v05.spr_id =  22 THEN v05.cpr_phase_langtext ELSE NULL END)
   ELSE MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_langtext  ELSE NULL END) END, ' '))  AS bauabschnitt_langtext_bg, MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END) AS cpr_projekt_bez_sort                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v04.spr_id = 124 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v04.spr_id = 108 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_sk    -- SK
   , COALESCE(MAX(CASE WHEN v04.spr_id = 65 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_hr    -- HR
   , COALESCE(MAX(CASE WHEN v04.spr_id = 90 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_pl    -- PL
   , COALESCE(MAX(CASE WHEN v04.spr_id = 95 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_ro    -- RO
   , COALESCE(MAX(CASE WHEN v04.spr_id = 24 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_en    -- EN
   , COALESCE(MAX(CASE WHEN v04.spr_id = 18 THEN v04.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN v04.spr_id =  22 THEN v04.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sort_bg    -- BG

   FROM dbp_view.v_cpr_phase_per_2  v02
   LEFT JOIN dbp_view.v_cpr_aufgabe_per_2 v03
   ON v02.projekt_phase_id = v03.projekt_phase_id
   AND v03.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2 v04
   ON v02.projekt_id = v04.projekt_id
   AND v04.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per_2 v05
   ON v02.projekt_phase_id = v05.projekt_phase_id
   AND v05.dat_bis = '9999-12-31'
   --AND v05.spr_id = 22


   WHERE v02.dat_bis = '9999-12-31'
   GROUP BY  v02.projekt_id, bauabschnitt_id,bauabschnitt_bez, v03.cpr_suchfeld_id, v02.teil_massn_kz;