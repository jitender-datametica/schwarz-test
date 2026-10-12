-- Lookup/Steuerungs View
 -- Ermittlung von projektbezogenen Flags
 -- 2009-01-19, awen
 -- 2008-10-16

-- neues Flag für IST_AUFNAHME_TECHNIK
 -- dat_bis dazu
 -- nur gültige Termine (OK_FG = 1)

-- Ermittlung von Berichtsanzeige Flags
 -- Eingang_Auftrag + Projektuebergabe + Projekt_abgeschl
 -- 2009-06-23, awen

-- Umgebaut LIKEs zu Ist gleich
 -- APL national + INTEGER APL + BAPL

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_projekt_fg_1 (mandant_id, projekt_id, projekt_nr,
eingang_vorplan_fg, eingang_fs_vp_fg, eingang_auftrag_fg, projekt_uebergabe_fg, datum_teil_oeffentl_fg,
projekt_abgeschl_fg, ist_aufnahme_technik_fg, pflege_stammdaten_sap_fg, apl_nat_fg, int_apl_fg, bapl_fg) AS SELECT
DISTINCT pr.mandant_id,
 pr.projekt_id,
 pr.cpr_ext_id AS projekt_nr,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS eingang_vorplan_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS eingang_fs_vp_fg,
  CASE
  WHEN MAX(CASE
      WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
      THEN cp.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 1 OR MAX(CASE
      WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
      THEN cp.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 1
  THEN 1
  WHEN MAX(CASE
      WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
      THEN cp.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 0 OR MAX(CASE
      WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
      THEN cp.termin_fg
      ELSE CAST(- 1 AS BIGNUMERIC)
      END) = 0
  THEN 0
  ELSE - 1
  END AS eingang_auftrag_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS projekt_uebergabe_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS datum_teil_oeffentl_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKT_ABGESCHL'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS projekt_abgeschl_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'IST_AUFNAHME_TECHNIK'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS ist_aufnahme_technik_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS pflege_stammdaten_sap_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PRV_APLNAT'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS apl_nat_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PRV_INTAPL'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS int_apl_fg,
 MAX(CASE
   WHEN cp.cpr_suchfeld_id = 'CPR_PRV_BAPL'
   THEN cp.termin_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END) AS bapl_fg
FROM kfl_production_dbp_view.v_cpr_projekt_per_1 AS pr
 LEFT JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS ph ON pr.projekt_id = ph.projekt_id AND ph.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_cl_punkt_1 AS cp ON ph.projekt_phase_id = cp.projekt_phase_id AND cp.ok_fg
     = 1 AND (cp.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP' OR cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' OR cp.cpr_suchfeld_id
             = 'CPR_PROJEKT_ABGESCHL' OR cp.cpr_suchfeld_id = 'CPR_PRV_APLNAT' OR cp.cpr_suchfeld_id = 'CPR_PRV_BAPL' OR
         cp.cpr_suchfeld_id = 'CPR_PRV_INTAPL' OR cp.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT' OR cp.cpr_suchfeld_id
        = 'IST_AUFNAHME_TECHNIK' OR cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP' OR cp.cpr_suchfeld_id =
     'KBE_EINGANG_AUFTRAG_VORPLANUNG')
WHERE pr.dat_bis = DATE '9999-12-31'
GROUP BY pr.mandant_id,
 pr.techn_platz_id,
 pr.projekt_id,
 projekt_nr;