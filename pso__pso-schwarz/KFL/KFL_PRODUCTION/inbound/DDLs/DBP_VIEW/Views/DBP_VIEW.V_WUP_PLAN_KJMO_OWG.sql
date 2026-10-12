create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUP_PLAN_KJMO_OWG(
	WUP_ID COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID COMMENT 'Mandant im DWH',
	KJMO COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
	HWG_ID COMMENT 'ID der Hauptwarengruppe',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	UMSATZ_NETTO_PLAN COMMENT 'geplanter Nettoumsatz / Umsatzplanwert',
	ABSCHRIFTEN_NETTO_OPERATIV_PLAN COMMENT 'Abschriftenplanwert für operative Abschriften. Total- + Preisabschriften',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum'
) as 
    SELECT 
        wup_id,
        nb_id,
        mandant_id,
        kjmo,
        hwg_id,
        wrg_id,
        umsatz_netto_plan,
        abschriften_netto_operativ_plan,
        betrag_vk_netto_inventur_diff_plan

FROM DBP_DATA.WUP_PLAN_KJMO_OWG ;
