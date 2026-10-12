/* #----------------------------------------------------------------------------
# History:
#  1.0   8.11.2017    Gabriel Toth             Initial version
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.3  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.4  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.5  17.01.2018    Wieber.Harald            Release 2.2
#  1.6  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.7  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.8  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.9  12.04.2018    Wieber.Harald            Update Release 3.3
# 1.10  25.04.2018    Wieber.Harald            Update Release 3.5
# 1.11  03.05.2018    Wieber.Harald            Release 3.6
# 1.12  17.05.2018    Wieber,Harald            Update Release 3.8
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  04.01.2022    Morris, Michael          Added Estonia
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_load_status_kpi_asis (kpi_id, kpi_group_id, kpi_desc_at, kpi_desc_be
, kpi_desc_be_fr, kpi_desc_bg, kpi_desc_ch, kpi_desc_cy, kpi_desc_cz, kpi_desc, kpi_desc_dk, kpi_desc_ee, kpi_desc_es,
kpi_desc_fi, kpi_desc_fr, kpi_desc_gb, kpi_desc_gr, kpi_desc_hr, kpi_desc_hu, kpi_desc_ie, kpi_desc_it, kpi_desc_lt,
kpi_desc_lv, kpi_desc_ni, kpi_desc_nl, kpi_desc_de, kpi_desc_pl, kpi_desc_pt, kpi_desc_ro, kpi_desc_se, kpi_desc_si,
kpi_desc_sk, kpi_desc_cs, kpi_desc_mt, kpi_desc_us, kpi_desc_rs, kpi_short_desc_at, kpi_short_desc_be,
kpi_short_desc_be_fr, kpi_short_desc_bg, kpi_short_desc_ch, kpi_short_desc_cy, kpi_short_desc_cz, kpi_short_desc,
kpi_short_desc_dk, kpi_short_desc_ee, kpi_short_desc_es, kpi_short_desc_fi, kpi_short_desc_fr, kpi_short_desc_gb,
kpi_short_desc_gr, kpi_short_desc_hr, kpi_short_desc_hu, kpi_short_desc_ie, kpi_short_desc_it, kpi_short_desc_lt,
kpi_short_desc_lv, kpi_short_desc_ni, kpi_short_desc_nl, kpi_short_desc_de, kpi_short_desc_pl, kpi_short_desc_pt,
kpi_short_desc_ro, kpi_short_desc_se, kpi_short_desc_si, kpi_short_desc_sk, kpi_short_desc_cs, kpi_short_desc_mt,
kpi_short_desc_us, kpi_short_desc_rs, kpi_source_id, kpi_level_cd, kpi_sort_rank, mod_tmsp) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_load_status_kpi_asis;