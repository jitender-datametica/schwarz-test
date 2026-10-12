CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BUCHUNGSKREIS_SPR_ZU as
   -- MR 12.1.2011 erstellt
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   v01.mandant_id, v01.buchungskreis_id, MAX(CASE WHEN spr_id = 22 THEN buchungskreis_bez ELSE NULL END)  AS buchungskreis_bez, MAX(CASE WHEN spr_id = 22 THEN strasse ELSE NULL END)        AS strasse, MAX(CASE WHEN spr_id = 22 THEN plz ELSE NULL END)          AS plz, MAX(CASE WHEN spr_id = 22 THEN ort ELSE NULL END)          AS ort, MAX(CASE WHEN spr_id = 22 THEN buchungskreis_bez ELSE NULL END)  AS buchungskreis_bez_de, MAX(CASE WHEN spr_id = 22 THEN strasse ELSE NULL END)        AS strasse_de, MAX(CASE WHEN spr_id = 22 THEN plz ELSE NULL END)          AS plz_de, MAX(CASE WHEN spr_id = 22 THEN ort ELSE NULL END)          AS ort_de, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_cz, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_pl, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_sk, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_hr, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_ro, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN buchungskreis_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN buchungskreis_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN buchungskreis_bez ELSE NULL END)
   END  AS buchungskreis_bez_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN strasse ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN strasse ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN strasse ELSE NULL END)
   END  AS strasse_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN plz ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN plz ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN plz ELSE NULL END)
   END  AS plz_bg, CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ort ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ort ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ort ELSE NULL END)
   END  AS ort_bg
   FROM dbp_view.v_buchungskreis_spr_zu v01
   JOIN dbp_view.v_l_system v02
   ON v01.system_id=v02.system_id
   WHERE
   v02.system_gruppe ='SAP RET'      -- Nur SAP Retail Systeme werden berücksichtigt
   GROUP BY
   v01.mandant_id
   ,v01.buchungskreis_id;