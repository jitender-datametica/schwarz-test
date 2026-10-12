--==============================================================
-- Table: ais_mandant_wup
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ais_mandant_wup
   generated from Powerdesigner on Montag, 26. August 2024 18:10:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.AIS_MANDANT_WUP (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID) - hier der Empfänger der der Daten z.Bsp. GfK',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   stat_bundesamt_wup_id               INTEGER     COMMENT 'Einer Filiale (wup_id) zugeordneten ID des statistischen Bundesamtes (offiziele Berichtseinheit ID des statistischen Bundesamtes). Pflege der ID erfolg durch den KFL EK Fachbereich. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AIS_MANDANT_WUP PRIMARY KEY (mandant_id, gp_id, wup_id) NOT ENFORCED
)  COMMENT = 'AIS - Transaktionstabelle, dient der Filterung auf Filialebene für Datenlieferungen im AIS Umfeld - wird über FrontEnd befüllt ';
