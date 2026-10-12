CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_projekt_fg_2
AS
-- 2008-10-16
-- Lookup/Steuerungs View
-- nur gültige Termine (OK_FG = 1)
-- Ermittlung von projektbezogenen Flags
-- Eingang_Auftrag + Projektuebergabe + Projekt_abgeschl
-- Ermittlung von Berichtsanzeige Flags
-- APL national + Int APL + BAPL
-- neues Flag für IST_AUFNAHME_TECHNIK
-- 2009-01-19, awen
-- dat_bis dazu
-- 2009-06-23, awen
-- Umgebaut LIKEs zu Ist gleich

SELECT DISTINCT
pr.mandant_id
,pr.projekt_id
,pr.cpr_ext_id  projekt_nr

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG' THEN cp.termin_fg
ELSE -1 END)  AS eingang_vorplan_fg
,MAX(CASE WHEN cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP' THEN cp.termin_fg
ELSE -1 END)  AS eingang_fs_vp_fg
,CASE WHEN (eingang_vorplan_fg = 1 OR eingang_fs_vp_fg = 1) THEN 1
WHEN (eingang_vorplan_fg = 0 OR eingang_fs_vp_fg = 0) THEN 0
ELSE -1 END  AS eingang_auftrag_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE' THEN cp.termin_fg
ELSE -1 END)  AS projekt_uebergabe_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT' THEN cp.termin_fg
ELSE -1 END)  AS datum_teil_oeffentl_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PROJEKT_ABGESCHL' THEN cp.termin_fg
ELSE -1 END)  AS projekt_abgeschl_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'IST_AUFNAHME_TECHNIK' THEN cp.termin_fg
ELSE -1 END)  AS ist_aufnahme_technik_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP' THEN cp.termin_fg
ELSE -1 END)  AS pflege_stammdaten_sap_fg

,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PRV_APLNAT' THEN cp.termin_fg
ELSE -1 END)  AS apl_nat_fg
,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PRV_INTAPL' THEN cp.termin_fg
ELSE -1 END)  AS int_apl_fg
,MAX(CASE WHEN cp.cpr_suchfeld_id = 'CPR_PRV_BAPL' THEN cp.termin_fg
ELSE -1 END)  AS bapl_fg

FROM dbp_view.v_cpr_projekt_per_2  pr

LEFT JOIN dbp_view.v_cpr_phase_per_2  ph
ON   pr.projekt_id = ph.projekt_id
AND ph.dat_bis = '9999-12-31'

LEFT JOIN dbp_msi_view_ios.mv_cpr_cl_punkt_2  cp
ON   ph.projekt_phase_id = cp.projekt_phase_id
AND  cp.ok_fg = 1
AND
(  cp.cpr_suchfeld_id = 'CPR_PROJEKT_ABGESCHL'
OR cp.cpr_suchfeld_id = 'IST_AUFNAHME_TECHNIK'
OR cp.cpr_suchfeld_id = 'CPR_PROJEKTUEBERGABE'
OR cp.cpr_suchfeld_id = 'DATUM_TEILOEFFENTLICHKEIT'
OR cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_VORPLANUNG'
OR cp.cpr_suchfeld_id = 'CPR_PFLEGE_STAMMDATEN_SAP'
OR cp.cpr_suchfeld_id = 'KBE_EINGANG_AUFTRAG_FS_VP'
OR cp.cpr_suchfeld_id = 'CPR_PRV_APLNAT'
OR cp.cpr_suchfeld_id = 'CPR_PRV_INTAPL'
OR cp.cpr_suchfeld_id = 'CPR_PRV_BAPL'
)

WHERE
pr.dat_bis = '9999-12-31'

GROUP BY
pr.mandant_id
,pr.techn_platz_id
,pr.projekt_id
,pr.cpr_ext_id
;