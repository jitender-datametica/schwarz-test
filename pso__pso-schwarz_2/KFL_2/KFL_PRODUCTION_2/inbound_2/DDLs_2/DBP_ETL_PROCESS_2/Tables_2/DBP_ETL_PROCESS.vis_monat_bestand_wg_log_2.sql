CREATE OR REPLACE TABLE VIS_MONAT_BESTAND_WG_LOG_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	GJMO NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM
            ',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);
            Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)
            Regel: Neuer Artikel_2 -> Counter +1',
	LOG_TIME_STAMP TIMESTAMP_LTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS Ladehilfstabelle - dient zur Beladung der Tabelle vis_monat_bestand_wg_2'
;