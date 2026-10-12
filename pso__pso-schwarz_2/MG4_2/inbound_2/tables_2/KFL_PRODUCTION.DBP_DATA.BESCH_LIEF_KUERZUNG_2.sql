create or replace TABLE KFL_PRODUCTION.DBP_DATA.BESCH_LIEF_KUERZUNG_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2',
	DAT_LIEF_SOLL DATE NOT NULL COMMENT 'Datum aus dem Quellfeld eindt',
	BEST_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'ID des Belegs bezogen auf den Bestellbeleg, das Quellfeld ist vbeln (also der Lieferbeleg)',
	BEST_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Position des Bestellbelegs (müsste also aus ebelp sein) aus posid ',
	MENGE_BEST_BME NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'bestellte Menge des Artikel_2 dieser Position in Bestellmengeneinheit. Aus menge',
	MENGE_LIEF_BME NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Tatsächlich gelieferte Menge in Bestellmengeneinheiten aus lfimg',
	EK_NETTO_BNK_SOLL NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto_bnk bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.',
	EK_NETTO_BNK_IST NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto_bnk bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.',
	VK_NETTO_IST NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung',
	VK_NETTO_SOLL NUMBER(18,4) NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung',
	MENGE_BEST_KOLLI NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Dieses Feld enthält die Bestellmenge in der Kollimengeneinheit.  In der Versorgung angereichert zur Performanceverbesserung',
	MENGE_LIEF_KOLLI NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Anzahl der gekürzten Position in Kollimengeneinheit In der Versorgung angereichert zur Performanceverbesserung',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	QUELLE VARCHAR(10) NOT NULL COLLATE 'en-ci' DEFAULT 'zdelmon' COMMENT 'quelltabelle sap retail',
	VERSANDSTELLE_ID VARCHAR(4) NOT NULL DEFAULT '' COMMENT 'ort, an dem lieferungen bearbeitet werden. es kann sich dabei um einen physischen ort (z.b. ein lager oder eine_2 gruppe_2 von laderampen) oder um eine_2 logische gruppierung (z.b. eine_2 gruppe_2 von personen, die für die versandaktivitäten zuständig ist) handeln.',
	ART_ID NUMBER(38,0) COMMENT 'input: artikel_2-id einschliesslich der generationen-id (9-stellig); output: 7-stellige l&s-id + counter = 8-stellige artikel_2-id. wwnnnnpc (warengruppe, nummer, prüfziffer, counter) regel: neuer artikel_2 -> counter +1.',
	constraint PK_BESCH_LIEF_KUERZUNG primary key (MANDANT_ID, DAT_LIEF_SOLL, BEST_BELEG_ID, BEST_BELEG_POS_ID)
)COMMENT='AIS KMO - Hier sind durch die Logistik gekürzte Lieferungen (nicht oder nur teilweise erfüllte Bestellungen) in KMO gespeichert. Quelle ist zldelmon_short'
;