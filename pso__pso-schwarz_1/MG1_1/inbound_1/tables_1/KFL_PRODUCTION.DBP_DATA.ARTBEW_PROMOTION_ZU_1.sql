create or replace TABLE KFL_PRODUCTION.DBP_DATA.ARTBEW_PROMOTION_ZU_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT ',
	BONUSKAUF_ID VARCHAR(20) NOT NULL COMMENT 'In SAP vergebene ID, leider nur wahrscheinlich numerisch',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
	EAN_KASSE NUMBER(26,0) NOT NULL DEFAULT 0 COMMENT 'von den Kassensystemen gelieferte EAN_1',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	BETRAG_PROMO_NETTO NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Um die Mehrwertsteuer verminderter Promotionsbetrag',
	BETRAG_MWST NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuerbetrag des Promotionsbetrags',
	UMRECHNUNGSKURS NUMBER(38,5) NOT NULL COMMENT 'Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_1 angereichert',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MENGE_PROMO NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'abverkaufte Menge',
	UMSATZ_PROMO_NETTO NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Um die Mehrwertsteuer verminderter Promotionsumsatz',
	UMSATZ_MWST NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Mehrwertsteuerbetrag des Promotionsumsatzes',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	UMRECHNUNGSKURS_HIST NUMBER(38,5) NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 ',
	constraint PK_ARTBEW_PROMOTION_ZU primary key (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT, BONUSKAUF_ID, KONDITIONSART_ID, EAN_KASSE)
)COMMENT='AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew_1'
;