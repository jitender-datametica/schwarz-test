--==============================================================
-- Table: gp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:10:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant ',
   dat_von                             DATE             COMMENT 'Startdatum der Zusammenarbeit',
   dat_bis                             DATE             COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT ',
   anlieferung_id                      VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kennzeichen der Anerkennung der L&S Anlieferungsbedingungen',
   gp_name                             VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Geschäftspartners',
   gp_strasse                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Strasse zur Adresse des Geschäftspartners',
   gp_plz                              VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Postleitzahl zur Adresse des Geschäftspartners',
   gp_ort                              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Ort, an dem der Geschäftspartner ansässig ist',
   land_id                             VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Land_1, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen, daher in der Länge 3 ',
   hgp_id                              INTEGER     COMMENT 'Nummer des Hauptlieferanten(Kreditors) zu einem Unterlieferanten, i.d.R. die ersten 6 Stellen der siebenstelligen Lieferantennummer',
   zek_id                              VARCHAR(3)       COMMENT 'Zentraleinkäufer - ID des Einkaufsmitarbeiters, der für einen Lieferanten zuständig ist.',
   lieferzeit                          INTEGER     COMMENT 'Standard Lieferzeit in Tagen für einen Lieferanten',
   zahlungsziel_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'mit einem Lieferanten vereinbartes Zahlungsziel wird über die Lookup-Tabelle l_zahlungsziel_1 referenziert',
   agb_id                              VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Juristische Art_1 der Zusammenarbeit:  L: L&S - AGB G: gesetzliche AGB blank: ohne Angabe',
   iso_id                              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Isonorm, ist der Lieferant nach ISO zertifiziert',
   eigenverpackung_id                  VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kennzeichen für Eigenverpackung (J/N)',
   eigenmarke_id                       VARCHAR(1)       COLLATE 'en-ci' COMMENT 'handelt es sich um einen Eigenmarken-Lieferanten',
   audit_id                            VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Möglichkeit eines Audit',
   audit_dat                           DATE             COMMENT 'Datum des letzten Audit. Format JJJJ-MM_1-TT',
   herst_fg                            INTEGER     COMMENT 'Kennzeichnet, ob es sich bei einem Lieferanten gleichzeitig auch um einen Hersteller handelt',
   zahlart_id                          VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel der Zahlarten, (z. B. m fuer Markant)',
   retour_sperr_fg                     INTEGER     COMMENT 'Dieses Flag kennzeichnet ob der Lieferant für Retouren gesperrt ist. FG = 1: Lieferant ist gesperrt.',
   system_id                           INTEGER     COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   gp_branche_id                       VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Eindeutiger Schuessel der Lieferantenbranchen (z. B. CO13 fuer Milch, Mopro). In KMO ist die Quelle bsch_id aus t016t, in DE ist die Quelle zzrp_invcat',
   wewa_fg                             INTEGER     COMMENT 'Dieses Flag gibt an, ob es sich bei diesem Lieferanten um einen für die wewa_1-Schnittstelle relevanten Geschäftspartner handelt',
   loesch_fg                           INTEGER     COMMENT 'Löschkennzeichen für den Lieferanten (1 ist gelöscht)',
   region_id                           INTEGER     NOT NULL COMMENT 'Region_1 eines Landes, z.Bsp. Hessen, Kärnten. Wird im DWH als künstlicher Schlüssel über die SAP-Region_1 gebildet ',
   min_pal_faktor_lkw                  NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Mindestpalettenfaktor pro LKW aus lfm1.minbw',
   gln_bbnr                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Basisnummer der GLN. Quelle ist lfa1.bbbnr',
   gln_bsnr                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Individueller Nummernteil der GLN. Quelle ist lfa1.bbsnr',
   gln_bubkz                           VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Prüfziffer der GLN. Quelle ist lfa1.bubkz',
   breitengrad                         NUMBER(38,16)    COMMENT 'Breitengrad aus dem GIS-System (Latitude)',
   laengengrad                         NUMBER(38,16)    COMMENT 'Längengrad aus dem GIS-System (Longitude)',
   gp_name_lat                         VARCHAR(80)      NOT NULL COLLATE 'en-ci' DEFAULT '0' COMMENT 'Lateinische Bezeichnung Lieferant',
   ivn                                 INTEGER     COMMENT 'Internationale Verhandler Nummer',
   isd_fg                              INTEGER     COMMENT 'Flag: Internationale Sortimentsdisposition',
   markant_id                          VARCHAR(2)       NOT NULL DEFAULT '  ' COMMENT 'ID Markantabrechnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Geschaeftspartner - MULTISET';
