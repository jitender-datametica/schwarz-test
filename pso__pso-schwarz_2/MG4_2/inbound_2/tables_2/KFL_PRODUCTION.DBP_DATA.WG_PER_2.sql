create or replace TABLE KFL_PRODUCTION.DBP_DATA.WG_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM_2-DD''',
	LEAD_MWST_ID NUMBER(38,0) NOT NULL COMMENT 'führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
	ABT_ID NUMBER(38,0) COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte ID''s, positive Werte: aus Stammdatensystem übernommen',
	DAT_BIS DATE COMMENT 'Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format ''YYYY-MM_2-DD''',
	OWG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID der Oberwarengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	PLATZIERUNGSWG_ID NUMBER(38,0) COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel',
	WERBETEAM_CD VARCHAR(100) COMMENT 'Code des Werbeteams',
	constraint PK_WG_PER primary key (MANDANT_ID, WG_ID, ARTHIERTYP_ID, DAT_VON)
)COMMENT='TP1 - TP2 - Warengruppe - Stufe in der Artikelhierarchie\n             (ARTHIERTYP_ID nicht für PK benötigt)'
;