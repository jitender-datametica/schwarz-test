--==============================================================
-- Table: anreich_rohertrag_kalk_wup_art_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anreich_rohertrag_kalk_wup_art_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANREICH_ROHERTRAG_KALK_WUP_ART_ZU_PER_2 CLUSTER BY (DAT_ZEITSCHEIBE) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   berichtstyp_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Berichtstyp wird für die jahresübergreifende Betrachtung benötigt. Berichtstyp 1: Rohertrag akt. Jahr zum Stichtag; Berichtstyp 4: Rohertrag aus Vorjahr zum Stichtag (Rohertrag = Summe Berichtstyp 1+4)',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   dat_zeitscheibe                     DATE             NOT NULL COMMENT 'Datum der (Tages-) Zeitscheibe',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) NOT NULL COMMENT 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss) aus Excel - Zeitpunkt der Erstellung des Datensatz',
   datzeit_upload                      TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitpunkt des Uploads',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   basismenge_einh_id                  VARCHAR(3)       COLLATE 'en-ci' COMMENT 'ID der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert ',
   mep_we_differenz                    NUMBER(18,2)     DEFAULT 0 COMMENT 'MEP / WE-Differenz',
   spannenkorrektur                    NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Spannenkorrektur',
   finanzbonus                         NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Finanzbonus',
   jahresbonus                         NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Jahresbonus',
   steigergungsbonus_de                NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Steigergungsbonus (DE)',
   markantbonus_de                     NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Markantbonus (DE)',
   steigerungs_markantbonus_kmo        NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Steigerungs- / Markantbonus (KMO)',
   steigerungs_markantbonus            NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Steigerungs- / Markantbonus',
   verbesserungspot_aus_nachm          NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Verbesserungspot. aus Nachm.',
   verg_a_d_sp                         NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Verg. a. d. Sp. (DE: lfd. KJ, KMO: GJ)',
   abgrenzung_verguetungen             NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Abgrenzung Vergütungen',
   verguetungen_vorjahre               NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Vergütungen Vorjahre',
   apm                                 NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'APM',
   umsatz_export                       NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Umsatz Export',
   wareneinsatz_export                 NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Wareneinsatz Export',
   inventur_diebstahl_ta_geb_vt        NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Inventur_2 Diebstahl TA geb. VT',
   ueberleitung_vkn_zu_ek              NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Überleitung VKn zu EK',
   bewertungskorrekturen_bestand       NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Bewertungskorrekturen Bestand',
   mwst_auf_totalabschr_inv_diff       NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'MwSt. auf Totalabschr. / Inv.diff.',
   sondersteuer                        NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Sondersteuer',
   steuern                             NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Steuern',
   kursdifferenzen_ware                NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Kursdifferenzen Ware',
   wertberichtigung_lieferantenboni    NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Kursdifferenzen WareWertberichtigung Lieferantenboni',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANREICH_ROHERTRAG_KALK_WUP_ART_ZU_PER PRIMARY KEY (mandant_id, berichtstyp_id, wup_id, nb_id, art_id, gp_id, dat_zeitscheibe, datzeit_erstellung) NOT ENFORCED
)  COMMENT = 'REB - Definierte Einzelpositionen - manuelles Excel-Upload - zum Rohertrag (Tabelle rohertrag_kalk_wup_art_zu_per_2)';

