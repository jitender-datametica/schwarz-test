CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_CRM_L_KUNDE
-- AP0113436/SPEC0136375 Berechnung dynamisches Alter / ssch1303 04.02.2022 
(
 crm_kunde_id
,dat_registrierung
,dat_abmeldung
,kundentyp_id
,kundenherkunft_id
,gender_id
,geburtsjahr
,age
,kunde_statusgrund_id
,strasse
,wohnort
,plz
,kunde_mandant_id
,vorzugsfiliale_wup_id
,akt_vorzugsfiliale_wup_id
,vorzugsfiliale_mandant_id
,nb_id
,merge_fg
,registrierungsfiliale_wup_id
,akt_registrierungsfiliale_wup_id
,registrierungsfiliale_mandant_id
,registrierungsfiliale_nb_id
,mandant_kbez 
)
AS
SELECT
 v01.crm_kunde_id
,TO_DATE(v01.zeit_registrierung) AS dat_registrierung
,TO_DATE(v01.zeit_abmeldung) AS dat_abmeldung
,v01.kundentyp_cd AS kundentyp_id
,v01.kundenherkunft_cd AS kundenherkunft_id
,v01.gender_id
,v01.geburtsjahr
,DATE_PART(YEAR, CURRENT_TIMESTAMP) - v01.geburtsjahr AS age
,v01.kunde_statusgrund_id
,v01.strasse
,v01.wohnort
,v01.plz
,v01.kunde_mandant_id
,v01.vorzugsfiliale_wup_id
--AP0204035/SPEC0272918 Erweiterung Join mit mv_wup zur Ermittlung der akt_registrierungsfiliale_wup_id / sschuecke 17.10.2024
,v04.aktuell_wup_id AS akt_vorzugsfiliale_wup_id
,v01.vorzugsfiliale_mandant_id
,v01.nb_id
,v01.merge_fg
,v01.registrierungsfiliale_wup_id
--AP0204035/SPEC0272918 Erweiterung Join mit mv_wup zur Ermittlung der akt_vorzugsfiliale_wup_id / sschuecke 17.10.2024
,v03.aktuell_wup_id AS akt_registrierungsfiliale_wup_id
,v01.registrierungsfiliale_mandant_id
,v01.registrierungsfiliale_nb_id
,v02.mandant_kbez

FROM DBP_DATA.CRM_L_KUNDE v01

JOIN DBP_DATA.MANDANT v02
ON (v01.kunde_mandant_id=v02.mandant_id)

--AP0204035/SPEC0272918 Erweiterung Join mit mv_wup zur Ermittlung der akt_registrierungsfiliale_wup_id / sschuecke 17.10.2024
JOIN DBP_MSI_VIEW_EK_KUN.MV_WUP V03
ON (v01.registrierungsfiliale_mandant_id = v03.mandant_id
AND v01.registrierungsfiliale_wup_id = v03.wup_id
AND v01.registrierungsfiliale_nb_id = v03.nb_id)
--AP0204035/SPEC0272918 Erweiterung Join mit mv_wup zur Ermittlung der akt_vorzugsfiliale_wup_id / sschuecke 17.10.2024
JOIN DBP_MSI_VIEW_EK_KUN.MV_WUP V04
ON (v01.vorzugsfiliale_mandant_id = v04.mandant_id
AND v01.vorzugsfiliale_wup_id = v04.wup_id
AND v01.nb_id = v04.nb_id)
;