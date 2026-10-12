CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_ITM_LOGIST_UNIT_1 COMMENT = 'Multisprache Logistikeinheiten Referenz'
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
#  2.1  08.06.2020    Roy, Ritanjal            Introduce new country_1 Latviya
#  2.2  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  2.3  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------
*/
(
  logistic_unit_cd         COMMENT 'Kennz. Einheit (Liter, Kilo etc)'
, client_id                COMMENT 'Landeskennzeichen'
, logistic_unit_desc_AT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit AT'
, logistic_unit_desc_BE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BE'
, logistic_unit_desc_BE_FR COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BE_FR'
, logistic_unit_desc_BG    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit BG'
, logistic_unit_desc_CH    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CH'
, logistic_unit_desc_CY    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CY'
, logistic_unit_desc_CZ    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CZ'
, logistic_unit_desc       COMMENT 'Bezinh Einheit'
, logistic_unit_desc_DK    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit DK'
, logistic_unit_desc_EE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit EE'
, logistic_unit_desc_ES    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit ES'
, logistic_unit_desc_FI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit FI'
, logistic_unit_desc_FR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit FR'
, logistic_unit_desc_GB    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit GB'
, logistic_unit_desc_GR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit GR'
, logistic_unit_desc_HR    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit HR'
, logistic_unit_desc_HU    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit HU'
, logistic_unit_desc_IE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit IE'
, logistic_unit_desc_IT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit IT'
, logistic_unit_desc_LT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit LT'
, logistic_unit_desc_LV    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit LV'
, logistic_unit_desc_NI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit NI'
, logistic_unit_desc_NL    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit NL'
, logistic_unit_desc_DE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit DE'
, logistic_unit_desc_PL    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit PL'
, logistic_unit_desc_PT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit PT'
, logistic_unit_desc_RO    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit RO'
, logistic_unit_desc_SE    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SE'
, logistic_unit_desc_SI    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SI'
, logistic_unit_desc_SK    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit SK'
, logistic_unit_desc_CS    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit CS'
, logistic_unit_desc_MT    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit MT'
, logistic_unit_desc_US    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit US'
, logistic_unit_desc_RS    COMMENT 'Logistik Landesspezifische Bezeichnung Einheit RS_1'
, logistic_base_unit       COMMENT 'Logistik Basiseinheit (1kg)'
, logistic_base_factor     COMMENT 'Logistik Basisfaktor (1000)'
, logistic_base_unit_int   COMMENT 'Logistik Internationale Einheit (g)'
, logistic_base_factor_int COMMENT 'Logistik Internationaler faktor (1000)'
)
AS
SELECT   logistic_unit_cd
       , client_id
       , logistic_unit_desc_AT
       , logistic_unit_desc_BE
       , logistic_unit_desc_BE_FR
       , logistic_unit_desc_BG
       , logistic_unit_desc_CH
       , logistic_unit_desc_CY
       , logistic_unit_desc_CZ
       , logistic_unit_desc
       , logistic_unit_desc_DK
       , logistic_unit_desc_EE
       , logistic_unit_desc_ES
       , logistic_unit_desc_FI
       , logistic_unit_desc_FR
       , logistic_unit_desc_GB
       , logistic_unit_desc_GR
       , logistic_unit_desc_HR
       , logistic_unit_desc_HU
       , logistic_unit_desc_IE
       , logistic_unit_desc_IT
       , logistic_unit_desc_LT
       , logistic_unit_desc_LV
       , logistic_unit_desc_NI
       , logistic_unit_desc_NL
       , logistic_unit_desc_DE
       , logistic_unit_desc_PL
       , logistic_unit_desc_PT
       , logistic_unit_desc_RO
       , logistic_unit_desc_SE
       , logistic_unit_desc_SI
       , logistic_unit_desc_SK
       , logistic_unit_desc_CS
       , logistic_unit_desc_MT
       , logistic_unit_desc_US
       , logistic_unit_desc_RS
       , logistic_base_unit
       , logistic_base_factor
       , logistic_base_unit_int
       , logistic_base_factor_int
  FROM P_LEW_MART_MSI.v_ref_itm_logist_unit_1
;