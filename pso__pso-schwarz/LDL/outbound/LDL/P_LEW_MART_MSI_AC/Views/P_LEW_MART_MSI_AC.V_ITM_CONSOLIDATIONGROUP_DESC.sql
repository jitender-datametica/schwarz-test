/* #----------------------------------------------------------------------------
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
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_consolidationgroup_desc (client_id
OPTIONS(description='Landeskennzeichen'), wh_id OPTIONS(description='Gesellschafts-Nr.'), itm_consgrp_id
OPTIONS(description='BGES (1)/VGES (2)'), cons_orig_item_nr OPTIONS(description='Konsolidierungsobergruppennummer'),
cons_dat_valid_from_item OPTIONS(description='Gültig von Datum'), cons_fg
OPTIONS(description='Consolidierungs-Gruppen Flag'), cons_item_desc_at
OPTIONS(description='Consolidierungsgruppe Bezeichnung '), cons_item_desc_be
OPTIONS(description='Consolidierungsgruppe Bezeichnung BE'), cons_item_desc_be_fr
OPTIONS(description='Consolidierungsgruppe Bezeichnung BE_FR'), cons_item_desc_bg
OPTIONS(description='Consolidierungsgruppe Bezeichnung BG'), cons_item_desc_ch
OPTIONS(description='Consolidierungsgruppe Bezeichnung CH'), cons_item_desc_cy
OPTIONS(description='Consolidierungsgruppe Bezeichnung CY'), cons_item_desc_cz
OPTIONS(description='Consolidierungsgruppe Bezeichnung CZ'), cons_item_desc
OPTIONS(description='Consolidierungsgruppe Bezeichnung'), cons_item_desc_dk
OPTIONS(description='Consolidierungsgruppe Bezeichnung DK'), cons_item_desc_ee
OPTIONS(description='Consolidierungsgruppe Bezeichnung EE'), cons_item_desc_es
OPTIONS(description='Consolidierungsgruppe Bezeichnung ES'), cons_item_desc_fi
OPTIONS(description='Consolidierungsgruppe Bezeichnung FI'), cons_item_desc_fr
OPTIONS(description='Consolidierungsgruppe Bezeichnung FR'), cons_item_desc_gb
OPTIONS(description='Consolidierungsgruppe Bezeichnung GB'), cons_item_desc_gr
OPTIONS(description='Consolidierungsgruppe Bezeichnung GR'), cons_item_desc_hr
OPTIONS(description='Consolidierungsgruppe Bezeichnung HR'), cons_item_desc_hu
OPTIONS(description='Consolidierungsgruppe Bezeichnung HU'), cons_item_desc_ie
OPTIONS(description='Consolidierungsgruppe Bezeichnung IE'), cons_item_desc_it
OPTIONS(description='Consolidierungsgruppe Bezeichnung IT'), cons_item_desc_lt
OPTIONS(description='Consolidierungsgruppe Bezeichnung LT'), cons_item_desc_lv
OPTIONS(description='Consolidierungsgruppe Bezeichnung LV'), cons_item_desc_ni
OPTIONS(description='Consolidierungsgruppe Bezeichnung NI'), cons_item_desc_nl
OPTIONS(description='Consolidierungsgruppe Bezeichnung NL'), cons_item_desc_de
OPTIONS(description='Consolidierungsgruppe Bezeichnung DE'), cons_item_desc_pl
OPTIONS(description='Consolidierungsgruppe Bezeichnung PL'), cons_item_desc_pt
OPTIONS(description='Consolidierungsgruppe Bezeichnung PT'), cons_item_desc_ro
OPTIONS(description='Consolidierungsgruppe Bezeichnung RO'), cons_item_desc_se
OPTIONS(description='Consolidierungsgruppe Bezeichnung SE'), cons_item_desc_si
OPTIONS(description='Consolidierungsgruppe Bezeichnung SI'), cons_item_desc_sk
OPTIONS(description='Consolidierungsgruppe Bezeichnung SK'), cons_item_desc_cs
OPTIONS(description='Consolidierungsgruppe Bezeichnung CS'), cons_item_desc_mt
OPTIONS(description='Consolidierungsgruppe Bezeichnung MT'), cons_item_desc_us
OPTIONS(description='Consolidierungsgruppe Bezeichnung US'), cons_item_desc_rs
OPTIONS(description='Consolidierungsgruppe Bezeichnung RS'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE ITEM CONSOLIDATION GROUP DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_consolidationgroup_desc;