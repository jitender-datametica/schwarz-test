--==============================================================
-- Table: gp_aufschaltung_rpw_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_aufschaltung_rpw_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_AUFSCHALTUNG_RPW_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   hgp_id                              INTEGER     COMMENT 'Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer',
   dat_aufschaltung                    DATE             NOT NULL COMMENT 'Datum , ab dem ein Lieferant in SAP RPW abgewickelt wird',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_AUFSCHALTUNG_RPW PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)  COMMENT = 'RPW - DATA - Aufschaltdatum der Lieferanten im Projekt RPW';
