CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_ORGANISATIONSEINHEIT_1
(
	ORGA_EINHEIT_ID,
	AMX_SYSTEM_ID,
	ORGA_EINHEIT_BEZ,
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	ORGA_EINHEIT_IMP_REFERENZ
) AS

-- 20221201 twie: SPEC0173748 neue audimex Lookup Organisationseinheit, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)
-- 14.08.2024 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--				somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

SELECT 
         v01.orga_einheit_id
        ,v01.amx_system_id
        ,v01.orga_einheit_bez
        ,v02.aktuell_wup_id AS wup_id
        ,v01.mandant_id
        ,v01.nb_id
        ,v01.orga_einheit_imp_referenz 

FROM dbp_view.v_kmr_l_organisationseinheit_1 v01

INNER JOIN  dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;