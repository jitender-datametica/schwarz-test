create or replace TABLE KFL_PRODUCTION.DBP_DATA.EK_INFOSATZ_WUP_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	EK_INFOSATZ_ID NUMBER(18,0) NOT NULL COMMENT 'Nummer des Infosatzes. Zusammen mit mandant_id eindeutiger Schlüssel',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	PROZENT_AKZEPTANZ_UNTERLIEF NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Prozentwert der Akzeptanz einer Unterlieferung aus untto',
	LOESCH_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Flag gelöscht aus eine.loekz. Infosätze können sowohl auf Kopf- als auch auf Pos-Ebene gelöscht sein',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	MIND_BESTELLMENGE NUMBER(18,3) COMMENT 'Mindestbestellmenge',
	PLANLIEFERZEIT NUMBER(38,0) COMMENT 'Planlieferzeit in Tagen',
	RUNDUNGSPROFIL VARCHAR(10) COLLATE 'en-ci' COMMENT 'Rundungsprofil',
	NORMAL_BESTELLMENGE NUMBER(18,3) COMMENT 'Normalbestellmenge',
	UEBERLIEFERUNG_TOLERANZGRENZE NUMBER(18,3) COMMENT 'Toleranzgrenze für Überlieferung',
	UEBERLIEFERUNG_UNBEGRENZT_FG NUMBER(38,0) COMMENT 'Kennzeichen: unbegrenzte Überlieferung erlaubt',
	UNTERLIEFERUNG_TOLERANZGRENZE NUMBER(18,3) COMMENT 'Toleranzgrenze für Unterlieferung',
	NETTOPREIS NUMBER(18,3) WITH MASKING POLICY #unknown_policy COMMENT 'Nettopreis im Einkaufsinfo',
	BMPE VARCHAR(3) COLLATE 'en-ci' COMMENT 'Bestellpreismengeneinheit',
	BESTAET_STEUERSCHLUESSEL NUMBER(38,0) COMMENT 'Bestätigungssteuerschlüssel',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
	constraint PK_EK_INFOSATZ_WUP_ZU primary key (MANDANT_ID, EK_INFOSATZ_ID, WUP_ID, NB_ID)
)COMMENT='AIS_KMO - Zuordnung Einkaufsinfosaetze zu Betrieben aus der SAP-Quelle EINE_2'
;