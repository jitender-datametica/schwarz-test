CREATE OR REPLACE TABLE kfl_production_dbp_data.besch_lief_kuerzung_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Datum aus dem Quellfeld eindt'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='ID des Belegs bezogen auf den Bestellbeleg, das Quellfeld ist vbeln (also der Lieferbeleg)'),
best_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Position des Bestellbelegs (müsste also aus ebelp sein) aus posid '),
menge_best_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='bestellte Menge des Artikel_1 dieser Position in Bestellmengeneinheit. Aus menge'),
menge_lief_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlich gelieferte Menge in Bestellmengeneinheiten aus lfimg'),
ek_netto_bnk_soll NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
ek_netto_bnk_ist NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
vk_netto_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
vk_netto_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
menge_best_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Dieses Feld enthält die Bestellmenge in der Kollimengeneinheit.  In der Versorgung angereichert zur Performanceverbesserung'),
menge_lief_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der gekürzten Position in Kollimengeneinheit In der Versorgung angereichert zur Performanceverbesserung'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
quelle STRING(10) COLLATE 'und:ci' DEFAULT 'zdelmon' NOT NULL OPTIONS(description='quelltabelle sap retail'),
versandstelle_id STRING(4) DEFAULT '' NOT NULL
OPTIONS(description='ort, an dem lieferungen bearbeitet werden. es kann sich dabei um einen physischen ort (z.b. ein lager oder eine_1 gruppe_1 von laderampen) oder um eine_1 logische gruppierung (z.b. eine_1 gruppe_1 von personen, die für die versandaktivitäten zuständig ist) handeln.'),
art_id INTEGER
OPTIONS(description='input: artikel_1-id einschliesslich der generationen-id (9-stellig); output: 7-stellige l&s-id + counter = 8-stellige artikel_1-id. wwnnnnpc (warengruppe, nummer, prüfziffer, counter) regel: neuer artikel_1 -> counter +1.'),
PRIMARY KEY (mandant_id, dat_lief_soll, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)
OPTIONS(description='AIS KMO - Hier sind durch die Logistik gekürzte Lieferungen (nicht oder nur teilweise erfüllte Bestellungen) in KMO gespeichert. Quelle ist zldelmon_short');