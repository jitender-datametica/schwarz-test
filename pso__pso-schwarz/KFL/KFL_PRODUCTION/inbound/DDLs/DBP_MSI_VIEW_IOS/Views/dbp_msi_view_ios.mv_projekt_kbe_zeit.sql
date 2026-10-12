CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_projekt_kbe_zeit
AS

-- 2008-11-17
-- Faktview KBE Objektplanung (denormalisert)
-- Zählung von Terminen projeziert auf Zeit (kjmo)
-- NEU Logik anlalog mv_projekt_KBE (2.20 Objektplanung Gesamt)
-- 20081217:
-- Join von v_cpr_projekt_spr_zu_per über projekt_id
-- cpr_projekt_gruppe_id NULL gesetzt
-- 20090108 awen:
-- Null geCastet
-- dat_einschraenkung mit dat_ende_einschraekung ersetzt
-- 2009-06-23, awen
-- Umgebaut LIKEs zu Ist gleich und IN

SELECT
pr.mandant_id
, pr.techn_platz_id
, pr.cpr_ext_id  projekt_nr
, pr_s.cpr_projekt_bez  projekt_bez
, pr.cpr_kategorie_id
, pr.projekt_anlass_id
, pr.projektart_id
, CAST(NULL AS VARCHAR(40)) AS  cpr_projekt_gruppe_id
, pr.objekt_planer_name
, pr.plan_verantw_kz
, pr.projekt_id
, cp.cpr_suchfeld_id
, pr_bestand.kbe_objekt_zugang_kjmo AS kjmo

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_BAUANTRAG_GEPRUEFT'  AND tag.kjmo =  pr_bestand.kbe_objekt_zugang_kjmo AND cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_BAUANTRAG_GEPRUEFT_C

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP' AND tag.kjmo =  pr_bestand.kbe_objekt_zugang_kjmo AND cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_EINGANG_AUFTRAG_FS_VP_C

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' AND tag.kjmo =  pr_bestand.kbe_objekt_zugang_kjmo AND cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_EINGANG_AUFTRAG_VORPLA_C

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_FUNKTIONSPLANUNG' AND tag.kjmo = pr_bestand.kbe_objekt_zugang_kjmo  AND cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_FUNKTIONSPLANUNG_C

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_PLANPRUEFUNG_BESPRECHNUNG' AND tag.kjmo =  pr_bestand.kbe_objekt_zugang_kjmo AND cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_PLANPRUEFUNG_BESPRECHN_C

, COUNT(CASE WHEN cp.cpr_suchfeld_id = 'KBE_VORPLANUNG' AND tag.kjmo = pr_bestand.kbe_objekt_zugang_kjmo AND  cp.ok_fg = 1
THEN cp.dat_termin END)  KBE_VORPLANUNG_C

, CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' THEN  COALESCE(MAX(pr_bestand.kbe_objekt_bestand),0) END  kbe_objekt_bestand

, SUM(CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' AND tag.kjmo =  pr_bestand.kbe_objekt_zugang_kjmo AND cp.ok_fg = 1
THEN 1 ELSE 0 END)  kbe_objekt_zugang

, CASE WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
THEN SUM(CASE WHEN    (pr_bestand.kbe_objekt_zugang_kjmo = pr_bestand.kbe_objekt_abgang_kjmo)
OR (cp.cpr_systemstatus1_id IN (3, 4) AND cp.dat_termin > '1900-01-01' AND cp.ok_fg = 1)
THEN 1
ELSE 0 END)
END  kbe_objekt_abgang

, pr.cpr_systemstatus1_id  projekt_status1
, pr.cpr_systemstatus2_id  projekt_status2
, pr.cpr_systemstatus3_id  projekt_status3

FROM dbp_view.v_cpr_projekt_per  pr

LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per pr_s
ON   pr.projekt_id = pr_s.projekt_id
AND pr_s.dat_bis = '9999-12-31'

