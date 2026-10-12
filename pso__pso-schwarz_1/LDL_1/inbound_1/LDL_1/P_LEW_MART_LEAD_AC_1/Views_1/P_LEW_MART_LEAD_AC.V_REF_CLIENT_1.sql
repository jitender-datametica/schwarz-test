CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_CLIENT_1 COMMENT = 'Lead project - Client reference view'
/*
#----------------------------------------------------------------------------
# History:
#
# Vrs Date       Developer        Task
# --- ---------- --------------   ---------------------------------------
# 1.0 2018-03-28 Tris Bayliff     Initial version
#                                 20180328_1631_QuickView_BR_Client_View
# 1.1  10.08.2020 Roy,Ritanjal    Introduce new country_1 Latviya
# 1.2  04.02.2022 Michael Morris  Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  int_id          COMMENT 'Lidl International ID'
, client_id       COMMENT 'Landeskennzeichen'
, country_id      COMMENT 'Country_1 ID'
, client_desc_AT  COMMENT 'Client description: AT' 
, client_desc_BE  COMMENT 'Client description: BE' 
, client_desc_BG  COMMENT 'Client description: BG' 
, client_desc_CH  COMMENT 'Client description: CH' 
, client_desc_CY  COMMENT 'Client description: CY' 
, client_desc_CZ  COMMENT 'Client description: CZ' 
, client_desc     COMMENT 'Client description: International'
, client_desc_DK  COMMENT 'Client description: DK' 
, client_desc_EE  COMMENT 'Client description: EE' 
, client_desc_ES  COMMENT 'Client description: ES' 
, client_desc_FI  COMMENT 'Client description: FI' 
, client_desc_FR  COMMENT 'Client description: FR' 
, client_desc_GB  COMMENT 'Client description: GB' 
, client_desc_GR  COMMENT 'Client description: GR' 
, client_desc_HR  COMMENT 'Client description: HR' 
, client_desc_HU  COMMENT 'Client description: HU' 
, client_desc_IE  COMMENT 'Client description: IE' 
, client_desc_IT  COMMENT 'Client description: IT' 
, client_desc_LT  COMMENT 'Client description: LT' 
, client_desc_LV  COMMENT 'Client description: LV' 
, client_desc_NI  COMMENT 'Client description: NI' 
, client_desc_NL  COMMENT 'Client description: NL' 
, client_desc_DE  COMMENT 'Client description: DE' 
, client_desc_PL  COMMENT 'Client description: PL' 
, client_desc_PT  COMMENT 'Client description: PT' 
, client_desc_RO  COMMENT 'Client description: RO' 
, client_desc_SE  COMMENT 'Client description: SE' 
, client_desc_SI  COMMENT 'Client description: SI' 
, client_desc_SK  COMMENT 'Client description: SK' 
, client_desc_CS  COMMENT 'Client description: CS' 
, client_desc_MT  COMMENT 'Client description: MT' 
, client_desc_US  COMMENT 'Client description: US' 
, client_desc_RS  COMMENT 'Client description: RS_1' 
)
AS
SELECT   int_id
       , client_id
       , country_id
       , client_desc_AT
       , client_desc_BE
       , client_desc_BG
       , client_desc_CH
       , client_desc_CY
       , client_desc_CZ
       , client_desc
       , client_desc_DK
       , client_desc_EE
       , client_desc_ES
       , client_desc_FI
       , client_desc_FR
       , client_desc_GB
       , client_desc_GR
       , client_desc_HR
       , client_desc_HU
       , client_desc_IE
       , client_desc_IT
       , client_desc_LT
       , client_desc_LV
       , client_desc_NI
       , client_desc_NL
       , client_desc_DE
       , client_desc_PL
       , client_desc_PT
       , client_desc_RO
       , client_desc_SE
       , client_desc_SI
       , client_desc_SK
       , client_desc_CS
       , client_desc_MT
       , client_desc_US
       , client_desc_RS
  FROM P_LEW_MART_LEAD.v_ref_client_1
;