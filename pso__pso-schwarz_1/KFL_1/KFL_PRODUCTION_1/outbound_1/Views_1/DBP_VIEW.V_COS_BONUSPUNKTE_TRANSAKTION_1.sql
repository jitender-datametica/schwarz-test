CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_bonuspunkte_transaktion_1 (crm_konto_id
OPTIONS(description='ID des Kontos, das nimmt am Loyalty Program teil.'), datzeit_bonuspunkte_transaktion
OPTIONS(description='Erstellungszeitstempel der Punkte.'), bonuspunkte_transaktion_richtung
OPTIONS(description='Zeigt die Richtung der Bonustransaktion an (1 = Earn, 2 = Burn).'), bonuspunkte_transaktion_nr
OPTIONS(description='Eindeutiger Wert einer Bonuspunktetransaktion. Nicht zu verwechseln mit bonuspunkte_transaktion_id'),
mandant_id OPTIONS(description='KFL Land_1, wo die Bonustransaktion stattfindet.'), dat_bonuspunkte_blockiert_bis
OPTIONS(description='Datum bis wann die Bonuspunkte blockiert sind.Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.'),
bonuspunkte_transaktion_id
OPTIONS(description='Unique key zur Identifizierung einer Bonustransaktion.Verknüpft die Tabellen Bonustransaktion und Transaktion.'),
bonuspunkte_kanal_id
OPTIONS(description='Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.'),
bonuspunkte_grund_cd
OPTIONS(description='Der Grund warum die Bonuspunkte erhalten wurde, z.B. checkout, cancellation, Registrierung von PDP etc. Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.'),
bonuspunkte_herkunft_id
OPTIONS(description='Die Herkunft der Bonuspunkte-wie die Punkte vergeben wurden. ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..'),
anz_bonuspunkte_transaktion OPTIONS(description='Anzahl der Bonuspunkte der Transaktion.'), datzeit_update
OPTIONS(description='Zeitstempel, wann der Satz zuletzt im Vorsystem aktualisiert wurde. Es wird verwendet, um die Korrektheit des Verladevorgangs zu überwachen, indem der DWH- und der Quellcode verglichen werden.'),
bonuspunkte_bewegung_cd OPTIONS(description='Gibt die Bewegungsart eines Bonuspunkts an, z.B. buyCoupon')) AS SELECT
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
FROM kfl_production_dbp_data.cos_bonuspunkte_transaktion_1;