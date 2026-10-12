/* --------------------------------------------------------------------------------
   DDL for table: t_item_wh_vat_empiric_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_WH_VAT_EMPIRIC_HIST_2 CLUSTER BY (
     CLIENT_ID,
     DWH_VALID_TO 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 der DWH - i.a. assoziiert mit dem organisatorischen Zuschnitt der LIDL-Lander',
   loc_sid_wh                          NUMBER(38,0)     NOT NULL COMMENT 'FK zur Tabelle t_location_2; Warehousereferenz',
   vat_exception                       VARCHAR(300)     NOT NULL COLLATE 'en-ci' COMMENT 'MWST-Region_2 ("default" Standardregion, sonstige Auspragungen String: "Default-MWSt-Satze zu Sonder-MWSt-Satzen")',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'FK zur Tabelle t_item_2; Artikelreferenz',
   vat_pct_calc_type_id                NUMBER(38,0)     NOT NULL COMMENT 'MwSt-Berechnungsart; siehe t_ref_vat_pct_calc_type_2',
   vat_pct                             NUMBER(9,5)      COMMENT 'MWSt-Satz',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Loschflag - hier nicht verwendet wegen "broken timeline"',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'DWH-Hist-Intervall: Gultig_von',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'DWH-Hist-Intervall: Gultig_bis',
   dwh_last_confirm_dt                 DATE             NOT NULL COMMENT 'Datum der letzten Bestatigung der Attribute der Zeile',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Ladelauf-Identifier',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp der Erstellung der Zeile',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp der Modifikation der Zeile',   
   CONSTRAINT PK_T_ITEM_WH_VAT_EMPIRIC_HIST PRIMARY KEY (loc_sid_wh, item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 00000 $ historische Kollektion der aus Point-Of-Sales_2 (E-journal) stammenden MWSt-Satze fur ein Item_2 in einer Warehouse - MWST-Region_2 - Kombination
             ';

