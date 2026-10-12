--==============================================================
-- Table: crm_kartebew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kartebew_1
   generated from Powerdesigner on Mittwoch, 26. Februar 2025 13:53:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CRM_KARTEBEW_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   kundenkarte_id                      VARCHAR(255)     NOT NULL COMMENT 'Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT.',
   loyalty_berechtigt_fg               INTEGER     NOT NULL COMMENT 'Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_1 berechnet. (Logik für alte Daten folgt)',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   umsatz_netto_sa                     NUMBER(29,4)     COMMENT 'SA Umsatz vermindert um den Mehrwertsteuerbetrag.',
   umsatz_netto_af                     NUMBER(29,4)     COMMENT 'AF Umsatz vermindert um den Mehrwertsteuerbetrag.',
   umsatz_brutto_sa                    NUMBER(29,4)     COMMENT 'SA Umsatz.',
   umsatz_brutto_af                    NUMBER(29,4)     COMMENT 'AF Umsatz.',
   anz_bons                            INTEGER     COMMENT 'Bons, die eine_1 Kundenkarte generiert.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CRM_KARTEBEW PRIMARY KEY (mandant_id, wup_id, nb_id, kundenkarte_id, dat, loyalty_berechtigt_fg) NOT ENFORCED
)  COMMENT = 'EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag_1 - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).';
