CREATE OR REPLACE TABLE kfl_production_dbp_data.ausgeber_spr_zu (
spr_id INTEGER NOT NULL OPTIONS(description='Nummer der Sprache'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Ausgebers, es gibt KDC, TIP und Filiale'),
ausgeber_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnung des Gutschein-Ausgebers (Seller), z.Bsp. TIP001'),
ausgeber_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Gutschein-Ausgebers, z.Bsp. Kulanz. Bei einer Filiale die Filialbezeichnung'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Bezeichnung der Gutscheinausgeber (Seller)');