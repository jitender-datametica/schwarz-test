create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.STERNCHEN_LOGIK_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	VW_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Vertriebsweges',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SM_ID NUMBER(38,0) NOT NULL DEFAULT -9 COMMENT 'Sortimentsmodul ID. Es gibt 5 Sortimentsstufen, von 1 bis 5. -1: keine Sortimentsstufe zugeordnet',
	KSM_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' DEFAULT '-9' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.',
	DAT_VON DATE NOT NULL COMMENT 'Beginn des Gültigkeitszeitraums',
	DAT_BIS DATE NOT NULL COMMENT 'Ende des Gültigkeitszeitaums',
	LIST_DURCHG_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für die duchgängige Listung des Artikel_1, d.h. für die Listung eines Artikels in allen Märkten einer Sortimentsstufe',
	BEZUGSWEG1_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für die durchgängige Listung des Artikel_1 bei Bezugsweg = 1',
	BEZUGSWEG4_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für die durchgängige Listung des Artikel_1 bei Bezugsweg = 4',
	KDIS0_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für den durchgängigen Andruck des Artikels in der Dispoliste',
	KDIS1_FG NUMBER(38,0) NOT NULL COMMENT 'Flag für den durchgängigen Nicht-Andruck des Artikels in der Dispoliste',
	ANZAHL_MARKT_SOLL NUMBER(38,0) NOT NULL COMMENT 'Anzahl der Märkte einer Sortimentsstufe (Soll-Anzahl)',
	ANZAHL_MARKT_LISTUNG NUMBER(38,0) COMMENT 'Anzahl der Märkte, in denen der Artikel_1 gelistet ist',
	ANZAHL_MARKT_BEZUGSWEG1 NUMBER(38,0) COMMENT 'Anzahl der Märkte je Sortimentsstufe, die dem Bezugsweg 1 zugeordnet sind.',
	ANZAHL_MARKT_BEZUGSWEG4 NUMBER(38,0) COMMENT 'Anzahl der Märkte je Sortimentsstufe, die dem Bezugsweg 4 zugeordnet sind.',
	ANZAHL_MARKT_KDIS0 NUMBER(38,0) COMMENT 'Anzahl der Märkte je Sortimentsstufe bei denen (für den Artikel_1) ein Andruck in der Dispoliste erfolgt',
	ANZAHL_MARKT_KDIS1 NUMBER(38,0) COMMENT 'Anzahl der Märkte je Sortimentsstufe bei denen (für den Artikel_1) kein Andruck in der Dispoliste erfolgt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_STERNCHEN_LOGIK primary key (ART_ID, VW_ID, MANDANT_ID, SM_ID, KSM_ID)
)COMMENT='TP2_AIS - Abbildung der Regel und der Ergebnisse der Bestimmung der Sternchenlogik'
;
