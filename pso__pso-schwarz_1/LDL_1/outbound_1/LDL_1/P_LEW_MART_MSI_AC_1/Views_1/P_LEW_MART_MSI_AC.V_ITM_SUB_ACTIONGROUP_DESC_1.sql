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
#  1.10 07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_sub_actiongroup_desc_1 (client_id, item_sub_actiongroup_id,
item_actiongroup_id, dat_valid_from, dat_valid_until, item_sub_actgroup_desc_at, item_sub_actgroup_desc_be,
item_sub_actgroup_desc_be_fr, item_sub_actgroup_desc_bg, item_sub_actgroup_desc_ch, item_sub_actgroup_desc_cy,
item_sub_actgroup_desc_cz, item_sub_actgroup_desc, item_sub_actgroup_desc_dk, item_sub_actgroup_desc_ee,
item_sub_actgroup_desc_es, item_sub_actgroup_desc_fi, item_sub_actgroup_desc_fr, item_sub_actgroup_desc_gb,
item_sub_actgroup_desc_gr, item_sub_actgroup_desc_hr, item_sub_actgroup_desc_hu, item_sub_actgroup_desc_ie,
item_sub_actgroup_desc_it, item_sub_actgroup_desc_lt, item_sub_actgroup_desc_lv, item_sub_actgroup_desc_ni,
item_sub_actgroup_desc_nl, item_sub_actgroup_desc_de, item_sub_actgroup_desc_pl, item_sub_actgroup_desc_pt,
item_sub_actgroup_desc_ro, item_sub_actgroup_desc_se, item_sub_actgroup_desc_si, item_sub_actgroup_desc_sk,
item_sub_actgroup_desc_cs, item_sub_actgroup_desc_mt, item_sub_actgroup_desc_us, item_sub_actgroup_desc_rs) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_sub_actiongroup_desc_1;