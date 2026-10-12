CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuspunkte_transaktion_1 (
crm_konto_id STRING(144) NOT NULL OPTIONS(description='ID des Kontos, das nimmt am Loyalty Program teil.'),
datzeit_bonuspunkte_transaktion DATETIME NOT NULL OPTIONS(description='Erstellungszeitstempel der Punkte.'),
bonuspunkte_transaktion_richtung INTEGER NOT NULL
OPTIONS(description='Zeigt die Richtung der Bonustransaktion an (1 = Earn, 2 = Burn).'),
bonuspunkte_transaktion_nr STRING(200) NOT NULL
OPTIONS(description='Eindeutiger Wert einer Bonuspunktetransaktion. Nicht zu verwechseln mit bonuspunkte_transaktion_id'),
mandant_id INTEGER NOT NULL OPTIONS(description='KFL Land_1, wo die Bonustransaktion stattfindet.'),
dat_bonuspunkte_blockiert_bis DATE
OPTIONS(description='Datum bis wann die Bonuspunkte blockiert sind.Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.'),
bonuspunkte_transaktion_id STRING(144)
OPTIONS(description='Unique key zur Identifizierung einer Bonustransaktion.Verknüpft die Tabellen Bonustransaktion und Transaktion.'),
bonuspunkte_kanal_id INTEGER
OPTIONS(description='Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.'),
bonuspunkte_grund_cd STRING(100)
OPTIONS(description='Der Grund warum die Bonuspunkte erhalten wurde, z.B. checkout, cancellation, Registrierung von PDP etc. Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.'),
bonuspunkte_herkunft_id INTEGER
OPTIONS(description='Die Herkunft der Bonuspunkte-wie die Punkte vergeben wurden. ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..'),
anz_bonuspunkte_transaktion INTEGER OPTIONS(description='Anzahl der Bonuspunkte der Transaktion.'),
datzeit_update DATETIME
OPTIONS(description='Zeitstempel, wann der Satz zuletzt im Vorsystem aktualisiert wurde. Es wird verwendet, um die Korrektheit des Verladevorgangs zu überwachen, indem der DWH- und der Quellcode verglichen werden.'),
bonuspunkte_bewegung_cd STRING(200) OPTIONS(description='Gibt die Bewegungsart eines Bonuspunkts an, z.B. buyCoupon'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_konto_id, datzeit_bonuspunkte_transaktion, bonuspunkte_transaktion_richtung, bonuspunkte_transaktion_nr
 ) NOT ENFORCED
) OPTIONS(description='Bonuspunkte, die vom Kunden pro Transaktion erzielt oder ausgegeben wurden.');