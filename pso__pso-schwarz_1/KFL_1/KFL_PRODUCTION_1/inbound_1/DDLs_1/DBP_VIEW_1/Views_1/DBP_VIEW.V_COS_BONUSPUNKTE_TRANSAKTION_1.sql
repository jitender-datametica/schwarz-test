create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_COS_BONUSPUNKTE_TRANSAKTION_1(
	CRM_KONTO_ID COMMENT 'ID des Kontos, das nimmt am Loyalty Program teil.',
	DATZEIT_BONUSPUNKTE_TRANSAKTION COMMENT 'Erstellungszeitstempel der Punkte.',
	BONUSPUNKTE_TRANSAKTION_RICHTUNG COMMENT 'Zeigt die Richtung der Bonustransaktion an (1 = Earn, 2 = Burn).',
	BONUSPUNKTE_TRANSAKTION_NR COMMENT 'Eindeutiger Wert einer Bonuspunktetransaktion. Nicht zu verwechseln mit bonuspunkte_transaktion_id',
	MANDANT_ID COMMENT 'KFL Land_1, wo die Bonustransaktion stattfindet.',
	DAT_BONUSPUNKTE_BLOCKIERT_BIS COMMENT 'Datum bis wann die Bonuspunkte blockiert sind.Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.',
	BONUSPUNKTE_TRANSAKTION_ID COMMENT 'Unique key zur Identifizierung einer Bonustransaktion.Verknüpft die Tabellen Bonustransaktion und Transaktion.',
	BONUSPUNKTE_KANAL_ID COMMENT 'Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.',
	BONUSPUNKTE_GRUND_CD COMMENT 'Der Grund warum die Bonuspunkte erhalten wurde, z.B. checkout, cancellation, Registrierung von PDP etc. Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.',
	BONUSPUNKTE_HERKUNFT_ID COMMENT 'Die Herkunft der Bonuspunkte-wie die Punkte vergeben wurden. ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..',
	ANZ_BONUSPUNKTE_TRANSAKTION COMMENT 'Anzahl der Bonuspunkte der Transaktion.',
	DATZEIT_UPDATE COMMENT 'Zeitstempel, wann der Satz zuletzt im Vorsystem aktualisiert wurde. Es wird verwendet, um die Korrektheit des Verladevorgangs zu überwachen, indem der DWH- und der Quellcode verglichen werden.',
	BONUSPUNKTE_BEWEGUNG_CD COMMENT 'Gibt die Bewegungsart eines Bonuspunkts an, z.B. buyCoupon'
) as 
    SELECT 
        crm_konto_id,
        datzeit_bonuspunkte_transaktion,
        bonuspunkte_transaktion_richtung,
        bonuspunkte_transaktion_nr,
        mandant_id,
        dat_bonuspunkte_blockiert_bis,
        bonuspunkte_transaktion_id,
        bonuspunkte_kanal_id,
        bonuspunkte_grund_cd,
        bonuspunkte_herkunft_id,
        anz_bonuspunkte_transaktion,
        datzeit_update,
        bonuspunkte_bewegung_cd
FROM DBP_DATA.COS_BONUSPUNKTE_TRANSAKTION_1 ;
