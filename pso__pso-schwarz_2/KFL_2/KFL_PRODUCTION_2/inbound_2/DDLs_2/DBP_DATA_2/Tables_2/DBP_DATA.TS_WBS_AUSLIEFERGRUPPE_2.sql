create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TS_WBS_AUSLIEFERGRUPPE_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2',
	AUSLIEFERGRUPPE_ID VARCHAR(10) NOT NULL COMMENT 'Ausliefergruppe',
	BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Berechnung: Paletten Abrundung Schwellwert in %',
	BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Berechnung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %',
	BERECHNUNG_KOLLI_RUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Berechnung: Kolli Ab- und Aufrundung in %',
	NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Nachversorgung: Paletten Abrundung Schwellwert in %',
	NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %',
	NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ NUMBER(38,3) COMMENT 'WBS Nachversorgung: Kolli Ab- und Aufrundung in %',
	MAX_KAPA_ENDBESTAND_PROZ NUMBER(38,3) COMMENT 'Max. Kapa für Endbestand in %',
	BESTAND_BETRACHTUNG_PROZ NUMBER(38,3) COMMENT 'Bestandbetrachtung in %',
	REST_VON_NORMALBESTAND_PROZ NUMBER(38,3) COMMENT 'Restbestand in % vom Normalbestand',
	ERWEITERUNG_BEDARFSHORIZONT_TAGE NUMBER(38,0) COMMENT 'Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.\n            Bedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)\n            Bei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss',
	MENGE_ZIELENDBESTAND_SCHWELLWERT_AME NUMBER(38,0) COMMENT 'Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	AUSLIEFERGRUPPE_CLUSTER_NAME VARCHAR(100) COMMENT 'Höherstufige logistische Gruppierung (Cluster), die kleinteilige Ausliefergruppen nach Sortimentsart und Temperaturzone zusammenfasst.\n            Mögliche Werte:\n            Food\n            Frische\n            Non Food\n            Ultra Frische\n            Tiko\n            Sonstiges',
	constraint PK_TS_WBS_AUSLIEFERGRUPPE primary key (MANDANT_ID, AUSLIEFERGRUPPE_ID)
)COMMENT='SCM-WBS - This table contains settings for WBS calculation core on AUGR level (Auslieferungsgruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and users can make changes to the settings, in which case the contents here are overwritten.'
;
