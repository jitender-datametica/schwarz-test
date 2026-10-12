create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.INVENTUR_WARENVERLUST_DET (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	INVENTUR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO NUMBER(38,4) COMMENT 'Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_PREISABSCHRIFT NUMBER(38,4) COMMENT 'Wert der Preisabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_TOTALABSCHRIFT NUMBER(38,4) COMMENT 'Wert der Totalabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
	MENGE_INVENTUR_DIFF NUMBER(38,3) COMMENT 'saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum',
	BETRAG_VK_NETTO_INVENTUR_DIFF NUMBER(38,4) COMMENT 'saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum',
	MENGE_INVENTUR_DIFF_DIEBSTAHL NUMBER(38,3) COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur-Differenz-Mengen',
	BETRAG_VK_NETTO_INVENTUR_DIFF_DIEBSTAHL NUMBER(38,4) COMMENT 'Betrag Diebstahl als Teilmenge der Inventur-Differenz-Werten',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN NUMBER(38,4) COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_INVENTUR_WARENVERLUST_DET primary key (MANDANT_ID, INVENTUR_ID, ART_ID)
)COMMENT='Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust definierten Kriterien durchgeführt wurden.'
;
