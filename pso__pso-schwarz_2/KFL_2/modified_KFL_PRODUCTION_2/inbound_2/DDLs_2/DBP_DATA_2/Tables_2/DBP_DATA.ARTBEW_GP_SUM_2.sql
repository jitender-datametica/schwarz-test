--==============================================================
-- Table: artbew_gp_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_gp_sum_2
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTBEW_GP_SUM_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)
            ',
   vw_id                               INTEGER     NOT NULL COMMENT 'ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte
            1 = Ost
            2 = West
            3 = Nord',
   wrg_2                                 VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Währung, z.Bsp. EUR',
   umrechnungskurs_hist                NUMBER(29,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 ',
   umsatz_netto                        NUMBER(29,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   diff_umsatz_netto_konz              NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'von der Konzernwährung abweichender Umsatz netto',
   ek_mep                              NUMBER(29,4)     NOT NULL COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)',
   diff_ek_mep_konz                    NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTBEW_GP_SUM PRIMARY KEY (mandant_id, dat, gp_id, vw_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag_2 - MULTISET';
