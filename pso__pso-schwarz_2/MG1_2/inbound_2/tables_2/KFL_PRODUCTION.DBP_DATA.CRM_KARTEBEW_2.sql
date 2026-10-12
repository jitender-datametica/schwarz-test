create or replace TABLE KFL_PRODUCTION.DBP_DATA.CRM_KARTEBEW_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
	KUNDENKARTE_ID VARCHAR(255) NOT NULL COMMENT 'Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT.',
	LOYALTY_BERECHTIGT_FG NUMBER(38,0) NOT NULL COMMENT 'Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_2 berechnet. (Logik für alte Daten folgt)',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	UMSATZ_NETTO_SA NUMBER(38,4) COMMENT 'SA Umsatz vermindert um den Mehrwertsteuerbetrag.',
	UMSATZ_NETTO_AF NUMBER(38,4) COMMENT 'AF Umsatz vermindert um den Mehrwertsteuerbetrag.',
	UMSATZ_BRUTTO_SA NUMBER(38,4) COMMENT 'SA Umsatz.',
	UMSATZ_BRUTTO_AF NUMBER(38,4) COMMENT 'AF Umsatz.',
	ANZ_BONS NUMBER(38,0) COMMENT 'Bons, die eine_2 Kundenkarte generiert.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CRM_KARTEBEW primary key (MANDANT_ID, WUP_ID, NB_ID, KUNDENKARTE_ID, DAT, LOYALTY_BERECHTIGT_FG)
)COMMENT='EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag_2 - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).'
;