DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_ZAHLUNG_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_ZAHLUNG_2 (
BON_ID STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
BON_ZEILE INTEGER NOT NULL OPTIONS(description='Die Zeile des Bons.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
ZAHLUNG_TYP_ID INTEGER NOT NULL
OPTIONS(description='ID des Zahlungstyps, z.Bsp. 121 = Maestro. Es gibt ca. 40 Zahlungstypen, keine Lookup dazu vorhanden.'),
START_BON_ZEILE DATETIME NOT NULL OPTIONS(description='Zeitstempel bei Beginn der Bewegung.'),
BETRAG_ZAHLUNG NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Der Zahlbetrag. Positiv, wenn gegeben, negativ, wenn Rückgeld.'),
WRG_ID STRING(12) NOT NULL OPTIONS(description='Währung ID, z.Bsp\'EUR\'.'),
KPOS_ZAHLUNG_TYP_ID STRING(2040)
OPTIONS(description='Zahlungstyp aus Kassensystem KPOS ist nicht numerisch. COMPRESS mit CAMSET.'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
BON_ZEILE_CASHBACK_REFERENZ INTEGER OPTIONS(description='Referenz zur Bon Zeile der Kartenzahlung Bon Zeile.'),
KARTENNUMMER_MASKIERT STRING(120)
OPTIONS(description='Maskierte Kartennummer. Nur die Bankengruppe ist daraus zu entnehmen.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
BARCODE_LEERGUT STRING(100) OPTIONS(description='Barcode des Pfandzettels'),
GUTSCHEIN_ID INTEGER OPTIONS(description='Eindeutige ID eines Wertgutscheins.'),
PRIMARY KEY (BON_ID, BON_DAT, WUP_ID, MANDANT_ID, BON_ZEILE) NOT ENFORCED
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID
OPTIONS(description='ODS - Aus den Kassensystemen near Realtime geladene Zahlungsinformationen (Bon-Zeilen)');