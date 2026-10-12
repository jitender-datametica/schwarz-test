--==============================================================
-- Table: artbew_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_wg_sum_1
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_WG_SUM_1 CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   umrechnungskurs_hist                NUMBER(29,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 ',
   dat                                 DATE             NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang',
   kjmo                                INTEGER     NOT NULL COMMENT 'Kalenderjahremonat, Format JJJJMM',
   umsatz_brutto                       NUMBER(29,4)     NOT NULL COMMENT 'Umsatz incl. Mehrwertsteuerbetrag
            ',
   umsatz_netto                        NUMBER(29,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag
            ',
   umsatz_wrg                          VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR',
   umsatz_brutto_konz                  NUMBER(29,4)     NOT NULL COMMENT 'Umsatz brutto in der Konzernwährung',
   umsatz_netto_konz                   NUMBER(29,4)     NOT NULL COMMENT 'Umsatz netto in der Konzernwährung',
   quelle                              INTEGER     DEFAULT 0,
   menge                               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_WG_SUM PRIMARY KEY (mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id) NOT ENFORCED
)  COMMENT = 'TP1 MIS - Aggregationstabelle artbew_1 auf Ebene Warengruppe/Markt/Datum - MULTISET';
