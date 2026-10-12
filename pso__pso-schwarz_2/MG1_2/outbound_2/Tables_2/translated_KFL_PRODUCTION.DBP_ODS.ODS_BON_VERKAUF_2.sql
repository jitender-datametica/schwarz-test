DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_VERKAUF_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_VERKAUF_2 (
BON_ID STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert'),
BON_ZEILE INTEGER NOT NULL OPTIONS(description='Bonzeile des Kassenbons'),
KL_ART_ID INTEGER OPTIONS(description='Kaufland Artikelnummer'),
EAN_KASSE INTEGER OPTIONS(description='Die EAN_2 des Artikels'),
WG_ID INTEGER OPTIONS(description='Die Warengruppe aus der Kasse'),
MENGE NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge der Position.'),
EINH_ID STRING(12) OPTIONS(description='Einheit. Nur gefuellt bei Gewichtsware, sonst NULL'),
UMSATZ_BRUTTO NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
MWST_ID INTEGER NOT NULL OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
ERFASSUNG_ID STRING(40) OPTIONS(description='Gibt an, ob gescannt oder haendisch eingegeben'),
AKTION_ID STRING(80) NOT NULL OPTIONS(description='ID der Verkaufsaktion. Wird nicht gegen die Stammdaten geprueft'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
TALON_ID INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ID des Waagentalons. Nur gefuellt, wenn sich die Position auf einen Talon bezieht.'),
START_BON_ZEILE DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
BON_NR_EXTERN INTEGER OPTIONS(description='Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten'),
KPOS_ERFASSUNG_ID STRING(2040) OPTIONS(description='Erfassungsart: Manuell, Scan, etc.'),
UMSATZ_BRUTTO_NORM NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description=' Normaler Verkaufswert (Verkaufswert=Menge*Normalpreis;  Rabatte nicht abgezogen!)'),
VK_BRUTTO_OBB NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsaechlicher Verkaufspreis des Artikels pro Einheit inkl. Preisreduzierung, ohne Bonus Buy'),
BON_VORGANG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geschaeftsvorfallunterscheidung (K-POS) (0 = Sonstiges, 1 = E_LOADING_ARTICLE, 2 = OTHER_MONEY_EXCHANGE, 3 = iTUNES, 4 = EXTERNAL_GIFTCARD, 5 = CONCESSIONAL, 6 = PAY_ON_SCAN)'),
BARCODE_STRING STRING(400) OPTIONS(description='Barcode des Kassenbons'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
BARCODE_LEERGUT STRING(100) OPTIONS(description='Barcode des Pfandbons'),
ZEILENSTORNO_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet einen Zeilenstorno, fg = 1 Zeilenstorno liegt vor, fg = 0 Kein Zeilenstorno.'),
PRIMARY KEY (BON_ID, BON_DAT, MANDANT_ID, WUP_ID, BON_ZEILE) NOT ENFORCED
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Zeilen');