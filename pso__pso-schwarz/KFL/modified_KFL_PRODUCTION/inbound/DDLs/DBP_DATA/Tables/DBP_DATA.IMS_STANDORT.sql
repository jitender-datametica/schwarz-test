--==============================================================
-- Table: ims_standort
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_standort
   generated from Powerdesigner on Montag, 22. August 2022 08:10:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_STANDORT (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   standort_id                         VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine Nummer bzw. bei Dummy-Standorten XXXX',
   wup_id                              INTEGER    COMMENT 'Hier ist die Marktnummer eingetragen, wenn bekannt',
   nb_id                               INTEGER    COMMENT 'Die Nebenbetriebskennziffer zum Markt',
   standort_name                       VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Name des Standorts',
   dat_eroeffnung                      DATE            COMMENT 'Eröffnungsdatum',
   eigentum_kz                         INTEGER    COMMENT 'Eigentum / Miete Kennzeichen. ! = Eigentum, 0 = Miete, sonst NULL',
   umzugsfiliale_fg                    INTEGER    COMMENT 'Umzugsfiliale Flag. Wenn 1, dann Umzugsfiliale, sonst 0',
   neu_standort_fg                     INTEGER    COMMENT 'Flag kennzeichnet einen neuen Standort. Neu = 1, sonst 0',
   ginfo_markt_typ                     VARCHAR(2)      COLLATE 'en-ci' COMMENT 'Markttyp nach Anzahl von Quadratmetern, z.Bsp. 4A ist > 4000 m2',
   umsatz_ea                           INTEGER    COMMENT 'Umsatz laut Expansionsauftrag pro Jahr in Mio (feste Größe pro Markt, unabhängig vom Jahr)',
   verkaufsflaeche                     NUMBER(29,2)    COMMENT 'Verkaufsfläche des Marktes',
   konzessionaersflaeche               NUMBER(29,2)    COMMENT 'extern vermietete Fläche (Konzessionäre)',
   betriebsflaeche                     NUMBER(29,2)    COMMENT 'Betriebsfläche des Marktes',
   sparte_id                           INTEGER    COMMENT 'ID der Sparte',
   datenquelle_kz                      INTEGER    NOT NULL COMMENT 'Zeigt an, ob die Daten aus der Excel-Planung kommen oder aus der Tabelle wup. Weitere Datenquellen sind möglich',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_STANDORT PRIMARY KEY (mandant_id, standort_id) NOT ENFORCED
)  COMMENT = 'IMS - Tabelle der Standorte. Hier sind auch Expansions-Standorte enthalten, die noch keine Referenz zu einer Filiale aufweisen';
