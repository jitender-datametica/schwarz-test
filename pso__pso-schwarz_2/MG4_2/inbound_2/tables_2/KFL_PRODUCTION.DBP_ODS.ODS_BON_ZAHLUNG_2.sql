create or replace TABLE KFL_PRODUCTION.DBP_ODS.ODS_BON_ZAHLUNG_2 cluster by (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
	BON_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
	BON_ZEILE NUMBER(38,0) NOT NULL COMMENT 'Die Zeile des Bons.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	ZAHLUNG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden.',
	START_BON_ZEILE TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel bei Beginn der Bewegung.',
	BETRAG_ZAHLUNG NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Der Zahlbetrag. Positiv, wenn gegeben, negativ, wenn Rückgeld.',
	WRG_ID VARCHAR(12) NOT NULL COMMENT 'Währung ID, z.Bsp ''EUR''.',
	KPOS_ZAHLUNG_TYP_ID VARCHAR(2040) COMMENT 'Zahlungstyp aus Kassensystem KPOS ist nicht numerisch. COMPRESS mit CAMSET.',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
	BON_ZEILE_CASHBACK_REFERENZ NUMBER(38,0) COMMENT 'Referenz zur Bon Zeile der Kartenzahlung Bon Zeile.',
	KARTENNUMMER_MASKIERT VARCHAR(120) COMMENT 'Maskierte Kartennummer. Nur die Bankengruppe ist daraus zu entnehmen.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BARCODE_LEERGUT VARCHAR(100) COMMENT 'Barcode des Pfandzettels',
	GUTSCHEIN_ID NUMBER(38,0) COMMENT 'Eindeutige ID eines Wertgutscheins.',
	constraint PK_ODS_BON_ZAHLUNG primary key (BON_ID, BON_DAT, WUP_ID, MANDANT_ID, BON_ZEILE)
)COMMENT='ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)'
;