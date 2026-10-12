/* #----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.6  03.05.2018    Wieber.Harald            Release 3.6
#  1.7  17.05.2018    Wieber,Harald            Update Release 3.8
#  1.8  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.9  21.12.2021    Morris, Michael          Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_adv_int_desc_1 (cy, adv_week_int, adv_wt_nr_int, adv_desc_int,
adv_short_desc_int, adv_desc_int_at, adv_short_desc_int_at, adv_desc_int_be, adv_short_desc_int_be, adv_desc_int_be_fr,
adv_short_desc_int_be_fr, adv_desc_int_bg, adv_short_desc_int_bg, adv_desc_int_ch, adv_short_desc_int_ch,
adv_desc_int_cy, adv_short_desc_int_cy, adv_desc_int_cz, adv_short_desc_int_cz, adv_desc_int_dk, adv_short_desc_int_dk,
adv_desc_int_ee, adv_short_desc_int_ee, adv_desc_int_es, adv_short_desc_int_es, adv_desc_int_fi, adv_short_desc_int_fi,
adv_desc_int_fr, adv_short_desc_int_fr, adv_desc_int_gb, adv_short_desc_int_gb, adv_desc_int_gr, adv_short_desc_int_gr,
adv_desc_int_hr, adv_short_desc_int_hr, adv_desc_int_hu, adv_short_desc_int_hu, adv_desc_int_ie, adv_short_desc_int_ie,
adv_desc_int_it, adv_short_desc_int_it, adv_desc_int_lt, adv_short_desc_int_lt, adv_desc_int_lv, adv_short_desc_int_lv,
adv_desc_int_ni, adv_short_desc_int_ni, adv_desc_int_nl, adv_short_desc_int_nl, adv_desc_int_de, adv_short_desc_int_de,
adv_desc_int_pl, adv_short_desc_int_pl, adv_desc_int_pt, adv_short_desc_int_pt, adv_desc_int_ro, adv_short_desc_int_ro,
adv_desc_int_se, adv_short_desc_int_se, adv_desc_int_si, adv_short_desc_int_si, adv_desc_int_sk, adv_short_desc_int_sk,
adv_desc_int_cs, adv_short_desc_int_cs, adv_desc_int_mt, adv_short_desc_int_mt, adv_desc_int_us, adv_short_desc_int_us,
adv_desc_int_rs, adv_short_desc_int_rs, cy_week) AS SELECT *
FROM ldl_p_lew_mart_msi.v_adv_int_desc_1;