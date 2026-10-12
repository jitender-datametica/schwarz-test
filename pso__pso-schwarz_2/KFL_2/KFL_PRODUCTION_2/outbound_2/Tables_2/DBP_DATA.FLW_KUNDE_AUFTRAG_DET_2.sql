--==============================================================
-- Table: flw_kunde_auftrag_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kunde_auftrag_det_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kunde_auftrag_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
verkaufs_beleg_id INTEGER NOT NULL
OPTIONS(description='Eindeutige ID des Verkaufsbelegs aus vbeln. Referenziert auf flw_besch_faktura_det.vorlage_beleg_id'),
verkaufs_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition aus posnr'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der alternativen Mengeneinheit aus meinh'),
menge_auftrag_vme_kum NUMERIC(18,3) NOT NULL OPTIONS(description='Kumulierte Auftragsmenge in VME aus kwmeng'),
menge_bes_bme_kum NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Kumulierte bestätigte Menge in Basismengeneinheit aus klmeng'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
absagegrund_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru. Referenz zur Tabelle flw_l_absagegrund_2'),
nettogew NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Nettogewicht in KG aus ntgew'),
wert_ek_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Nettowert der Kundenauftragsposition in Belegwährung aus netwr'),
zwsum_2_betrag NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Konditionszwischensumme 2 aus dem Kalkulationsschema aus kzwi2'),
zwsum_4_betrag NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Konditionszwischensumme 4 aus dem Kalkulationsschema aus kzwi4 '),
sap_art_id_kunde STRING(20) COLLATE 'und:ci'
OPTIONS(description='Materialnummer des Kunden aus dem Quellfeld kdmat. Entspricht immer einer Kaufland-Artikelnummer. Da der Mandant_2 des Kunden unbekannt ist, kann keine Verbindung über Stammdaten hergestellt werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verkaufs_beleg_id, verkaufs_beleg_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Verkaufsbeleg Positionsdaten aus vbap');