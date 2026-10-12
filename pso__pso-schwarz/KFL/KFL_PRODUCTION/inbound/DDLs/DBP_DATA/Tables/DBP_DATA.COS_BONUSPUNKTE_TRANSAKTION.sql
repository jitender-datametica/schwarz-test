create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.COS_BONUSPUNKTE_TRANSAKTION (
	CRM_KONTO_ID VARCHAR(144) NOT NULL COMMENT 'ID des Kontos, das nimmt am Loyalty Program teil.',
	DATZEIT_BONUSPUNKTE_TRANSAKTION TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Erstellungszeitstempel der Punkte.',
	BONUSPUNKTE_TRANSAKTION_RICHTUNG NUMBER(38,0) NOT NULL COMMENT 'Zeigt die Richtung der Bonustransaktion an (1 = Earn, 2 = Burn).',
	BONUSPUNKTE_TRANSAKTION_NR VARCHAR(200) NOT NULL COMMENT 'Eindeutiger Wert einer Bonuspunktetransaktion. Nicht zu verwechseln mit bonuspunkte_transaktion_id',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'KFL Land, wo die Bonustransaktion stattfindet.',
	DAT_BONUSPUNKTE_BLOCKIERT_BIS DATE COMMENT 'Datum bis wann die Bonuspunkte blockiert sind.Bonuspunkte werden nicht direkt auf Konto gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.',
	BONUSPUNKTE_TRANSAKTION_ID VARCHAR(144) COMMENT 'Unique key zur Identifizierung einer Bonustransaktion.Verknüpft die Tabellen Bonustransaktion und Transaktion.',
	BONUSPUNKTE_KANAL_ID NUMBER(38,0) COMMENT 'Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.',
	BONUSPUNKTE_GRUND_CD VARCHAR(100) COMMENT 'Der Grund warum die Bonuspunkte erhalten wurde, z.B. checkout, cancellation, Registrierung von PDP etc. Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.',
	BONUSPUNKTE_HERKUNFT_ID NUMBER(38,0) COMMENT 'Die Herkunft der Bonuspunkte-wie die Punkte vergeben wurden. ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..',
	ANZ_BONUSPUNKTE_TRANSAKTION NUMBER(38,0) COMMENT 'Anzahl der Bonuspunkte der Transaktion.',
	DATZEIT_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Zeitstempel, wann der Satz zuletzt im Vorsystem aktualisiert wurde. Es wird verwendet, um die Korrektheit des Verladevorgangs zu überwachen, indem der DWH- und der Quellcode verglichen werden.',
	BONUSPUNKTE_BEWEGUNG_CD VARCHAR(200) COMMENT 'Gibt die Bewegungsart eines Bonuspunkts an, z.B. buyCoupon',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_COS_BONUSPUNKTE_TRANSAKTION primary key (CRM_KONTO_ID, DATZEIT_BONUSPUNKTE_TRANSAKTION, BONUSPUNKTE_TRANSAKTION_RICHTUNG, BONUSPUNKTE_TRANSAKTION_NR)
)COMMENT='Bonuspunkte, die vom Kunden pro Transaktion erzielt oder ausgegeben wurden.'
;