LEFT JOIN dbp_view.v_cpr_phase_per  ph
ON   pr.projekt_id = ph.projekt_id
AND ph.dat_bis = '9999-12-31'

LEFT JOIN dbp_msi_view_ios.mv_cpr_cl_punkt  cp
ON   ph.projekt_phase_id = cp.projekt_phase_id

LEFT JOIN dbp_view.v_tag  tag
ON   cp.dat_termin = tag.dat

JOIN
(
SELECT
pr.projekt_id
, tag.kjmo      kbe_objekt_zugang_kjmo
, tag1.kjmo     kbe_objekt_abgang_kjmo
, CASE
WHEN kbe_objekt_zugang_kjmo IS NOT NULL AND kbe_objekt_abgang_kjmo > kbe_objekt_zugang_kjmo
THEN 1
ELSE 0
END  kbe_objekt_bestand
FROM dbp_view.v_cpr_projekt_per  pr

LEFT JOIN dbp_view.v_cpr_phase_per  ph
ON   pr.projekt_id = ph.projekt_id
AND ph.dat_bis = '9999-12-31'

LEFT JOIN dbp_msi_view_ios.mv_cpr_cl_punkt  cp
ON   ph.projekt_phase_id = cp.projekt_phase_id

-- analog Objektplanung Gesamt
LEFT JOIN dbp_msi_view_ios.mv_projekt_fg pr_fg
ON   pr.projekt_id = pr_fg.projekt_id

JOIN dbp_view.v_tag tag
ON   tag.dat >= CASE WHEN cp.cpr_suchfeld_id IN ('KBE_EINGANG_AUFTRAG_FS_VP', 'KBE_EINGANG_AUFTRAG_VORPLANUNG') THEN cp.dat_termin END
AND  tag.dat <  CASE WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' AND (cp.dat_termin IS NOT NULL) THEN  cp.dat_ende_einschraenkung ELSE ADD_MONTHS(CURRENT_DATE(),12) END

JOIN dbp_view.v_tag tag1
ON   tag1.dat = CASE WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' AND (cp.dat_termin IS NOT NULL) THEN   cp.dat_ende_einschraenkung ELSE ADD_MONTHS(CURRENT_DATE(),12) END

WHERE cp.ok_fg = 1
AND   cp.nicht_relevant_fg = 0
AND  (cp.cpr_suchfeld_id IN ('KBE_EINGANG_AUFTRAG_FS_VP', 'KBE_EINGANG_AUFTRAG_VORPLANUNG') OR cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE')
AND   pr.cpr_systemstatus1_id = 2
AND   pr.cpr_systemstatus2_id IN (0, 1, 2)
AND  (NOT pr_fg.projekt_uebergabe_fg = 1)
AND pr.dat_bis = '9999-12-31'

GROUP BY
pr.projekt_id
, tag.kjmo
, tag1.kjmo

)  pr_bestand
ON pr.projekt_id = pr_bestand.projekt_id

WHERE pr.dat_bis = '9999-12-31'
AND (
cp.cpr_suchfeld_id = 'KBE_BAUANTRAG_GEPRUEFT'
OR cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
OR cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
OR cp.cpr_suchfeld_id = 'KBE_FUNKTIONSPLANUNG'
OR cp.cpr_suchfeld_id = 'KBE_PLANPRUEFUNG_BESPRECHNUNG'
OR cp.cpr_suchfeld_id = 'KBE_VORPLANUNG'
OR cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
)

GROUP BY
pr.mandant_id
, pr.techn_platz_id
, pr.cpr_ext_id
, pr.projekt_id
, pr_s.cpr_projekt_bez
, pr.cpr_kategorie_id
, pr.projekt_anlass_id
, pr.projektart_id
, cpr_projekt_gruppe_id
, pr.objekt_planer_name
, pr.plan_verantw_kz
, cp.cpr_suchfeld_id
, pr_bestand.kbe_objekt_zugang_kjmo
, pr.cpr_systemstatus1_id
, pr.cpr_systemstatus2_id
, pr.cpr_systemstatus3_id
;
