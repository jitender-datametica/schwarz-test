/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.T_SPACEMAN_STORE_ITEM_PERFORMANCE_1
#----------------------------------------------------------------------------
# History:
#  1.0  09.11.2020    Morris, Michael               20201109_2650_spaceman (REP4-7909) - Initial version.
#                                                   https://jira.schwarz/browse/REP4-7909
#  1.1  29.01.2021    Morris, Michael               Transferred to Snowflake
#  1.2  17.08.2021    Morris, Michael               Additional columns added for transparency.
#                                                   REP4-8463
#  1.3  17.08.2022    Haus, Oliver                  Additional column item_status_id
#  1.7  22.02.2024    Raman Paneru                  Added Abverkauf woche_1 and umsatz woche_1 columns and changed data type for ob as INTEGER from DECIMAL (9,2)
#----------------------------------------------------------------------------
*/
CREATE TABLE P_LEW_MART_CS.T_SPACEMAN_STORE_ITEM_PERFORMANCE_1 CLUSTER BY (client_id, export_cy_week, export_version)
(
     export_cy_week         NUMBER(38,0)    NOT NULL        COMMENT 'The last completed (closed) CW in the Export',
     export_version         NUMBER(4,0)     NOT NULL        COMMENT 'Version number of export data =0: Full, >0: Delta',
     client_id              NUMBER(38,0)    NOT NULL        COMMENT 'Internal client_id',
     filialnummer           VARCHAR(8)      NOT NULL        COMMENT 'Country_1 Code (country_cd)',
     artikelnummer_lang     VARCHAR(21)     NOT NULL        COMMENT 'Store number (Business Key)',
     landeskurzel           VARCHAR(3)      NOT NULL        COMMENT 'Short Article Number (Business Key)',
     artikelnummer_kurz     VARCHAR(18)     NOT NULL        COMMENT 'Article Number including Case Size (Business Key)',
     artikelbezeichnung     VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Article description',
     vk_brutto              NUMBER(9,2)                     COMMENT 'Cuurent sales_1 price',
     koliinhalt             VARCHAR(4)                      COMMENT 'Case Size',
     palletenfaktor         VARCHAR(8)                      COMMENT 'Pallet factor',
     marken                 VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Brand_1 name of article',
     wg_bezeichnung         VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Product group description',
     uwg                    VARCHAR(5)                      COMMENT 'Product sub group',
     artikelfamilie         VARCHAR(10)                     COMMENT 'Product family',
     markenart              VARCHAR(3)                      COMMENT 'Brand_1 type',
     ab1                    NUMBER(10,2)                    COMMENT 'Sales_1 average last 9 weeks',
     ab2                    NUMBER(10,2)                    COMMENT 'Sales_1 average last 12 weeks',
     ab3                    NUMBER(10,2)                    COMMENT 'Sales_1 average last 24 weeks',
     ab4                    NUMBER(10,2)                    COMMENT 'Sales_1 average last 52 weeks',
     ob                     NUMBER(10,2)                    COMMENT 'Projected inventory requirement',
     abverkauf_woche        NUMBER(18,5)                    COMMENT 'Sales_1 pieces with dependency to Net time worked flag',--added column SALES_PIECES NUMBER(18,5) COMMENT 'Sales_1 pieces with dependency to Net time 
     umsatz_woche           NUMBER(18,5)                    COMMENT 'worked flag', --- VAL_RTL_NET_EJR_ASIS which is derived from SALES_NET_VAL NUMBER(18,5) NOT NULL,worked flag
     shelf_life_store       NUMBER(38,0)                    COMMENT 'Shelf Life in store',
     shelf_life_cust        NUMBER(38,0)                    COMMENT 'Shelf life after sale',
     store_days_open        NUMBER(38,0)                    COMMENT 'Number of store open days per week',
	item_status_id         NUMBER(38,0)                    COMMENT 'Item_1 Status_1',
     export_tstmp           TIMESTAMP_NTZ(9)                COMMENT 'Export Timestamp for this version of export_cy_week',
     export_full_tstmp      TIMESTAMP_NTZ(9)                COMMENT 'Export Timestamp for version 0 of export_cy_week',
     exported_fg            NUMBER(38,0)                    COMMENT 'Feedback Flag for Export Reader to flag that the data has been successfully exported',
	 UNIQUE (export_cy_week, export_version, client_id, filialnummer, artikelnummer_lang)
) COMMENT = 'Table for Spaceman Export Data'
;