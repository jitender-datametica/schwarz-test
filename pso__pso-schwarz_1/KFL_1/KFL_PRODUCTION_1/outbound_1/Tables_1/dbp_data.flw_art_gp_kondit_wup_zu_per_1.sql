CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_gp_kondit_wup_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kondition_applikation_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Applikation aus SAP Quelle A017.KAPPL'),
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Konditionsart aus kschl'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Einkaufsorganisation aus ekorg'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
einkaufs_infosatz_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Typ des Einkaufsinfosatzes aus SAP Quelle A017.ESOKZ'),
kondition_id INTEGER NOT NULL OPTIONS(description='Nummer der Kondition aus knumh'),
dat_bis DATE NOT NULL OPTIONS(description='Gültigkeitsende des Konditionssatzes aus SAP Quelle A017.DATBI'),
dat_von DATE OPTIONS(description='Gültigkeitsbeginn des Konditionssatzes aus SAP Quelle A017.DATAB'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='FLW - Materialinfosatz (werksspezifisch) aus SAP P21 Tabelle A017_1');