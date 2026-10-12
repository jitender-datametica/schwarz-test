DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_ODS.ODS_BON_LEERGUT_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ODS.ODS_BON_LEERGUT_1 (
BON_ID STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
BON_ZEILE INTEGER NOT NULL OPTIONS(description='Die Zeile des Bons'),
EAN_KASSE INTEGER OPTIONS(description='Hier ist der Barcode des Leergutbons hinterlegt'),
UMSATZ_BRUTTO NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land_1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
START_BON_ZEILE DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
BON_NR_EXTERN INTEGER OPTIONS(description='Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
KPOS_ERFASSUNG_ID STRING(40) OPTIONS(description='Erfassungsart: Manuell, Scan, etc.'),
MENGE INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Menge / Anzahl an Leergut'),
KL_ART_ID INTEGER OPTIONS(description='Kaufland Artikelnummer'),
EINH_ID STRING(12) OPTIONS(description='Einheit: Stueck, Kiste, etc.'),
MWST_ID INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
BARCODE_LEERGUT STRING(100) OPTIONS(description='Barcode des Pfandzettels'),
PRIMARY KEY (BON_ID, BON_DAT, MANDANT_ID, WUP_ID, BON_ZEILE) NOT ENFORCED
) CLUSTER BY MANDANT_ID, BON_DAT, WUP_ID
OPTIONS(description='ODS -Leergutbons aus den Bonzeilen. Redundant gespeichert zur Steigerung der Performance. Alternativ wäre_1 CROSS JOIN Index denkbar');