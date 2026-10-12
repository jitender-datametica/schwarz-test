CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_MOV_STOREFORMTYPE_1 COMMENT = 'Multi language reference for storeform'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  04.01-2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id           COMMENT 'Landeskennzeichen'
, sfotype_id          COMMENT 'Belegtyp-Belegtyp'
, sfotype_desc_AT     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit AT'
, sfotype_desc_BE     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BE'
, sfotype_desc_BE_FR  COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BE_FR'
, sfotype_desc_BG     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BG'
, sfotype_desc_CH     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CH'
, sfotype_desc_CY     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CY'
, sfotype_desc_CZ     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CZ'
, sfotype_desc        COMMENT 'Belegbeschreibung-Belegbeschreibung'
, sfotype_desc_DK     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit DK'
, sfotype_desc_EE     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit EE'
, sfotype_desc_ES     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit ES'
, sfotype_desc_FI     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit FI'
, sfotype_desc_FR     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit FR'
, sfotype_desc_GB     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit GB'
, sfotype_desc_GR     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit GR'
, sfotype_desc_HR     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit HR'
, sfotype_desc_HU     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit HU'
, sfotype_desc_IE     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit IE'
, sfotype_desc_IT     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit IT'
, sfotype_desc_LT     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit LT'
, sfotype_desc_LV     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit LV'
, sfotype_desc_NI     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit NI'
, sfotype_desc_NL     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit NL'
, sfotype_desc_DE     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit DE'
, sfotype_desc_PL     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit PL'
, sfotype_desc_PT     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit PT'
, sfotype_desc_RO     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit RO'
, sfotype_desc_SE     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SE'
, sfotype_desc_SI     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SI'
, sfotype_desc_SK     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SK'
, sfotype_desc_CS     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CS'
, sfotype_desc_MT     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit MT'
, sfotype_desc_US     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit US'
, sfotype_desc_RS     COMMENT 'sfotype Landesspezifische Bezeichnung Einheit RS_1'
 )
AS
SELECT   client_id
       , sfotype_id
       , sfotype_desc_AT
       , sfotype_desc_BE
       , sfotype_desc_BE_FR
       , sfotype_desc_BG
       , sfotype_desc_CH
       , sfotype_desc_CY
       , sfotype_desc_CZ
       , sfotype_desc
       , sfotype_desc_DK
       , sfotype_desc_EE
       , sfotype_desc_ES
       , sfotype_desc_FI
       , sfotype_desc_FR
       , sfotype_desc_GB
       , sfotype_desc_GR
       , sfotype_desc_HR
       , sfotype_desc_HU
       , sfotype_desc_IE
       , sfotype_desc_IT
       , sfotype_desc_LT
       , sfotype_desc_LV
       , sfotype_desc_NI
       , sfotype_desc_NL
       , sfotype_desc_DE
       , sfotype_desc_PL
       , sfotype_desc_PT
       , sfotype_desc_RO
       , sfotype_desc_SE
       , sfotype_desc_SI
       , sfotype_desc_SK
       , sfotype_desc_CS
       , sfotype_desc_MT
       , sfotype_desc_US
       , sfotype_desc_RS
  FROM P_LEW_MART_MSI.v_ref_mov_storeformtype_1
;