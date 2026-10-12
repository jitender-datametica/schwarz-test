CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_RETURN_RECEIPTTYPE COMMENT = 'Multi language return receipt type reference'
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
# 1.11  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.12  04.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  return_receipttype_id         COMMENT 'Return_k Bez. Einheit id'
, return_receipttype_desc_AT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit AT'
, return_receipttype_desc_BE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BE'
, return_receipttype_desc_BE_FR COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BE_FR'
, return_receipttype_desc_BG    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit BG'
, return_receipttype_desc_CH    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CH'
, return_receipttype_desc_CY    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CY'
, return_receipttype_desc_CZ    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CZ'
, return_receipttype_desc       COMMENT 'Return_k Bez. Einheit desc'
, return_receipttype_desc_DK    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit DK'
, return_receipttype_desc_EE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit EE'
, return_receipttype_desc_ES    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit ES'
, return_receipttype_desc_FI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit FI'
, return_receipttype_desc_FR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit FR'
, return_receipttype_desc_GB    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit GB'
, return_receipttype_desc_GR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit GR'
, return_receipttype_desc_HR    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit HR'
, return_receipttype_desc_HU    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit HU'
, return_receipttype_desc_IE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit IE'
, return_receipttype_desc_IT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit IT'
, return_receipttype_desc_LT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit LT'
, return_receipttype_desc_LV    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit LV'
, return_receipttype_desc_NI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit NI'
, return_receipttype_desc_NL    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit NL'
, return_receipttype_desc_DE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit DE'
, return_receipttype_desc_PL    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit PL'
, return_receipttype_desc_PT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit PT'
, return_receipttype_desc_RO    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit RO'
, return_receipttype_desc_SE    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SE'
, return_receipttype_desc_SI    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SI'
, return_receipttype_desc_SK    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit SK'
, return_receipttype_desc_CS    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit CS'
, return_receipttype_desc_MT    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit MT'
, return_receipttype_desc_US    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit US'
, return_receipttype_desc_RS    COMMENT 'Return_k Landesspezifische Bezeichnung Einheit RS'
 )
AS
SELECT   return_receipttype_id
       , return_receipttype_desc_AT
       , return_receipttype_desc_BE
       , return_receipttype_desc_BE_FR
       , return_receipttype_desc_BG
       , return_receipttype_desc_CH
       , return_receipttype_desc_CY
       , return_receipttype_desc_CZ
       , return_receipttype_desc
       , return_receipttype_desc_DK
       , return_receipttype_desc_EE
       , return_receipttype_desc_ES
       , return_receipttype_desc_FI
       , return_receipttype_desc_FR
       , return_receipttype_desc_GB
       , return_receipttype_desc_GR
       , return_receipttype_desc_HR
       , return_receipttype_desc_HU
       , return_receipttype_desc_IE
       , return_receipttype_desc_IT
       , return_receipttype_desc_LT
       , return_receipttype_desc_LV
       , return_receipttype_desc_NI
       , return_receipttype_desc_NL
       , return_receipttype_desc_DE
       , return_receipttype_desc_PL
       , return_receipttype_desc_PT
       , return_receipttype_desc_RO
       , return_receipttype_desc_SE
       , return_receipttype_desc_SI
       , return_receipttype_desc_SK
       , return_receipttype_desc_CS
       , return_receipttype_desc_MT
       , return_receipttype_desc_US
       , return_receipttype_desc_RS
  FROM P_LEW_MART_MSI.v_ref_return_receipttype
;