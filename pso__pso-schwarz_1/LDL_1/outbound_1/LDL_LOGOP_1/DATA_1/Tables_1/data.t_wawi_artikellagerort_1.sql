CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_artikellagerort_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_1 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
artikelnr STRING(18) NOT NULL OPTIONS(description='Indication of the complete article number. ARTIKEL.Artikelnr'),
kartlagerortnr BIGNUMERIC(38,0)
OPTIONS(description='Storage location_1 for boxes / single packages. LAGERORT.Lagertortnr'),
lagerplatzkarton BIGNUMERIC(38,0)
OPTIONS(description='Storage bin number for boxes / single packages. LAGERORT.Lagertortnr, BEREICHE_SETZLISTE.Von_Lagerplatz/Bis_Lagerplatz'),
pallagerortnr BIGNUMERIC(38,0)
OPTIONS(description='Storage location_1 for Euro pallets. LAGERORT.Lagertortnr, BEREICHE_SETZLISTE.Lagertortnr'),
lagerplatzpalette BIGNUMERIC(38,0)
OPTIONS(description='Storage bin number for Euro pallets. LAGERORT.Lagertortnr, BEREICHE_SETZLISTE.Von_Lagerplatz/Bis_Lagerplatz'),
dueslagerortnr BIGNUMERIC(38,0)
OPTIONS(description='Storage location_1 for Düsseldorf pallets. LAGERORT.Lagertortnr, BEREICHE_SETZLISTE.Lagertortnr'),
lagerplatzduesseld BIGNUMERIC(38,0)
OPTIONS(description='Storage bin number for Düsseldorf pallets. LAGERORT.Lagertortnr, BEREICHE_SETZLISTE.Von_Lagerplatz/Bis_Lagerplatz'),
datum DATETIME OPTIONS(description='Last modification date'),
bediener STRING(8) OPTIONS(description='Last editor'),
invfig_karton STRING(1) OPTIONS(description='Inventory flag for boxes / single packages'),
invfig_palette STRING(1) OPTIONS(description='Inventory flag for Euro pallets'),
invfig_duesseld STRING(1) OPTIONS(description='Inventory flag for Düsseldorf pallets'),
scn BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, artikelnr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.ARTIKELLAGERORT_1');