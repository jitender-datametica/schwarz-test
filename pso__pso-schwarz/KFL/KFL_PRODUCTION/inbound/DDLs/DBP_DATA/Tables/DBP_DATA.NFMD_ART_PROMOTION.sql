--==============================================================
-- Table: nfmd_art_promotion
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: nfmd_art_promotion
   generated from Powerdesigner on Donnerstag, 28. September 2023 07:53:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.NFMD_ART_PROMOTION (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   kjwo_ww                             NUMBER(38,0)     COMMENT 'Calendar year-week when the promotion campaign started. Format JJJJWW',
   promo_start_dt                      DATE             COMMENT 'Date when the promotion campaign starts',
   promo_stores_cnt                    NUMBER(38,0)     COMMENT 'semi additive - Number (count) of stores where the promotion is active',
   selling_price_gross_local_val       NUMBER(38,5)     COMMENT 'semi additive - gross selling price of a single article in currency expressed in column WRG_ID',
   wg_id                               NUMBER(38,0)     COMMENT 'Warengruppenid',
   sales_total_cnt                     NUMBER(38,0)     COMMENT 'semi additive - total number of articles sold',
   stock_initial_cnt                   NUMBER(38,0)     COMMENT 'semi additive - stock count  at the beginning of campaign',
   sales_promo_week_cnt                NUMBER(38,0)     COMMENT 'semi additive - sales (in number of items) in the first campaign week',
   promo_week_sell_rate                NUMBER(38,5)     COMMENT 'non additive - percentage of the stock sold in the first week of the campaign  ( 0.0 to 1.0)',
   current_sell_rate                   NUMBER(38,5)     COMMENT 'non additive percentage of the stock that is currently sold  ( 0.0 to 1.0)',
   remaining_stock_cnt                 NUMBER(38,0)     COMMENT 'semi additive - stock count currently remaining',
   model_execution_tmsp                TIMESTAMP_NTZ(9) COMMENT 'date when the AI model was executed',
   ai_model_id                         VARCHAR(50)      COMMENT 'Unique identifier of the AI model',
   next_promo_start_dt                 DATE             COMMENT 'The date of next promotion for this article',
   display_art_id                      NUMBER(38,0)     COMMENT 'Artikelnummer des Display-Artikels (the display component ID if an article is display article )',
   sell_ratio_wk12                     NUMBER(38,5)     COMMENT 'non additive. sell ratio - all items sold in week 1 and 2 relative to the initial stock count',
   sell_ratio_wk123                    NUMBER(38,5)     COMMENT 'non additive. sell ratio - all items sold in week 1, 2 and 3 relative to the initial stock count',
   orig_promo_start_dt                 DATE             COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original dates also. So in this column we have the originial Start Date (of the non-standart promotion cycle)',
   orig_promo_end_dt                   DATE             COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original dates also. So in this column we have the originial End  Date (of the non-standart promotion cycle)',
   orig_promo_cycle_type_name          VARCHAR(50)      COMMENT '"Standart" Promotion cycle is 6,7 or 8 days long.
            In cases when have promotions that are 2,3,4 or 5 days long we say they have "Short" Promotion Cycle.
            If a "Short" promotion cycle completely fits into a 6,7,8-day time interval of a single standart promotion,  then we expand the interval of the short promotion and overwrite the Start and End date.
            This is done so we can associate this "Short" promotion cycle with a single "Standart" promotion cycle.
            Still we need to keep the original cycle type of the promotion (Short, Custom ...). This field keeps the original value of the promotion cycle type',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_NFMD_ART_PROMOTION PRIMARY KEY (mandant_id, art_id, aktion_id) NOT ENFORCED
)  COMMENT = 'All non-food articles per promotion campaign are listed here. Data is retained for certain number of  weeks controlled by a patameter in NFMD_PARAMETER table. After that older data is removed';
