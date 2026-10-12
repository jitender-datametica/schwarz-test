DROP TABLE IF EXISTS kfl_production_dbp_ods.ods_bon_zahlung_1;
CREATE OR REPLACE TABLE kfl_production_dbp_ods.ods_bon_zahlung_1 (
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_zeile INTEGER NOT NULL OPTIONS(description='Die Zeile des Bons.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
zahlung_typ_id INTEGER NOT NULL
OPTIONS(description='ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden.'),
start_bon_zeile DATETIME NOT NULL OPTIONS(description='Zeitstempel bei Beginn der Bewegung.'),
betrag_zahlung NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Zahlbetrag. Positiv, wenn gegeben, negativ, wenn Rückgeld.'),
wrg_id STRING(12) NOT NULL OPTIONS(description='Währung ID, z.Bsp\'EUR\'.'),
kpos_zahlung_typ_id STRING(2040)
OPTIONS(description='Zahlungstyp aus Kassensystem KPOS ist nicht numerisch. COMPRESS mit CAMSET.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
bon_zeile_cashback_referenz INTEGER OPTIONS(description='Referenz zur Bon Zeile der Kartenzahlung Bon Zeile.'),
kartennummer_maskiert STRING(120)
OPTIONS(description='Maskierte Kartennummer. Nur die Bankengruppe ist daraus zu entnehmen.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
barcode_leergut STRING(100) OPTIONS(description='Barcode des Pfandzettels'),
gutschein_id INTEGER OPTIONS(description='Eindeutige ID eines Wertgutscheins.'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id, bon_zeile) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)');