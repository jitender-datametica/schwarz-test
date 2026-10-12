CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_projekt_fg AS SELECT DISTINCT PR.mandant_id,
 PR.projekt_id,
 PR.cpr_ext_id AS projekt_nr,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS eingang_vorplan_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS eingang_fs_vp_fg,
  CASE
  WHEN MAX(CASE
      WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
      THEN CP.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 1 OR MAX(CASE
      WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
      THEN CP.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 1
  THEN 1
  WHEN MAX(CASE
      WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
      THEN CP.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 0 OR MAX(CASE
      WHEN CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
      THEN CP.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 0
  THEN 0
  ELSE - 1
  END AS eingang_auftrag_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS projekt_uebergabe_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS datum_teil_oeffentl_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PROJEKT_ABGESCHL'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS projekt_abgeschl_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'IST_AUFNAHME_TECHNIK'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS ist_aufnahme_technik_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS pflege_stammdaten_sap_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PRV_APLNAT'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS apl_nat_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PRV_INTAPL'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS int_apl_fg,
 MAX(CASE
   WHEN CP.cpr_suchfeld_id = 'CPR_PRV_BAPL'
   THEN CP.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS bapl_fg
FROM kfl_production_dbp_view.v_cpr_projekt_per AS PR
 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_per AS PH ON PR.projekt_id = PH.projekt_id AND PH.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt AS CP ON PH.projekt_phase_id = CP.projekt_phase_id AND CP.ok_fg
     = 1 AND (CP.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP' OR CP.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' OR CP.cpr_suchfeld_id
             = 'CPR_PROJEKT_ABGESCHL' OR CP.cpr_suchfeld_id = 'CPR_PRV_APLNAT' OR CP.cpr_suchfeld_id = 'CPR_PRV_BAPL' OR
         CP.cpr_suchfeld_id = 'CPR_PRV_INTAPL' OR CP.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT' OR CP.cpr_suchfeld_id
        = 'IST_AUFNAHME_TECHNIK' OR CP.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP' OR CP.cpr_suchfeld_id =
     'KBE_EINGANG_AUFTRAG_VORPLANUNG')
WHERE PR.dat_bis = DATE '9999-12-31'
GROUP BY PR.mandant_id,
 PR.techn_platz_id,
 PR.projekt_id,
 projekt_nr;