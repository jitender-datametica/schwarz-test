CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_L_LEITENDE_ABTEILUNG_2
(
	LEIT_ABTEILUNG_ID,
	AMX_SYSTEM_ID,
	LEIT_ABTEILUNG_BEZ
) AS
-- 20220518 twie: SPEC0153699 neue audimex Lookup Leitende Abteilung, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)

SELECT 
         v01.leit_abteilung_id
        ,v01.amx_system_id
        ,v01.leit_abteilung_bez

FROM dbp_view.v_kmr_l_leitende_abteilung_2 v01;