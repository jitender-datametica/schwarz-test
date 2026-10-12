create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_INVENTUR_PLAN(
	MANDANT_ID COMMENT 'Mandant im DWH',
	WUP_ID COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	GJ COMMENT 'Geschäftsjahr, Format JJJJ',
	INVENTURART_ID COMMENT 'SRS: Inventurart (international nicht identisch)',
	OWG_ID COMMENT 'ID der Oberwarengruppe',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO COMMENT 'Geplanter Umsatz je OWG und Markt',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN COMMENT 'Geplante Inventurdifferenz je OWG, Inventurart und Markt'
) COMMENT='Planwerte für Umsatz und Inventurverluste je OWG und Inventurart pro Geschäftsjahr und Markt.'
 as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        gj,
        inventurart_id,
        owg_id,
        wrg_id,
        betrag_vk_netto,
        betrag_vk_netto_inventur_diff_plan

FROM DBP_DATA.INVENTUR_PLAN ;
