create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_BEST_BELEGFLUSS_2 (
	BEST_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
	BEST_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
	FOLGE_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann \n            Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr',
	KJ NUMBER(38,0) NOT NULL COMMENT 'Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr',
	FOLGE_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei',
	KONTIERUNG_POS_ID NUMBER(38,0) NOT NULL,
	VORGART_BEST_ENTW_ID VARCHAR(1) NOT NULL COLLATE 'en-ci',
	DAT_BUCH DATE COMMENT 'Buchungsdatum des Beleges aus budat',
	BETRAG_WRBTR NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten',
	BEST_ENTW_TYP_ID VARCHAR(1) COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art_2 des Folgebeleges: \n            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein, Q = Rechnung',
	SOLL_HABEN_KZ VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg',
	WRG_ID_BELEG VARCHAR(3) COLLATE 'en-ci' COMMENT 'Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_BEST_BELEGFLUSS primary key (BEST_BELEG_ID, MANDANT_ID, BEST_BELEG_POS_ID, FOLGE_BELEG_ID, KJ, FOLGE_BELEG_POS_ID, KONTIERUNG_POS_ID, VORGART_BEST_ENTW_ID)
)COMMENT='BIS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Industrie Quelle EKBE hinterlegt. '
;