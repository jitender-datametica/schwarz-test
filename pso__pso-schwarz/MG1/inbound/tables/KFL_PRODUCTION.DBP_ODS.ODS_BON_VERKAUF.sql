create or replace TABLE KFL_PRODUCTION.DBP_ODS.ODS_BON_VERKAUF cluster by (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
	BON_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert',
	BON_ZEILE NUMBER(38,0) NOT NULL COMMENT 'Bonzeile des Kassenbons',
	KL_ART_ID NUMBER(38,0) COMMENT 'Kaufland Artikelnummer',
	EAN_KASSE NUMBER(26,0) COMMENT 'Die EAN des Artikels',
	WG_ID NUMBER(38,0) COMMENT 'Die Warengruppe aus der Kasse',
	MENGE NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Menge der Position.',
	EINH_ID VARCHAR(12) COMMENT 'Einheit. Nur gefuellt bei Gewichtsware, sonst NULL',
	UMSATZ_BRUTTO NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Umsatz Brutto Betrag',
	MWST_ID NUMBER(38,0) NOT NULL COMMENT 'Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)',
	ERFASSUNG_ID VARCHAR(40) COMMENT 'Gibt an, ob gescannt oder haendisch eingegeben',
	AKTION_ID VARCHAR(80) NOT NULL COMMENT 'ID der Verkaufsaktion. Wird nicht gegen die Stammdaten geprueft',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprueft',
	TALON_ID NUMBER(36,0) NOT NULL DEFAULT 0 COMMENT 'ID des Waagentalons. Nur gefuellt, wenn sich die Position auf einen Talon bezieht.',
	START_BON_ZEILE TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
	BON_NR_EXTERN NUMBER(38,0) COMMENT 'Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten',
	KPOS_ERFASSUNG_ID VARCHAR(2040) COMMENT 'Erfassungsart: Manuell, Scan, etc.',
	UMSATZ_BRUTTO_NORM NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT ' Normaler Verkaufswert (Verkaufswert=Menge*Normalpreis;  Rabatte nicht abgezogen!)',
	VK_BRUTTO_OBB NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Tatsaechlicher Verkaufspreis des Artikels pro Einheit inkl. Preisreduzierung, ohne Bonus Buy',
	BON_VORGANG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Geschaeftsvorfallunterscheidung (K-POS) (0 = Sonstiges, 1 = E_LOADING_ARTICLE, 2 = OTHER_MONEY_EXCHANGE, 3 = iTUNES, 4 = EXTERNAL_GIFTCARD, 5 = CONCESSIONAL, 6 = PAY_ON_SCAN)',
	BARCODE_STRING VARCHAR(400) COMMENT 'Barcode des Kassenbons',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BARCODE_LEERGUT VARCHAR(100) COMMENT 'Barcode des Pfandbons',
	ZEILENSTORNO_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet einen Zeilenstorno, fg = 1 Zeilenstorno liegt vor, fg = 0 Kein Zeilenstorno.',
	constraint PK_ODS_BON_VERKAUF primary key (BON_ID, BON_DAT, MANDANT_ID, WUP_ID, BON_ZEILE)
)COMMENT='ODS - Aus den Kassensystemen near Realtime geladene Bon-Zeilen'
;