CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_KATEGORIE_SPR_ZU_2 as
   -- 24.02.2015 srom: ANF 610089, Anpassungen wegen Änderung Datenmodell
   -- bisher war der Inhalt von teku_kategorie_nr in teku_kategorie_id (es gab in der Lookup nur tek_kategorie_id mit den echten Kategorienummern)
   -- in der neuen Welt, gibt es jetzt teku_kategorie_nr und teku_kategorie_id (mit einem techn. Schlüssel)
   -- das MSI Attribut Kategorie wurde ursprünglich im Schlüssel (ID) auf das Feld kategorie_id gebaut, darauf alle weiteren Objekte.
   -- man kann innerhalb des Attributes nun nicht einfach die ID Felder wechseln.
   -- daher wurde im Attribut nur _id in _nr umbenannt und auf teku_attribut_nr gelegt
   -- in MSI bleibt also alles beim alten und es wird nun in der MSI-SQL ggf. über den fachl. Schlüssel (teku_kategorie_nr) und nicht über den techn. Schlüssel (teku_kategorie_id) ge-joined
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   ltk.teku_kategorie_nr, MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez ELSE NULL END) AS teku_kategorie_bez          --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez ELSE NULL END) AS teku_kategorie_bez_de     --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN tksp.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN tksp.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_cz                  --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN tksp.teku_kategorie_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_pl                  --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN tksp.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN tksp.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_sk                    --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN tksp.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_hr                    --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN tksp.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN tksp.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_ro                  --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN tksp.teku_kategorie_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN tksp.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN tksp.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_bg                  --bulgarisch
   , CASE
   WHEN ltk.teku_kategorie_nr BETWEEN 310 AND 328  THEN 10000 + ltk.teku_kategorie_nr
   WHEN ltk.teku_kategorie_nr BETWEEN 144 AND 145  THEN 20000 + ltk.teku_kategorie_nr
   ELSE ltk.teku_kategorie_nr
   END AS tkfil_sort_id                            -- Sortierung im TKFIL- Bericht
   , CASE
   WHEN ltk.teku_kategorie_nr = 892 THEN 879
   ELSE ltk.teku_kategorie_nr
   END AS  tek3_sort_id                    -- Sortierung im TEK3- Bericht (Kat 892 soll zwischen 870 und 880)
   FROM dbp_view.v_teku_kategorie_spr_zu_2 tksp
   INNER JOIN dbp_view.v_l_teku_kategorie_2 ltk
   ON tksp.teku_kategorie_id = ltk.teku_kategorie_id
   GROUP BY
   ltk.teku_kategorie_nr
   ,CASE
   WHEN ltk.teku_kategorie_nr BETWEEN 310 AND 328 THEN 10000 + ltk.teku_kategorie_nr
   WHEN ltk.teku_kategorie_nr BETWEEN 144 AND 145 THEN 20000 + ltk.teku_kategorie_nr
   ELSE ltk.teku_kategorie_nr
   END
   ,CASE
   WHEN ltk.teku_kategorie_nr = 892 THEN 879
   ELSE ltk.teku_kategorie_nr
   END
   UNION ALL
   SELECT
   t011.teku_kategorie_nr + (t02.dat - CURRENT_DATE) _kat_nr, MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez ELSE NULL END) AS teku_kategorie_bez    --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez ELSE NULL END) AS teku_kategorie_bez_de --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN t01.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN t01.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_cz                    --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN t01.teku_kategorie_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN t01.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_pl                  --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN t01.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN t01.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_sk                  --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN t01.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN t01.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_hr                  --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN t01.teku_kategorie_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN t01.teku_kategorie_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez  ELSE NULL END)
   END AS teku_kategorie_bez_ro                  --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN t01.teku_kategorie_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN t01.teku_kategorie_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN t01.teku_kategorie_bez ELSE NULL END)
   END AS teku_kategorie_bez_bg                --bulgarisch
   , _kat_nr AS tkfil_sort_id                             --Sortierung im TKFIL- Bericht
   , _kat_nr AS tek3_sort_id                              --Sortierung im TEK3- Bericht (Kat 892 soll zwischen 870 und 880)
   FROM dbp_view.v_teku_kategorie_spr_zu_2 t01
   INNER JOIN dbp_view.v_l_teku_kategorie_2 t011
   ON t01.teku_kategorie_id = t011.teku_kategorie_id
   -- twz initions: changed Cross Join syntax
   CROSS JOIN dbp_view.v_tag_2 t02
   WHERE
   t011.teku_kategorie_nr = 9999
   AND   t02.dat BETWEEN CURRENT_DATE -3 AND CURRENT_DATE -1
   GROUP BY
   t011.teku_kategorie_nr + (t02.dat - CURRENT_DATE)
   ,_kat_nr
   ,_kat_nr;