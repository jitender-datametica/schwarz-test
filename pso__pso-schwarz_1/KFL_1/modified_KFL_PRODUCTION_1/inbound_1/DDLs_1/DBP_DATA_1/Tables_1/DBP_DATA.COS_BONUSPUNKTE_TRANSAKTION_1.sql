--==============================================================
-- Table: cos_bonuspunkte_transaktion_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_transaktion_1
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSPUNKTE_TRANSAKTION_1 (
   crm_konto_id                        VARCHAR(144)     NOT NULL COMMENT 'ID des Kontos, das nimmt am Loyalty Program teil.',
   datzeit_bonuspunkte_transaktion     TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Erstellungszeitstempel der Punkte.',
   bonuspunkte_transaktion_richtung    INTEGER     NOT NULL COMMENT 'Zeigt die Richtung der Bonustransaktion an (1 = Earn, 2 = Burn).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'KFL Land_1, wo die Bonustransaktion stattfindet.',
   dat_bonuspunkte_blockiert_bis       DATE             COMMENT 'Datum bis wann die Bonuspunkte blockiert sind.Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.',
   bonuspunkte_transaktion_id          VARCHAR(144)     COMMENT 'Unique key zur Identifizierung einer Bonustransaktion.Verknüpft die Tabellen Bonustransaktion und Transaktion.',
   bonuspunkte_kanal_id                INTEGER     COMMENT 'Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.',
   bonuspunkte_grund_cd                VARCHAR(100)     COMMENT 'Der Grund warum die Bonuspunkte erhalten wurde, z.B. checkout, cancellation, Registrierung von PDP etc. Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.',
   bonuspunkte_herkunft_id             INTEGER     COMMENT 'Die Herkunft der Bonuspunkte-wie die Punkte vergeben wurden. ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..',
   anz_bonuspunkte_transaktion         INTEGER     COMMENT 'Anzahl der Bonuspunkte der Transaktion.',
   datzeit_update                      TIMESTAMP_LTZ(9) COMMENT 'Zeitstempel, wann der Satz zuletzt im Vorsystem aktualisiert wurde. Es wird verwendet, um die Korrektheit des Verladevorgangs zu überwachen, indem der DWH- und der Quellcode verglichen werden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSPUNKTE_TRANSAKTION PRIMARY KEY (crm_konto_id, datzeit_bonuspunkte_transaktion, bonuspunkte_transaktion_richtung) NOT ENFORCED
)  COMMENT = 'Bonuspunkte, die vom Kunden pro Transaktion erzielt oder ausgegeben wurden.';
