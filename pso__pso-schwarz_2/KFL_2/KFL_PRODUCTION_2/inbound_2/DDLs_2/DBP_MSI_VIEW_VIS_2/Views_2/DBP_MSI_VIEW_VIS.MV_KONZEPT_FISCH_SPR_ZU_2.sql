CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KONZEPT_FISCH_SPR_ZU_2 as
    -- LOOKUP/SPRACHE : Bedienkonzept Fisch
    -- 20120321 MR : Initial
    -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
    -- 20200117 ssch0611 : Update Filter rpm_tab_id

   SELECT
     t01.rpm_feld_auspr_id  AS bed_fisch_id, Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END) AS bed_fisch_bez  -- default (deutsch)
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_cz, Coalesce(Max(CASE WHEN spr_id = 108 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_sk, Coalesce(Max(CASE WHEN spr_id =  65 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_hr, Coalesce(Max(CASE WHEN spr_id =  90 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_pl, Coalesce(Max(CASE WHEN spr_id =  95 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_ro, Coalesce(Max(CASE WHEN spr_id =  18 THEN t01.rpm_feld_auspr_bez ELSE NULL END), Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)) AS bed_fisch_bez_bg, Max(CASE WHEN spr_id = 22 THEN t01.rpm_feld_auspr_bez ELSE NULL END)                              AS bed_fisch_bez_de

   FROM dbp_view.v_rpm_feld_auspr_spr_zu_2  t01
   INNER JOIN dbp_view.v_l_rpm_feld_2      t02
   ON t01.rpm_feld_id = t02.rpm_feld_id

   WHERE rpm_feld_bez = 'ZPPM_FISCH' AND rpm_tab_id = 3

   GROUP BY t01.rpm_feld_auspr_id;