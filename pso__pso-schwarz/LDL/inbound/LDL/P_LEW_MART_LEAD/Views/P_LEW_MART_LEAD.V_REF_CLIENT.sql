CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_CLIENT COMMENT = 'Lead project : Client reference view'
/*
#----------------------------------------------------------------------------
# History:
#
# Vrs Date       Developer           Task
# --- ---------- --------------      ---------------------------------------
# 1.0 2018-03-28 Tris Bayliff        Initial version
#                                    20180328_1631_QuickView_BR_Client_View
# 1.1 2018-10-09 Joerg  Gräff        adapt country_opening_date for serbia and us 
#                                    20181009_1854_RS_Korrektur_Landesnamen
# 1.2  06.08.2020 Roy,Ritanjal       Introduce new country LV
# 1.2  03.01.2022 Morris, Michael    Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  int_id           COMMENT 'Lidl International ID'
, client_id        COMMENT 'Landeskennzeichen'
, country_id       COMMENT 'Country ID'
, client_desc_AT   COMMENT 'Client description: AT'
, client_desc_BE   COMMENT 'Client description: BE'
, client_desc_BG   COMMENT 'Client description: BG'
, client_desc_CH   COMMENT 'Client description: CH'
, client_desc_CY   COMMENT 'Client description: CY'
, client_desc_CZ   COMMENT 'Client description: CZ'
, client_desc      COMMENT 'Client description: International'
, client_desc_DK   COMMENT 'Client description: DK'
, client_desc_EE   COMMENT 'Client description: EE'
, client_desc_ES   COMMENT 'Client description: ES'
, client_desc_FI   COMMENT 'Client description: FI'
, client_desc_FR   COMMENT 'Client description: FR'
, client_desc_GB   COMMENT 'Client description: GB'
, client_desc_GR   COMMENT 'Client description: GR'
, client_desc_HR   COMMENT 'Client description: HR'
, client_desc_HU   COMMENT 'Client description: HU'
, client_desc_IE   COMMENT 'Client description: IE'
, client_desc_IT   COMMENT 'Client description: IT'
, client_desc_LT   COMMENT 'Client description: LT'
, client_desc_LV   COMMENT 'Client description: LV'
, client_desc_NI   COMMENT 'Client description: NI'
, client_desc_NL   COMMENT 'Client description: NL'
, client_desc_DE   COMMENT 'Client description: DE'
, client_desc_PL   COMMENT 'Client description: PL'
, client_desc_PT   COMMENT 'Client description: PT'
, client_desc_RO   COMMENT 'Client description: RO'
, client_desc_SE   COMMENT 'Client description: SE'
, client_desc_SI   COMMENT 'Client description: SI'
, client_desc_SK   COMMENT 'Client description: SK'
, client_desc_CS   COMMENT 'Client description: CS'
, client_desc_MT   COMMENT 'Client description: MT'
, client_desc_US   COMMENT 'Client description: US'
, client_desc_RS   COMMENT 'Client description: RS'
)
AS
SELECT   1                                                               AS int_id
       , client_id
       , country_id
       , MAX(CASE WHEN language_id = 1  THEN client_desc ELSE NULL END ) AS client_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN client_desc ELSE NULL END ) AS client_desc_BE
       , MAX(CASE WHEN language_id = 3  THEN client_desc ELSE NULL END ) AS client_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN client_desc ELSE NULL END ) AS client_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN client_desc ELSE NULL END ) AS client_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN client_desc ELSE NULL END ) AS client_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN client_desc ELSE NULL END ) AS client_desc
       , MAX(CASE WHEN language_id = 8  THEN client_desc ELSE NULL END ) AS client_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN client_desc ELSE NULL END ) AS client_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN client_desc ELSE NULL END ) AS client_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN client_desc ELSE NULL END ) AS client_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN client_desc ELSE NULL END ) AS client_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN client_desc ELSE NULL END ) AS client_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN client_desc ELSE NULL END ) AS client_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN client_desc ELSE NULL END ) AS client_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN client_desc ELSE NULL END ) AS client_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN client_desc ELSE NULL END ) AS client_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN client_desc ELSE NULL END ) AS client_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN client_desc ELSE NULL END ) AS client_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN client_desc ELSE NULL END ) AS client_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN client_desc ELSE NULL END ) AS client_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN client_desc ELSE NULL END ) AS client_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN client_desc ELSE NULL END ) AS client_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN client_desc ELSE NULL END ) AS client_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN client_desc ELSE NULL END ) AS client_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN client_desc ELSE NULL END ) AS client_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN client_desc ELSE NULL END ) AS client_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN client_desc ELSE NULL END ) AS client_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN client_desc ELSE NULL END ) AS client_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN client_desc ELSE NULL END ) AS client_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN client_desc ELSE NULL END ) AS client_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN client_desc ELSE NULL END ) AS client_desc_US
       , MAX(CASE WHEN language_id = 34 THEN client_desc ELSE NULL END ) AS client_desc_RS
  FROM (
        SELECT   1                AS int_id
               , cld.client_id    AS client_id
               , cld.language_id  AS language_id
               , cld.client_id    AS country_id
               , cld.client_desc  AS client_desc
          FROM P_LEW_CORE_AC.v_wawi_ref_client_desc AS cld
       ) AS dt

GROUP BY   1
         , client_id
         , country_id
;