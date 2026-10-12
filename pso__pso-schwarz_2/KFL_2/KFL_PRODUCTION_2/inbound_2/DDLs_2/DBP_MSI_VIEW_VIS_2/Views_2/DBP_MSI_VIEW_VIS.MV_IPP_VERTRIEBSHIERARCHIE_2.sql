CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IPP_VERTRIEBSHIERARCHIE_2
AS
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   /*  Ebene 5 = Land_2/Mandant_2 */
   SELECT
     mandant_id
   , TRIM( (to_char(mandant_id, '00'))) || '.99.999999.999999.999999'  AS id
   , 5::BYTEINT ebene_id
   , CAST ('ZZZZZ' AS VARCHAR(40))                            vs_sort
   , CAST ('' AS VARCHAR(40)) gf_sort
   , CAST ('' AS VARCHAR(40)) vkl_sort
   , CAST ('Gesamt' AS VARCHAR(40))                    vs_bez
   , CAST ('' AS VARCHAR(40)) gf_anrede
   , CAST ('' AS VARCHAR(40))   gf_name
   , CAST ('' AS VARCHAR(40))   gf_vorname
   , CAST ('' AS VARCHAR(40))   vkl_anrede
   , CAST ('' AS VARCHAR(40))   vkl_name
   , CAST ('' AS VARCHAR(40))   vkl_vorname
   , CAST (NULL AS INTEGER)                             wup_id_bez
   , CAST ('' AS VARCHAR(40))                                   wup_standort
   , CAST ('Gesamt' AS VARCHAR(40))                                    vs_bez_de
   , CAST ('' AS VARCHAR(40))   gf_anrede_de
   , CAST ('' AS VARCHAR(40))   gf_name_de
   , CAST ('' AS VARCHAR(40))   gf_vorname_de
   , CAST ('' AS VARCHAR(40)) vkl_anrede_de
   , CAST ('' AS VARCHAR(40)) vkl_name_de
   , CAST ('' AS VARCHAR(40)) vkl_vorname_de
   , CAST (NULL AS INTEGER)                           wup_id_bez_de
   , CAST ('' AS VARCHAR(40))                                 wup_standort_de
   , CAST ('Celkem' AS VARCHAR(40))                                         vs_bez_cz
   , CAST ('' AS VARCHAR(40)) gf_anrede_cz
   , CAST ('' AS VARCHAR(40)) gf_name_cz
   , CAST ('' AS VARCHAR(40)) gf_vorname_cz
   , CAST ('' AS VARCHAR(40)) vkl_anrede_cz
   , CAST ('' AS VARCHAR(40)) vkl_name_cz
   , CAST ('' AS VARCHAR(40)) vkl_vorname_cz
   , CAST (NULL AS INTEGER)                           wup_id_bez_cz
   , CAST ('' AS VARCHAR(40))                                 wup_standort_cz
   , CAST ('Suma' AS VARCHAR(40))                                   vs_bez_pl
   , CAST ('' AS VARCHAR(40)) gf_anrede_pl
   , CAST ('' AS VARCHAR(40)) gf_name_pl
   , CAST ('' AS VARCHAR(40)) gf_vorname_pl
   , CAST ('' AS VARCHAR(40)) vkl_anrede_pl
   , CAST ('' AS VARCHAR(40)) vkl_name_pl
   , CAST ('' AS VARCHAR(40)) vkl_vorname_pl
   , CAST (NULL AS INTEGER)                           wup_id_bez_pl
   , CAST ('' AS VARCHAR(40))                                 wup_standort_pl
   , CAST ('Celkom' AS VARCHAR(40))                                  vs_bez_sk
   , CAST ('' AS VARCHAR(40)) gf_anrede_sk
   , CAST ('' AS VARCHAR(40)) gf_name_sk
   , CAST ('' AS VARCHAR(40)) gf_vorname_sk
   , CAST ('' AS VARCHAR(40)) vkl_anrede_sk
   , CAST ('' AS VARCHAR(40)) vkl_name_sk
   , CAST ('' AS VARCHAR(40)) vkl_vorname_sk
   , CAST (NULL AS INTEGER)                           wup_id_bez_sk
   , CAST ('' AS VARCHAR(40))                                 wup_standort_sk
   , CAST ('Ukupno' AS VARCHAR(40))                                  vs_bez_hr
   , CAST ('' AS VARCHAR(40)) gf_anrede_hr
   , CAST ('' AS VARCHAR(40)) gf_name_hr
   , CAST ('' AS VARCHAR(40)) gf_vorname_hr
   , CAST ('' AS VARCHAR(40)) vkl_anrede_hr
   , CAST ('' AS VARCHAR(40)) vkl_name_hr
   , CAST ('' AS VARCHAR(40)) vkl_vorname_hr
   , CAST (NULL AS INTEGER)                           wup_id_bez_hr
   , CAST ('' AS VARCHAR(40))                                 wup_standort_hr
   , CAST ('Total' AS VARCHAR(40))                                     vs_bez_ro
   , CAST ('' AS VARCHAR(40)) gf_anrede_ro
   , CAST ('' AS VARCHAR(40)) gf_name_ro
   , CAST ('' AS VARCHAR(40)) gf_vorname_ro
   , CAST ('' AS VARCHAR(40)) vkl_anrede_ro
   , CAST ('' AS VARCHAR(40)) vkl_name_ro
   , CAST ('' AS VARCHAR(40)) vkl_vorname_ro
   , CAST (NULL AS INTEGER)                           wup_id_bez_ro
   , CAST ('' AS VARCHAR(40))                                 wup_standort_ro
   ,  '\u041E\u0431\u0449\u043E'                                  vs_bez_bg
   , CAST ('' AS VARCHAR(40)) gf_anrede_bg, CAST ('' AS VARCHAR(40)) gf_name_bg, CAST ('' AS VARCHAR(40)) gf_vorname_bg, CAST ('' AS VARCHAR(40)) vkl_anrede_bg, CAST ('' AS VARCHAR(40)) vkl_name_bg, CAST ('' AS VARCHAR(40)) vkl_vorname_bg, CAST (NULL AS INTEGER)                           wup_id_bez_bg, CAST ('' AS VARCHAR(40))                                 wup_standort_bg

   FROM dbp_view.v_mandant_2

   UNION ALL
   /*  Ebene 4 = GL */
   SELECT
   mandant_id
   , TRIM( (to_char(mandant_id, '00'))) || '.' || TRIM( (to_char(vs_id, '00'))) || '.999999.999999.999999'  AS id
   , 4::BYTEINT ebene_id, COALESCE (vs_bez, '') || 'ZZZ'                                   vs_sort
   , CAST ('' AS VARCHAR(40)) gf_sort
   , CAST ('' AS VARCHAR(40)) vkl_sort
   , 'Gesamt ' || COALESCE (vs_bez, '')                                 vs_bez
   , CAST ('' AS VARCHAR(40)) gf_anrede
   , CAST ('' AS VARCHAR(40)) gf_name
   , CAST ('' AS VARCHAR(40)) gf_vorname
   , CAST ('' AS VARCHAR(40)) vkl_anrede
   , CAST ('' AS VARCHAR(40)) vkl_name
   , CAST ('' AS VARCHAR(40)) vkl_vorname
   , CAST (NULL AS INTEGER)                           wup_id_bez
   , CAST ('' AS VARCHAR(40))                                 wup_standort
   , 'Gesamt ' || COALESCE (vs_bez, '')                                 vs_bez_de
   , CAST ('' AS VARCHAR(40)) gf_anrede_de
   , CAST ('' AS VARCHAR(40)) gf_name_de
   , CAST ('' AS VARCHAR(40)) gf_vorname_de
   , CAST ('' AS VARCHAR(40)) vkl_anrede_de
   , CAST ('' AS VARCHAR(40)) vkl_name_de
   , CAST ('' AS VARCHAR(40)) vkl_vorname_de
   , CAST (NULL AS INTEGER)                           wup_id_bez_de
   , CAST ('' AS VARCHAR(40))                                 wup_standort_de
   , 'Celkem ' || COALESCE (vs_bez, '')                                 vs_bez_cz
   , CAST ('' AS VARCHAR(40)) gf_anrede_cz
   , CAST ('' AS VARCHAR(40)) gf_name_cz
   , CAST ('' AS VARCHAR(40)) gf_vorname_cz
   , CAST ('' AS VARCHAR(40)) vkl_anrede_cz
   , CAST ('' AS VARCHAR(40)) vkl_name_cz
   , CAST ('' AS VARCHAR(40)) vkl_vorname_cz
   , CAST (NULL AS INTEGER)                           wup_id_bez_cz
   , CAST ('' AS VARCHAR(40))                                 wup_standort_cz
   , 'Suma ' || COALESCE (vs_bez, '')                                 vs_bez_pl
   , CAST ('' AS VARCHAR(40)) gf_anrede_pl
   , CAST ('' AS VARCHAR(40)) gf_name_pl
   , CAST ('' AS VARCHAR(40)) gf_vorname_pl
   , CAST ('' AS VARCHAR(40)) vkl_anrede_pl
   , CAST ('' AS VARCHAR(40)) vkl_name_pl
   , CAST ('' AS VARCHAR(40)) vkl_vorname_pl
   , CAST (NULL AS INTEGER)                           wup_id_bez_pl
   , CAST ('' AS VARCHAR(40))                                 wup_standort_pl
   , 'Celkom ' || COALESCE (vs_bez, '')                                 vs_bez_sk
   , CAST ('' AS VARCHAR(40)) gf_anrede_sk
   , CAST ('' AS VARCHAR(40)) gf_name_sk
   , CAST ('' AS VARCHAR(40)) gf_vorname_sk
   , CAST ('' AS VARCHAR(40)) vkl_anrede_sk
   , CAST ('' AS VARCHAR(40)) vkl_name_sk
   , CAST ('' AS VARCHAR(40)) vkl_vorname_sk
   , CAST (NULL AS INTEGER)                           wup_id_bez_sk
   , CAST ('' AS VARCHAR(40))                                 wup_standort_sk
   , 'Ukupno ' || COALESCE (vs_bez, '')                                 vs_bez_hr
   , CAST ('' AS VARCHAR(40)) gf_anrede_hr
   , CAST ('' AS VARCHAR(40)) gf_name_hr
   , CAST ('' AS VARCHAR(40)) gf_vorname_hr
   , CAST ('' AS VARCHAR(40)) vkl_anrede_hr
   , CAST ('' AS VARCHAR(40)) vkl_name_hr
   , CAST ('' AS VARCHAR(40)) vkl_vorname_hr
   , CAST (NULL AS INTEGER)                           wup_id_bez_hr
   , CAST ('' AS VARCHAR(40))                                 wup_standort_hr
   , 'Total ' || COALESCE (vs_bez, '')                                  vs_bez_ro
   , CAST ('' AS VARCHAR(40)) gf_anrede_ro
   , CAST ('' AS VARCHAR(40)) gf_name_ro
   , CAST ('' AS VARCHAR(40)) gf_vorname_ro  
   , CAST ('' AS VARCHAR(40)) vkl_anrede_ro
   , CAST ('' AS VARCHAR(40)) vkl_name_ro
   , CAST ('' AS VARCHAR(40)) vkl_vorname_ro
   , CAST (NULL AS INTEGER)                           wup_id_bez_ro
   , CAST ('' AS VARCHAR(40))                                 wup_standort_ro
   , '\u041E\u0431\u0449\u043E'   ||  ' ' || COALESCE (vs_bez, '')                                  vs_bez_bg
   , CAST ('' AS VARCHAR(40)) gf_anrede_bg, CAST ('' AS VARCHAR(40)) gf_name_bg, CAST ('' AS VARCHAR(40)) gf_vorname_bg, CAST ('' AS VARCHAR(40)) vkl_anrede_bg, CAST ('' AS VARCHAR(40)) vkl_name_bg, CAST ('' AS VARCHAR(40)) vkl_vorname_bg, CAST (NULL AS INTEGER)                           wup_id_bez_bg, CAST ('' AS VARCHAR(40))                                 wup_standort_bg

   FROM dbp_view.v_vs_2

   UNION ALL
   /* Ebene 3 = GF_2 */
   SELECT
   w.mandant_id, TRIM( (to_char(w.mandant_id, '00'))) || '.' || TRIM( (to_char(w.vs_id, '00'))) || '.' || TRIM( (to_char(wd.gf_gbl_vertrieb_id, '00')))    || '.999999.999999'  AS id, 3::BYTEINT                                         AS ebene_id, v.vs_bez                                           AS vs_sort, gf.ma_name || 'ZZZ'                                                 AS gf_sort, CAST ('' AS VARCHAR(40))     AS vkl_sort, MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)           vs_bez, MAX(CASE WHEN spr_id =   22 THEN 'Gesamt ' || COALESCE (gf.ma_anrede, '') ELSE NULL END)       gf_anrede, MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)        gf_name, MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)     gf_vorname, CAST ('' AS VARCHAR(40)) vkl_anrede, CAST ('' AS VARCHAR(40)) vkl_name, CAST ('' AS VARCHAR(40)) vkl_vorname, CAST (NULL AS INTEGER)                            wup_id_bez, CAST ('' AS VARCHAR(40))                                  wup_standort, MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)           vs_bez, MAX(CASE WHEN spr_id =   22 THEN 'Gesamt ' || COALESCE (gf.ma_anrede, '') ELSE NULL END)       gf_anrede, MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)        gf_name, MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)     gf_vorname, CAST ('' AS VARCHAR(40)) vkl_anrede_de, CAST ('' AS VARCHAR(40)) vkl_name_de, CAST ('' AS VARCHAR(40)) vkl_vorname_de, CAST (NULL AS INTEGER)                            wup_id_bez_de, CAST ('' AS VARCHAR(40))                                  wup_standort_de, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN 'Celkem ' || COALESCE (gf.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN 'Celkem ' || COALESCE (gf.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN 'Celkem ' || COALESCE (gf.ma_anrede, '') ELSE NULL END)
   END  gf_anrede_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_cz, CAST ('' AS VARCHAR(40)) vkl_anrede_cz, CAST ('' AS VARCHAR(40)) vkl_name_cz, CAST ('' AS VARCHAR(40)) vkl_vorname_cz, CAST (NULL AS INTEGER)                            wup_id_bez_cz, CAST ('' AS VARCHAR(40))                                  wup_standort_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN  'Suma ' || COALESCE (gf.ma_anrede, '')   ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN  'Suma ' || COALESCE (gf.ma_anrede, '')   ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN  'Suma ' || COALESCE (gf.ma_anrede, '')   ELSE NULL END)
   END gf_anrede_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_pl, CAST ('' AS VARCHAR(40)) vkl_anrede_pl, CAST ('' AS VARCHAR(40)) vkl_name_pl, CAST ('' AS VARCHAR(40)) vkl_vorname_pl, CAST (NULL AS INTEGER)                            wup_id_bez_pl, CAST ('' AS VARCHAR(40))                                  wup_standort_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN  'Celkom ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN  'Celkom ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN  'Celkom ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END)
   END gf_anrede_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_sk, CAST ('' AS VARCHAR(40)) vkl_anrede_sk, CAST ('' AS VARCHAR(40)) vkl_name_sk, CAST ('' AS VARCHAR(40)) vkl_vorname_sk, CAST (NULL AS INTEGER)                            wup_id_bez_sk, CAST ('' AS VARCHAR(40))                                  wup_standort_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN  'Ukupno ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN  'Ukupno ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN  'Ukupno ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END)
   END gf_anrede_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_hr, CAST ('' AS VARCHAR(40)) vkl_anrede_hr, CAST ('' AS VARCHAR(40)) vkl_name_hr, CAST ('' AS VARCHAR(40)) vkl_vorname_hr, CAST (NULL AS INTEGER)                            wup_id_bez_hr, CAST ('' AS VARCHAR(40))                                  wup_standort_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN  'Total ' || COALESCE (gf.ma_anrede, '')     ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN  'Total ' || COALESCE (gf.ma_anrede, '')     ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN  'Total ' || COALESCE (gf.ma_anrede, '')     ELSE NULL END)
   END gf_anrede_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_ro, CAST ('' AS VARCHAR(40)) vkl_anrede_ro, CAST ('' AS VARCHAR(40)) vkl_name_ro, CAST ('' AS VARCHAR(40)) vkl_vorname_ro, CAST (NULL AS INTEGER)                            wup_id_bez_ro, CAST ('' AS VARCHAR(40))                                  wup_standort_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN  '\u041E\u0431\u0449\u043E' || ' ' || COALESCE (gf.ma_anrede, '')     ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN  '\u041E\u0431\u0449\u043E' || ' ' || COALESCE (gf.ma_anrede, '')    ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN  '\u041E\u0431\u0449\u043E'  || ' ' || COALESCE (gf.ma_anrede, '')     ELSE NULL END)
   END gf_anrede_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_bg, CAST ('' AS VARCHAR(40)) vkl_anrede_bg, CAST ('' AS VARCHAR(40)) vkl_name_bg, CAST ('' AS VARCHAR(40)) vkl_vorname_bg, CAST (NULL AS INTEGER)                            wup_id_bez_bg, CAST ('' AS VARCHAR(40))                                  wup_standort_bg
   FROM dbp_view.v_wup_2  w
   INNER JOIN dbp_msi_v_view.v_wup_denorm_2 wd
   ON  wd.wup_id = w.wup_id
   AND wd.mandant_id = w.mandant_id
   INNER JOIN dbp_view.v_vs_2 v
   ON w.mandant_id = v.mandant_id
   AND w.vs_id = v.vs_id
   INNER JOIN dbp_view.v_ma_spr_zu_2 gf_2
   ON  wd.mandant_id = gf.mandant_id
   AND wd.gf_gbl_vertrieb_id = gf.ma_id
   WHERE
   wd.glv_land_id <> -1
   GROUP BY 1,2,3,4,5

   UNION ALL

   /* Ebene 2 = VKL_2 */
   SELECT
   w.mandant_id
   , TRIM( (to_char(w.mandant_id, '00'))) || '.' || TRIM( (to_char(w.vs_id, '00'))) || '.' || TRIM( to_char(wd.gf_gbl_vertrieb_id,'000000'))   || '.' || TRIM ( to_char(wd.vkl_id,'000000' )) || '.999999'  AS id
   , 2::BYTEINT             AS ebene_id
   --w.mandant_id, TRIM( (w.mandant_id (FORMAT '99'))) || '.' || TRIM( (w.vs_id (FORMAT '99'))) || '.' || TRIM( (wd.gf_gbl_vertrieb_id (FORMAT '9(6)')))  || '.' || TRIM ( (wd.vkl_id (FORMAT '9(6)')) ) || '.999999'  AS id, 2::BYTEINT             AS ebene_id
   , v.vs_bez                 AS vs_sort, gf.ma_name                   AS gf_sort, vkl.ma_name || 'ZZZ'         AS vkl_sort, MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)         AS vs_bez, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)     AS gf_anrede, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)      AS gf_name, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END) AS gf_vorname, MAX(CASE WHEN vkl.spr_id =   22 THEN 'Gesamt ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)  AS vkl_anrede, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)     AS vkl_name, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END) AS vkl_vorname, CAST (NULL AS INTEGER)                                             AS wup_id_bez, CAST ('' AS VARCHAR(40))                                                   AS wup_standort, MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)         AS vs_bez_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)     AS gf_anrede_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)      AS gf_name_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END) AS gf_vorname_de, MAX(CASE WHEN vkl.spr_id =   22 THEN 'Gesamt ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)  AS vkl_anrede_de, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)     AS vkl_name_de, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END) AS vkl_vorname_de, CAST (NULL AS INTEGER)                                             AS wup_id_bez_de, CAST ('' AS VARCHAR(40))                                                   AS wup_standort_de, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN  gf.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)
   END  gf_anrede_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN 'Celkem ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN 'Celkem ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN 'Celkem ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_cz, CAST (NULL AS INTEGER)                            wup_id_bez_cz, CAST ('' AS VARCHAR(40))                                  wup_standort_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN  gf.ma_anrede   ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN  gf.ma_anrede   ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede   ELSE NULL END)
   END gf_anrede_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN 'Suma ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN 'Suma ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN 'Suma ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_pl, CAST (NULL AS INTEGER)                            wup_id_bez_pl, CAST ('' AS VARCHAR(40))                                  wup_standort_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN  gf.ma_anrede    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN  gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede    ELSE NULL END)
   END gf_anrede_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN 'Celkom ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN 'Celkom ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN 'Celkom ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_sk, CAST (NULL AS INTEGER)                            wup_id_bez_sk, CAST ('' AS VARCHAR(40))                                  wup_standort_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN  gf.ma_anrede    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN  gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede    ELSE NULL END)
   END gf_anrede_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN 'Ukupno ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 65 THEN 'Ukupno ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN 'Ukupno ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id =65 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_hr, CAST (NULL AS INTEGER)                            wup_id_bez_hr, CAST ('' AS VARCHAR(40))                                  wup_standort_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_anrede  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_anrede     ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede  ELSE NULL END)
   END gf_anrede_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN 'Total ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN 'Total ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN 'Total ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_ro, CAST (NULL AS INTEGER)                            wup_id_bez_ro, CAST ('' AS VARCHAR(40))                                  wup_standort_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN  gf.ma_anrede     ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede    ELSE NULL END)
   END gf_anrede_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN '\u041E\u0431\u0449\u043E' || ' ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN '\u041E\u0431\u0449\u043E' || ' ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN  '\u041E\u0431\u0449\u043E' || ' ' || COALESCE (vkl.ma_anrede, '') ELSE NULL END)
   END  vkl_anrede_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_bg, CAST (NULL AS INTEGER)                            wup_id_bez_bg, CAST ('' AS VARCHAR(40))                                  wup_standort_bg

   FROM dbp_view.v_wup_2  w
   INNER JOIN dbp_msi_v_view.v_wup_denorm_2 wd
   ON  wd.wup_id = w.wup_id
   AND wd.mandant_id = w.mandant_id
   INNER JOIN dbp_view.v_vs_2 v
   ON  w.mandant_id = v.mandant_id
   AND w.vs_id = v.vs_id
   INNER JOIN dbp_view.v_ma_spr_zu_2 gf_2
   ON  wd.mandant_id = gf.mandant_id
   AND wd.gf_gbl_vertrieb_id = gf.ma_id
   INNER JOIN dbp_view.v_ma_spr_zu_2 vkl_2
   ON  wd.mandant_id = vkl.mandant_id
   AND wd.vkl_id = vkl.ma_id

   WHERE
   wd.glv_land_id <> -1
   GROUP BY 1,2,3,4,5,6

   UNION ALL
   /* Ebene 1= wup_2 */
   SELECT
   w.mandant_id
   , TRIM(to_char(w.mandant_id, '00')) || '.' || TRIM(to_char(w.vs_id, '00')) || '.' || TRIM( to_char(wd.gf_gbl_vertrieb_id , '000000'))  || '.' || TRIM( to_char(wd.vkl_id, '000000'))   || '.' || TRIM (to_char (w.wup_id ,'000000'))   AS id
   , 1::BYTEINT    ebene_id
   , v.vs_bez  AS                           vs_sort, gf.ma_name       AS gf_sort, vkl.ma_name     AS vkl_sort, MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)         AS vs_bez, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)     AS gf_anrede, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)      AS gf_name, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END) AS gf_vorname, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)  AS vkl_anrede, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)     AS vkl_name, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END) AS vkl_vorname, w.wup_id                                       AS wup_id_bez, w.wup_standort, MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)         AS vs_bez_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)     AS gf_anrede_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)      AS gf_name_de, MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END) AS gf_vorname_de, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)  AS vkl_anrede_de, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)     AS vkl_name_de, MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END) AS vkl_vorname_de, w.wup_id                                       AS wup_id_bez_de, w.wup_standort AS wup_standort_de, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN  gf.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede ELSE NULL END)
   END  gf_anrede_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 124 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_cz, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 124 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_cz, w.wup_id                                       AS wup_id_bez_cz, w.wup_standort AS wup_standort_cz, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN  gf.ma_anrede   ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN  gf.ma_anrede   ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede   ELSE NULL END)
   END gf_anrede_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 90 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_pl, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 90 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_pl, w.wup_id                                       AS wup_id_bez_pl, w.wup_standort AS wup_standort_pl, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN  gf.ma_anrede    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN  gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede    ELSE NULL END)
   END gf_anrede_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 108 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_sk, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 108 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_sk, w.wup_id                                       AS wup_id_bez_sk, w.wup_standort AS wup_standort_sk, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN  gf.ma_anrede    ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN  gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede    ELSE NULL END)
   END gf_anrede_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 65 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_hr, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 65 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id =65 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_hr, w.wup_id                                       AS wup_id_bez_hr, w.wup_standort AS wup_standort_hr, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_anrede  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_anrede     ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN  gf.ma_anrede  ELSE NULL END)
   END gf_anrede_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 95 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_ro, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 95 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_ro, w.wup_id                                       AS wup_id_bez_ro, w.wup_standort               AS wup_standort_ro, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN v.vs_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN v.vs_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN v.vs_bez ELSE NULL END)
   END vs_bez_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN  gf.ma_anrede     ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_anrede    ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_anrede    ELSE NULL END)
   END gf_anrede_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_name ELSE NULL END)
   END gf_name_bg, CASE
   WHEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN gf.spr_id = 18 THEN gf.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN gf.spr_id =   22 THEN gf.ma_vorname ELSE NULL END)
   END gf_vorname_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_anrede ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_anrede ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_anrede ELSE NULL END)
   END  vkl_anrede_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_name ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_name ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_name ELSE NULL END)
   END vkl_name_bg, CASE
   WHEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_vorname ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN vkl.spr_id = 18 THEN vkl.ma_vorname ELSE NULL END)
   ELSE
   MAX(CASE WHEN vkl.spr_id =   22 THEN vkl.ma_vorname ELSE NULL END)
   END vkl_vorname_bg, w.wup_id                                       AS wup_id_bez_bg, w.wup_standort AS wup_standort_bg

   FROM dbp_view.v_wup_2  w
   INNER JOIN dbp_msi_v_view.v_wup_denorm_2 wd
   ON  wd.wup_id = w.wup_id
   AND wd.mandant_id = w.mandant_id
   INNER JOIN dbp_view.v_vs_2 v
   ON  w.mandant_id = v.mandant_id
   AND w.vs_id = v.vs_id
   INNER JOIN dbp_view.v_ma_spr_zu_2 gf_2
   ON  wd.mandant_id = gf.mandant_id
   AND wd.gf_gbl_vertrieb_id = gf.ma_id
   INNER JOIN dbp_view.v_ma_spr_zu_2 vkl_2
   ON  wd.mandant_id = vkl.mandant_id
   AND wd.vkl_id = vkl.ma_id
   WHERE wd.glv_land_id <> -1
   GROUP BY      w.mandant_id
   ,TRIM(to_char (w.mandant_id, '00')) || '.' || TRIM(to_char (w.vs_id, '00')) || '.' || TRIM(to_char(wd.gf_gbl_vertrieb_id, '000000'))  || '.' || TRIM(to_char(wd.vkl_id, '000000'))   || '.' || TRIM ( to_char(w.wup_id ,'000000')) 
   ,1::BYTEINT
   ,v.vs_bez
   ,gf.ma_name
   ,vkl.ma_name  ,w.wup_standort ,w.wup_id;