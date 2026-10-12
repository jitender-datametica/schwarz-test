DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_bon_verkauf_1;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_verkauf_1 (
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert'),
bon_zeile INTEGER NOT NULL OPTIONS(description='Bonzeile des Kassenbons'),
kl_art_id INTEGER OPTIONS(description='Kaufland Artikelnummer'),
ean_kasse INTEGER OPTIONS(description='Die EAN_1 des Artikels'),
wg_id INTEGER OPTIONS(description='Die Warengruppe aus der Kasse'),
menge NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge der Position.'),
einh_id STRING(12) OPTIONS(description='Einheit. Nur gefuellt bei Gewichtsware, sonst NULL'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
mwst_id INTEGER NOT NULL OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
erfassung_id STRING(40) OPTIONS(description='Gibt an, ob gescannt oder haendisch eingegeben'),
aktion_id STRING(80) NOT NULL OPTIONS(description='ID der Verkaufsaktion. Wird nicht gegen die Stammdaten geprueft'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land_1'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprueft'),
talon_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='ID des Waagentalons. Nur gefuellt, wenn sich die Position auf einen Talon bezieht.'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
bon_nr_extern INTEGER OPTIONS(description='Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten'),
kpos_erfassung_id STRING(2040) OPTIONS(description='Erfassungsart: Manuell, Scan, etc.'),
umsatz_brutto_norm NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description=' Normaler Verkaufswert (Verkaufswert=Menge*Normalpreis;  Rabatte nicht abgezogen!)'),
vk_brutto_obb NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsaechlicher Verkaufspreis des Artikels pro Einheit inkl. Preisreduzierung, ohne Bonus Buy'),
bon_vorgang_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geschaeftsvorfallunterscheidung (K-POS) (0 = Sonstiges, 1 = E_LOADING_ARTICLE, 2 = OTHER_MONEY_EXCHANGE, 3 = iTUNES, 4 = EXTERNAL_GIFTCARD, 5 = CONCESSIONAL, 6 = PAY_ON_SCAN)'),
barcode_string STRING(400) OPTIONS(description='Barcode des Kassenbons'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
barcode_leergut STRING(100) OPTIONS(description='Barcode des Pfandbons'),
zeilenstorno_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet einen Zeilenstorno, fg = 1 Zeilenstorno liegt vor, fg = 0 Kein Zeilenstorno.'),
PRIMARY KEY (bon_id, bon_dat, mandant_id, wup_id, bon_zeile) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Bon-Zeilen');