CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bsch_rech_det_gp_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup_1 Objekte'),
ek_n NUMERIC(18,4) NOT NULL OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema)'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, gp_id, vw_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat über Wareneingänge pro Lieferant, Tag_1 und Vertriebsweg - MULTISET');