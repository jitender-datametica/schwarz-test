--==============================================================
-- Table: flw_art_gp_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_gp_wup_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_GP_WUP_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   einkaufs_infosatz_id                NUMBER(10,0)     NOT NULL COMMENT 'Nummer des Einkaufsinfosatzes aus SAP Quelle EINA.INFNR',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_lief_id                         NUMBER(38,0)     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   einkaufsorganisation_id             NUMBER(38,0)     NOT NULL COMMENT 'ID der Einkaufsorganisation aus ekorg',
   einkaufs_infosatz_typ_id            NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Typ des Einkaufsinfosatzes aus SAP Quelle EINE.ESOKZ',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   loesch_fg                           NUMBER(38,0)     COMMENT 'Einkaufsinfo allgemeine Daten zum Löschen vorgemerkt aus SAP Quelle EINE.LOEKZ',
   dat_erfasst                         DATE             COMMENT 'Erfassdatum des Einkaufsinfosatzes aus SAP Quelle EINE.ERDAT',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_GP_WUP_ZU PRIMARY KEY (einkaufs_infosatz_id, flw_art_id, flw_lief_id, einkaufsorganisation_id, einkaufs_infosatz_typ_id, werk_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Einkaufsinfosatz - allgemeine und Einkaufsorganisationsdaten, zusammengeführt  aus SAP P21 Tabellen EINE und EINA';

