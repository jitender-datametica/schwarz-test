--==============================================================
-- Table: flw_kunde_auftrag_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kunde_auftrag_det
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KUNDE_AUFTRAG_DET (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   verkaufs_beleg_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID des Verkaufsbelegs aus vbeln. Referenziert auf flw_besch_faktura_det.vorlage_beleg_id',
   verkaufs_beleg_pos_id               INTEGER     NOT NULL COMMENT 'Belegposition aus posnr',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der alternativen Mengeneinheit aus meinh',
   menge_auftrag_vme_kum               NUMBER(29,3)     NOT NULL COMMENT 'Kumulierte Auftragsmenge in VME aus kwmeng',
   menge_bes_bme_kum                   NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Kumulierte bestätigte Menge in Basismengeneinheit aus klmeng',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   werk_id                             INTEGER     COMMENT 'Numerischer Surrogate key für das Werk werks',
   absagegrund_id                      VARCHAR(2)       COLLATE 'en-ci' COMMENT 'ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru. Referenz zur Tabelle flw_l_absagegrund',
   nettogew                            NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Nettogewicht in KG aus ntgew',
   wert_ek_netto                       NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Nettowert der Kundenauftragsposition in Belegwährung aus netwr',
   zwsum_2_betrag                      NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Konditionszwischensumme 2 aus dem Kalkulationsschema aus kzwi2',
   zwsum_4_betrag                      NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Konditionszwischensumme 4 aus dem Kalkulationsschema aus kzwi4 ',
   sap_art_id_kunde                    VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Materialnummer des Kunden aus dem Quellfeld kdmat. Entspricht immer einer Kaufland-Artikelnummer. Da der Mandant des Kunden unbekannt ist, kann keine Verbindung über Stammdaten hergestellt werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KUNDE_AUFTRAG_DET PRIMARY KEY (mandant_id, verkaufs_beleg_id, verkaufs_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Verkaufsbeleg Positionsdaten aus vbap';

