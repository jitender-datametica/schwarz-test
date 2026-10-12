create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS_ARCHIV.ODS_BON_ZAHLUNG_1 cluster by (
     MANDANT_ID,
     BON_DAT,
     WUP_ID 
)(
	BON_ID VARCHAR(100) NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert',
	BON_ZEILE NUMBER(38,0) NOT NULL COMMENT 'Die Zeile des Bons',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
	ZAHLUNG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden',
	START_BON_ZEILE TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel bei Beginn der Bewegung',
	BETRAG_ZAHLUNG NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Der Zahlbetrag. Positiv, wenn gegeben, negativ, wenn Rückgeld',
	WRG_ID VARCHAR(12) NOT NULL COMMENT 'Währung ID, z.Bsp ''EUR''',
	KPOS_ZAHLUNG_TYP_ID VARCHAR(2040) COMMENT 'Zahlungstyp aus Kassensystem KPOS ist nicht numerisch. COMPRESS mit CAMSET',
	BON_ZEILE_CASHBACK_REFERENZ NUMBER(38,0) COMMENT 'Referenz zur Bon Zeile der Kartenzahlung Bon Zeile',
	KARTENNUMMER_MASKIERT VARCHAR(120) COMMENT 'Maskierte Kartennummer. Nur die Bankengruppe ist daraus zu entnehmen.',
	BARCODE_LEERGUT VARCHAR(100) COMMENT 'Barcode des Pfandzettels',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ODS_BON_ZAHLUNG primary key (BON_ID, BON_DAT, WUP_ID, MANDANT_ID, BON_ZEILE)
)COMMENT='ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)'
;
