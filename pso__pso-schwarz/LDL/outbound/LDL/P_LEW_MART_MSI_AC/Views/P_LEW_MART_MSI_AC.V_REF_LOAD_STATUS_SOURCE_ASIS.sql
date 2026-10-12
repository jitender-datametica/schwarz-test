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
#  1.9  25.04.2018    Wieber.Harald            Update Release 3.5
# 1.10  03.05.2018    Wieber.Harald            Release 3.6
# 1.11  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.12  07.08.2020    Roy,Ritanjal             Introduce new country Latviya
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  04.01.2022    Morris, Michael          Added Estonia
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_load_status_source_asis (source_id, source_desc_at, source_desc_be,
source_desc_be_fr, source_desc_bg, source_desc_ch, source_desc_cy, source_desc_cz, source_desc, source_desc_dk,
source_desc_ee, source_desc_es, source_desc_fi, source_desc_fr, source_desc_gb, source_desc_gr, source_desc_hr,
source_desc_hu, source_desc_ie, source_desc_it, source_desc_lt, source_desc_lv, source_desc_ni, source_desc_nl,
source_desc_de, source_desc_pl, source_desc_pt, source_desc_ro, source_desc_se, source_desc_si, source_desc_sk,
source_desc_cs, source_desc_mt, source_desc_us, source_desc_rs, mod_tmsp) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_load_status_source_asis;