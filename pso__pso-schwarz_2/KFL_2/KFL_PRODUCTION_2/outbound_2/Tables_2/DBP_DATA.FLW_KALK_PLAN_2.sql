--==============================================================
-- Table: flw_kalk_plan_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_plan_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_plan_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
plan_kalk_id INTEGER NOT NULL OPTIONS(description='Eindeutige ID der Plankalkulation aus clpnr'),
schnittliste_id INTEGER NOT NULL OPTIONS(description='ID der Schnittliste aus ctlnr'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dat_kalk_ab DATE NOT NULL OPTIONS(description='Kalkulationsdatum ab aus kadat'),
dat_kalk_bis DATE NOT NULL OPTIONS(description='Kalkulationsdatum bis aus bidat'),
fortgesch_kalk_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In SAP werden fortgeschriebene Kalkulationen durch einen Eintrag in fsnam identifiziert. Im DWH wird nur ein Flag benötigt.'),
kalk_variante_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_2 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
plan_soll_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bedeutung der Kalkulation. P wie Plan ist Wochenvorplanung, S Soll= Tageplanung auf Basis Ist- Eingangsmengen. Versorgung über Hyperion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plan_kalk_id) NOT ENFORCED
) OPTIONS(description='FLW - Plankalkulation aus clpk und aus Hyperion');