CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITM_CONSOLIDATIONGROUP_DESC COMMENT = 'Item consolidation description view'
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
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
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  10.08.2020    Roy,Ritanjal             Introduce new country Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 12.04.2021    Morris, Michael          Copied from lew_mart_msi. BGES/VGES functionality added
#                                              20210318_2789_itm_store_cons
#                                              https://jira.schwarz/browse/INTMIG-779
#                                              SF: https://jira.schwarz/browse/INTMIG-1399
#---------------------------------------------------------------------------
*/
(
  client_id                  COMMENT 'International client ID'
, wh_id                      COMMENT 'Company ID'
, aspect_id                  COMMENT 'Aspect BGES or VGES'
, itm_consgrp_id             COMMENT 'Item consolidation group ID'
, cons_orig_item_nr          COMMENT 'Original consolidation item nr.'
, cons_dat_valid_from_item   COMMENT 'Record valid from date'
, cons_fg                    COMMENT 'Consolidation Flag'
, cons_item_desc_AT          COMMENT 'Consolidation item description'
, cons_item_desc_BE          COMMENT 'Consolidation item description'
, cons_item_desc_BE_FR       COMMENT 'Consolidation item description'
, cons_item_desc_BG          COMMENT 'Consolidation item description'
, cons_item_desc_CH          COMMENT 'Consolidation item description'
, cons_item_desc_CY          COMMENT 'Consolidation item description'
, cons_item_desc_CZ          COMMENT 'Consolidation item description'
, cons_item_desc             COMMENT 'Consolidation item description'
, cons_item_desc_DK          COMMENT 'Consolidation item description'
, cons_item_desc_EE          COMMENT 'Consolidation item description'
, cons_item_desc_ES          COMMENT 'Consolidation item description'
, cons_item_desc_FI          COMMENT 'Consolidation item description'
, cons_item_desc_FR          COMMENT 'Consolidation item description'
, cons_item_desc_GB          COMMENT 'Consolidation item description'
, cons_item_desc_GR          COMMENT 'Consolidation item description'
, cons_item_desc_HR          COMMENT 'Consolidation item description'
, cons_item_desc_HU          COMMENT 'Consolidation item description'
, cons_item_desc_IE          COMMENT 'Consolidation item description'
, cons_item_desc_IT          COMMENT 'Consolidation item description'
, cons_item_desc_LT          COMMENT 'Consolidation item description'
, cons_item_desc_LV          COMMENT 'Consolidation item description'
, cons_item_desc_NI          COMMENT 'Consolidation item description'
, cons_item_desc_NL          COMMENT 'Consolidation item description'
, cons_item_desc_DE          COMMENT 'Consolidation item description'
, cons_item_desc_PL          COMMENT 'Consolidation item description'
, cons_item_desc_PT          COMMENT 'Consolidation item description'
, cons_item_desc_RO          COMMENT 'Consolidation item description'
, cons_item_desc_SE          COMMENT 'Consolidation item description'
, cons_item_desc_SI          COMMENT 'Consolidation item description'
, cons_item_desc_SK          COMMENT 'Consolidation item description'
, cons_item_desc_CS          COMMENT 'Consolidation item description'
, cons_item_desc_MT          COMMENT 'Consolidation item description'
, cons_item_desc_US          COMMENT 'Consolidation item description'
, cons_item_desc_RS          COMMENT 'Consolidation item description'
)
AS
SELECT   client_id
       , wh_id
       , aspect_id
       , itm_consgrp_id
       , cons_orig_item_nr
       , cons_dat_valid_from_item
       , cons_fg
       , cons_item_desc_AT
       , cons_item_desc_BE
       , cons_item_desc_BE_FR
       , cons_item_desc_BG
       , cons_item_desc_CH
       , cons_item_desc_CY
       , cons_item_desc_CZ
       , cons_item_desc
       , cons_item_desc_DK
       , cons_item_desc_EE
       , cons_item_desc_ES
       , cons_item_desc_FI
       , cons_item_desc_FR
       , cons_item_desc_GB
       , cons_item_desc_GR
       , cons_item_desc_HR
       , cons_item_desc_HU
       , cons_item_desc_IE
       , cons_item_desc_IT
       , cons_item_desc_LT
       , cons_item_desc_LV
       , cons_item_desc_NI
       , cons_item_desc_NL
       , cons_item_desc_DE
       , cons_item_desc_PL
       , cons_item_desc_PT
       , cons_item_desc_RO
       , cons_item_desc_SE
       , cons_item_desc_SI
       , cons_item_desc_SK
       , cons_item_desc_CS
       , cons_item_desc_MT
       , cons_item_desc_US
       , cons_item_desc_RS
  FROM P_LEW_MART_LEAD.v_itm_consolidationgroup_desc
;