CREATE TABLE P_LEW_MART_MSI.T_ITM_ITEM_DESC_1
/*
#----------------------------------------------------------------------------
# History:
#  1.0  14.02.2018    Ueding,Michael           Initial
#  1.2  04.03.2020    Barlow, Cheryl           Removal of MVC - Patch No:2408 IDMO: 2786-20200226_2408_MVC_SMALL_18_DWH20
#  1.3  06.08.2018    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.4  21.12.2021    Michael Morris           Added Estonia EE
#----------------------------------------------------------------------------
*/
(
    CLIENT_ID NUMBER(38,0),
    ITEM_ID NUMBER(38,0),
    ORIG_ITEM_NR NUMBER(18,0),
    ITEM_DESC_AT VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_BE VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_BG VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_CH VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_CY VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_CZ VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_DK VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_EE VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_ES VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_FI VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_FR VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_GB VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_GR VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_HR VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_HU VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_IE VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_IT VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_LT VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_LV VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_NI VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_NL VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_DE VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_PL VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_PT VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_RO VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_SE VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_SI VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_SK VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_CS VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_MT VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_US VARCHAR(100) COLLATE 'en-ci',
    ITEM_DESC_RS VARCHAR(100) COLLATE 'en-ci'
);