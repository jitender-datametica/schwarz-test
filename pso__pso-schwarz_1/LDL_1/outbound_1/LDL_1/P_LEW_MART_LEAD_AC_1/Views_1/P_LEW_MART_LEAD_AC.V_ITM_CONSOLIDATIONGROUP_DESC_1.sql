/* #----------------------------------------------------------------------------
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
#  2.0  10.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 12.04.2021    Morris, Michael          Copied from lew_mart_msi. BGES/VGES functionality added
#                                              20210318_2789_itm_store_cons
#                                              https://jira.schwarz/browse/INTMIG-779
#                                              SF: https://jira.schwarz/browse/INTMIG-1399
#--------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_consolidationgroup_desc_1 (client_id
OPTIONS(description='International client ID'), wh_id OPTIONS(description='Company ID'), aspect_id
OPTIONS(description='Aspect BGES or VGES'), itm_consgrp_id OPTIONS(description='Item_1 consolidation group ID'),
cons_orig_item_nr OPTIONS(description='Original consolidation item_1 nr.'), cons_dat_valid_from_item
OPTIONS(description='Record valid from date'), cons_fg OPTIONS(description='Consolidation Flag'), cons_item_desc_at
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_be
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_be_fr
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_bg
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_ch
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_cy
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_cz
OPTIONS(description='Consolidation item_1 description'), cons_item_desc
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_dk
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_ee
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_es
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_fi
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_fr
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_gb
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_gr
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_hr
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_hu
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_ie
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_it
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_lt
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_lv
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_ni
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_nl
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_de
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_pl
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_pt
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_ro
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_se
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_si
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_sk
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_cs
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_mt
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_us
OPTIONS(description='Consolidation item_1 description'), cons_item_desc_rs
OPTIONS(description='Consolidation item_1 description')) OPTIONS(DESCRIPTION = `ITEM_1 CONSOLIDATION DESCRIPTION VIEW`) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_itm_consolidationgroup_desc_1;