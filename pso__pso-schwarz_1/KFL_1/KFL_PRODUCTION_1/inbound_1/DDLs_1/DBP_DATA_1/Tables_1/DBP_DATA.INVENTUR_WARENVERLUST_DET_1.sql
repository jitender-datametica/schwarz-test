create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.INVENTUR_WARENVERLUST_DET_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH.',
	INVENTUR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO NUMBER(38,4) COMMENT 'Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_PREISABSCHRIFT NUMBER(38,4) COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
	BETRAG_VK_NETTO_TOTALABSCHRIFT NUMBER(38,4) COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
	MENGE_INVENTUR_DIFF NUMBER(38,3) COMMENT 'saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	BETRAG_VK_NETTO_INVENTUR_DIFF NUMBER(38,4) COMMENT 'saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
	MENGE_INVENTUR_DIFF_DIEBSTAHL NUMBER(38,3) COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur_1-Differenz-Mengen',
	BETRAG_VK_NETTO_INVENTUR_DIFF_DIEBSTAHL NUMBER(38,4) COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN NUMBER(38,4) COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_1-Zeitraum',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_INVENTUR_WARENVERLUST_DET primary key (MANDANT_ID, INVENTUR_ID, ART_ID)
)COMMENT='Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust_1 definierten Kriterien durchgeführt wurden.'
;
