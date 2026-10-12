-- 2009-06-23, awen
 -- 2008-11-17
 -- 20081217:
 -- NEU Logik anlalog mv_projekt_KBE (2.20 Objektplanung Gesamt)

-- CROSS JOIN von v_cpr_projekt_spr_zu_per_1 über projekt_id
 -- Umgebaut LIKEs zu Ist gleich und IN
 -- 20090108 awen:

-- Null geCastet
 -- Faktview KBE Objektplanung (denormalisert)
 -- cpr_projekt_gruppe_id NULL gesetzt

-- dat_einschraenkung mit dat_ende_einschraekung ersetzt
 -- Zählung von Terminen projeziert auf Zeit_1 (kjmo)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_projekt_kbe_zeit_1 AS SELECT PR.mandant_id,
 PR.techn_platz_id,
 PR.cpr_ext_id AS projekt_nr,
 PR_S.cpr_projekt_bez AS projekt_bez,
 PR.cpr_kategorie_id,
 PR.projekt_anlass_id,
 PR.projektart_id,
 CAST(NULL AS STRING) AS cpr_projekt_gruppe_id,
 PR.objekt_planer_name,
 PR.plan_verantw_kz,
 PR.projekt_id,
 CP.cpr_suchfeld_id,
 pr_bestand.kbe_objekt_zugang_kjmo AS kjmo,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_BAUANTRAG_GEPRUEFT' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg = 1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_bauantrag_geprueft_c,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg =
     1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_eingang_auftrag_fs_vp_c,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg
      = 1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_eingang_auftrag_vorpla_c,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_FUNKTIONSPLANUNG' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg = 1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_funktionsplanung_c,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_PLANPRUEFUNG_BESPRECHNUNG' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg
      = 1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_planpruefung_besprechn_c,
 COUNT(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_VORPLANUNG' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg = 1
   THEN CP.dat_termin
   ELSE NULL
   END) AS kbe_vorplanung_c,
  CASE
  WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
  THEN MAX(pr_bestand.kbe_objekt_bestand)
  ELSE NULL
  END AS kbe_objekt_bestand,
 SUM(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' AND TAG.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND CP.ok_fg
      = 1
   THEN 1
   ELSE 0
   END) AS kbe_objekt_zugang,
  CASE
  WHEN CP.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
  THEN SUM(CASE
    WHEN pr_bestand.kbe_objekt_zugang_kjmo = pr_bestand.kbe_objekt_abgang_kjmo OR CP.cpr_systemstatus1_id IN (3, 4) AND
        CP.dat_termin > DATE '1900-01-01' AND CP.ok_fg = 1
    THEN 1
    ELSE 0
    END)
  ELSE NULL
  END AS kbe_objekt_abgang,
 PR.cpr_systemstatus1_id AS projekt_status1,
 PR.cpr_systemstatus2_id AS projekt_status2,
 PR.cpr_systemstatus3_id AS projekt_status3
FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_1 AS PR_S ON PR.projekt_id = PR_S.projekt_id AND PR_S.dat_bis
   = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH ON PR.projekt_id = PH.projekt_id AND PH.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_1 AS CP ON PH.projekt_phase_id = CP.projekt_phase_id
 LEFT JOIN kfl_production_dbp_view.v_tag_1 AS TAG_1 ON CP.dat_termin = TAG.dat
 INNER JOIN (SELECT PR0.projekt_id,
   TAG0.kjmo AS kbe_objekt_zugang_kjmo,
   TAG1.kjmo AS kbe_objekt_abgang_kjmo,
    CASE
    WHEN TAG0.kjmo IS NOT NULL AND TAG1.kjmo > TAG0.kjmo
    THEN 1
    ELSE 0
    END AS kbe_objekt_bestand
  FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS PR0
   LEFT JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS PH0 ON PR0.projekt_id = PH0.projekt_id AND PH0.dat_bis =
     DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_1 AS CP0 ON PH0.projekt_phase_id = CP0.projekt_phase_id
    -- analog Objektplanung Gesamt

   LEFT JOIN kfl_production_dbp_msi_view_ios.mv_projekt_fg_1 AS PR_FG ON PR0.projekt_id = PR_FG.projekt_id
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS TAG0 ON TAG0.dat >= CASE
      WHEN CP0.cpr_suchfeld_id IN ('KBE_EINGANG_AUFTRAG_FS_VP', 'KBE_EINGANG_AUFTRAG_VORPLANUNG')
      THEN CP0.dat_termin
      ELSE NULL
      END AND TAG0.dat < CASE
      WHEN CP0.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' AND CP0.dat_termin IS NOT NULL
      THEN CP0.dat_ende_einschraenkung
      ELSE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 12 MONTH)), DATE_ADD(CURRENT_DATE
        ,INTERVAL 12 MONTH))
      END
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS TAG1 ON TAG1.dat = CASE
     WHEN CP0.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' AND CP0.dat_termin IS NOT NULL
     THEN CP0.dat_ende_einschraenkung
     ELSE IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 12 MONTH)), DATE_ADD(CURRENT_DATE
       ,INTERVAL 12 MONTH))
     END
  WHERE CP0.ok_fg = 1
   AND CP0.nicht_relevant_fg = 0
   AND (CP0.cpr_suchfeld_id IN ('KBE_EINGANG_AUFTRAG_FS_VP', 'KBE_EINGANG_AUFTRAG_VORPLANUNG') OR CP0.cpr_suchfeld_id =
      'CPR_PROJEKTUEBERGABE')
   AND PR0.cpr_systemstatus1_id = 2
   AND PR0.cpr_systemstatus2_id IN (0, 1, 2)
   AND PR_FG.projekt_uebergabe_fg <> 1
   AND PR0.dat_bis = DATE '9999-12-31'
  GROUP BY PR0.projekt_id,
   kbe_objekt_zugang_kjmo,
   kbe_objekt_abgang_kjmo) AS pr_bestand ON PR.projekt_id = pr_bestand.projekt_id
WHERE PR.dat_bis = DATE '9999-12-31'
 AND (CP.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' OR CP.cpr_suchfeld_id = 'KBE_BAUANTRAG_GEPRUEFT' OR CP.cpr_suchfeld_id
         = 'KBE_EINGANG_AUFTRAG_FS_VP' OR CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' OR CP.cpr_suchfeld_id =
      'KBE_FUNKTIONSPLANUNG' OR CP.cpr_suchfeld_id = 'KBE_PLANPRUEFUNG_BESPRECHNUNG' OR CP.cpr_suchfeld_id =
    'KBE_VORPLANUNG')
GROUP BY PR.mandant_id,
 PR.techn_platz_id,
 projekt_nr,
 PR.projekt_id,
 projekt_bez,
 PR.cpr_kategorie_id,
 PR.projekt_anlass_id,
 PR.projektart_id,
 cpr_projekt_gruppe_id,
 PR.objekt_planer_name,
 PR.plan_verantw_kz,
 CP.cpr_suchfeld_id,
 kjmo,
 projekt_status1,
 projekt_status2,
 projekt_status3;