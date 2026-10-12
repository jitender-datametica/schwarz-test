CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_KUERZUNG (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant'),
DAT_LIEF_SOLL DATE NOT NULL OPTIONS(description='Datum aus dem Quellfeld eindt'),
BEST_BELEG_ID INTEGER NOT NULL
OPTIONS(description='ID des Belegs bezogen auf den Bestellbeleg, das Quellfeld ist vbeln (also der Lieferbeleg)'),
BEST_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Position des Bestellbelegs (müsste also aus ebelp sein) aus posid '),
MENGE_BEST_BME NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='bestellte Menge des Artikel dieser Position in Bestellmengeneinheit. Aus menge'),
MENGE_LIEF_BME NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlich gelieferte Menge in Bestellmengeneinheiten aus lfimg'),
EK_NETTO_BNK_SOLL NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
EK_NETTO_BNK_IST NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
VK_NETTO_IST NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
VK_NETTO_SOLL NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
MENGE_BEST_KOLLI NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Dieses Feld enthält die Bestellmenge in der Kollimengeneinheit.  In der Versorgung angereichert zur Performanceverbesserung'),
MENGE_LIEF_KOLLI NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der gekürzten Position in Kollimengeneinheit In der Versorgung angereichert zur Performanceverbesserung'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
QUELLE STRING(10) COLLATE 'und:ci' DEFAULT 'zdelmon' NOT NULL OPTIONS(description='quelltabelle sap retail'),
VERSANDSTELLE_ID STRING(4) DEFAULT '' NOT NULL
OPTIONS(description='ort, an dem lieferungen bearbeitet werden. es kann sich dabei um einen physischen ort (z.b. ein lager oder eine gruppe von laderampen) oder um eine logische gruppierung (z.b. eine gruppe von personen, die für die versandaktivitäten zuständig ist) handeln.'),
ART_ID INTEGER
OPTIONS(description='input: artikel-id einschliesslich der generationen-id (9-stellig); output: 7-stellige l&s-id + counter = 8-stellige artikel-id. wwnnnnpc (warengruppe, nummer, prüfziffer, counter) regel: neuer artikel -> counter +1.'),
PRIMARY KEY (MANDANT_ID, DAT_LIEF_SOLL, BEST_BELEG_ID, BEST_BELEG_POS_ID) NOT ENFORCED
)
OPTIONS(description='AIS KMO - Hier sind durch die Logistik gekürzte Lieferungen (nicht oder nur teilweise erfüllte Bestellungen) in KMO gespeichert. Quelle ist zldelmon_short');