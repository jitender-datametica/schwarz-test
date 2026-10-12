CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_mietobjekt_kondition_per (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
mo_intreno STRING(20) NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem die Kondition gilt'),
konditionsart_id STRING(4) NOT NULL OPTIONS(description='Konditionsart'),
mo_objekt_nr STRING(30) NOT NULL OPTIONS(description='Objektnummer für Berechnung'),
dat_bis DATE NOT NULL OPTIONS(description='Datum, bis zu dem die Kondition gilt'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Währung der Konditionsposition'),
miete_per_anno NUMERIC(18,2) DEFAULT 0 NOT NULL OPTIONS(description='Vereinbarte jährliche Miete'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mo_intreno, dat_von, konditionsart_id) NOT ENFORCED
) OPTIONS(description='IMMO - Mietobjekt Kondition - SAP REFX - ZBI_RE_DATA_RO_CONDITION_VIBDRO');