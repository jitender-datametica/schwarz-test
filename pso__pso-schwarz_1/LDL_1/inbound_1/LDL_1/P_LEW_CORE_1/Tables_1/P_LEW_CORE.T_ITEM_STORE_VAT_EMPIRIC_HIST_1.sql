/* --------------------------------------------------------------------------------
   DDL for table: t_item_store_vat_empiric_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_STORE_VAT_EMPIRIC_HIST_1 CLUSTER BY (
     CLIENT_ID,
     DWH_VALID_TO 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 der DWH - i.a. assoziiert mit dem organisatorischen Zuschnitt der LIDL-Lander',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'FK zur Tabelle t_location_1; Storereferenz',
   vat_exception                       VARCHAR(300)     NOT NULL COLLATE 'en-ci' DEFAULT 'default' COMMENT 'MWST-Region_1 ("default" Standardregion, sonstige Auspragungen String: "Default-MWSt-Satze zu Sonder-MWSt-Satzen")',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'FK zur Tabelle t_item_1; Artikelreferenz',
   vat_pct_calc_type_id                NUMBER(38,0)     NOT NULL COMMENT 'MwSt-Berechnungsart; siehe t_ref_vat_pct_calc_type_1',
   vat_pct                             NUMBER(9,5)      COMMENT 'MWSt-Satz',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Loschflag - hier nicht verwendet wegen "broken timeline"',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'DWH-Hist-Intervall: Gultig_von',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'DWH-Hist-Intervall: Gultig_bis',
   dwh_last_confirm_dt                 DATE             NOT NULL COMMENT 'Datum der letzten Bestatigung der Attribute der Zeile',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Ladelauf-Identifier',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp der Erstellung der Zeile',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp der Modifikation der Zeile',   
   CONSTRAINT PK_T_ITEM_STORE_VAT_EMPIRIC_HIST PRIMARY KEY (loc_sid_store, item_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 00000 $ historische Kollektion der aus Point-Of-Sales_1 (E-journal) stammenden MWSt-Satze fur ein Item_1 in einem Store';

