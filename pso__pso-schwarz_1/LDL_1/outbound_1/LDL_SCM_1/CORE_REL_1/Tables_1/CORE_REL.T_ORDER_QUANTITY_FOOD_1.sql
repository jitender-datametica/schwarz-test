CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_order_quantity_food_1 (
mandant_1 STRING(100) NOT NULL OPTIONS(description='Mandant_1 oder Mieterkennung'),
artikel_1 STRING(100) NOT NULL OPTIONS(description='Artikelnummer'),
kalenderwoche BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderwoche'),
land_1 STRING(100) OPTIONS(description='Ländercode'),
bezeichnung STRING(100) OPTIONS(description='Artikelbeschreibung'),
verpackungsinhalt BIGNUMERIC(38,0) OPTIONS(description='Größe der Verpackung (Menge)'),
summierung_land_krt BIGNUMERIC(38,0) OPTIONS(description='Summe für Land_1 Karton'),
summierung_land_stueck BIGNUMERIC(38,0) OPTIONS(description='Summe für Land_1 in Stück'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH.'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH.'),
pallet_factor BIGNUMERIC(38,0)
OPTIONS(description='A numeric value representing how many cases of a product fit onto a single pallet.'),
PRIMARY KEY (mandant_1, artikel_1, kalenderwoche) NOT ENFORCED
) OPTIONS(description='Loaded from LDL_SCM.Export_VK_Mengen_GHFood_.xlsx');