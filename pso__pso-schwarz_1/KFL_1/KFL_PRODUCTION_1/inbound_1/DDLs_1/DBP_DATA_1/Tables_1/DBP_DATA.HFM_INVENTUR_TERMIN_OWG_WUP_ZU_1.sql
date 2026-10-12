create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.HFM_INVENTUR_TERMIN_OWG_WUP_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	DAT_PLAN_ZAEHLUNG DATE NOT NULL COMMENT 'Geplantes Datum der Inventurzählung (Datum der Inventurdurchführung)',
	INVENTURART_INT_ID NUMBER(38,0) NOT NULL COMMENT 'SRS: Inventurart international (Gruppierung für die Vereinheitlichung und Reportingebene; Bsp. 1=Flop)',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	DAT_VORLETZTE_ZAEHLUNG DATE NOT NULL COMMENT 'Datum der vorletzten Inventur_1 (wird ermittelt aus ISEG auf Markt/Artikel_1/Inventurart_INT-Ebene, ausgehend vom dat_letzt_zaehlung, welches war der vorherige Termin (dat_letzt_zaehlung))',
	UMSATZ_VK_NETTO_SUM NUMBER(38,4) NOT NULL COMMENT 'Summierter Wert des Umsatzes für den Zeitraum dat_vorletzte_zaehlung bis dat_plan_zaehlung (dat_letzt_zaehlung)',
	INVENTUR_WERT_VK_NETTO NUMBER(38,2) NOT NULL DEFAULT 0 COMMENT 'Wert der gebuchten Inventurdifferenzen (lagerbew_det.wert_vk_netto - mseg.vkwra) zum Stichtag dat_plan_zaehlung',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BETRAG_NETTO_DIEBSTAHL_ABSCHRIFT NUMBER(38,4) COMMENT 'Betrag entählt die durch Abschriften_1 aufgrund von Diebstahl veursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
	BETRAG_NETTO_PREIS_ABSCHRIFT NUMBER(38,4) COMMENT 'Betrag enthält die durch Preisabschriften verursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
	BETRAG_NETTO_TOTAL_ABSCHRIFT NUMBER(38,4) COMMENT 'Betrag enthält die durch Totalabschriften verursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
	BETRAG_KALK_INVENTUR_DIFF NUMBER(38,4) COMMENT 'Betrag enthält die kalkulatorische Inventurdifferenz. Inventuren können nicht immer am letzten Tag_1 des Zeitraums ermittelt werden. Die entstehende Inventurverluste zwischen dem Erfassungszeitpunkt und dem Ende des Inventurzeitraums werden vom Controlling in der kalkulatorischen Inventurdifferenz berechnet.',
	constraint PK_HFM_INVENTUR_TERMIN_OWG_WUP_ZU primary key (MANDANT_ID, WUP_ID, NB_ID, OWG_ID, ARTHIERTYP_ID, DAT_PLAN_ZAEHLUNG, INVENTURART_INT_ID, DAT_VORLETZTE_ZAEHLUNG)
)COMMENT='VIS: Excel-Upload (manuell erstellt durch FB) von Kennzahlen für das Reporting der Inventurergebnisse der Filialen.'
;
