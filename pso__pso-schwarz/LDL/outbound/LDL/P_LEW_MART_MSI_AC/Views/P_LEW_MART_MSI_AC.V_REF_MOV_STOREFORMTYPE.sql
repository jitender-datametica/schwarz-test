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
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  04.01-2022    Morris, Michael          Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_mov_storeformtype (client_id OPTIONS(description='Landeskennzeichen'),
sfotype_id OPTIONS(description='Belegtyp-Belegtyp'), sfotype_desc_at
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit AT'), sfotype_desc_be
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit BE'), sfotype_desc_be_fr
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit BE_FR'), sfotype_desc_bg
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit BG'), sfotype_desc_ch
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit CH'), sfotype_desc_cy
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit CY'), sfotype_desc_cz
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit CZ'), sfotype_desc
OPTIONS(description='Belegbeschreibung-Belegbeschreibung'), sfotype_desc_dk
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit DK'), sfotype_desc_ee
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit EE'), sfotype_desc_es
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit ES'), sfotype_desc_fi
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit FI'), sfotype_desc_fr
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit FR'), sfotype_desc_gb
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit GB'), sfotype_desc_gr
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit GR'), sfotype_desc_hr
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit HR'), sfotype_desc_hu
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit HU'), sfotype_desc_ie
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit IE'), sfotype_desc_it
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit IT'), sfotype_desc_lt
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit LT'), sfotype_desc_lv
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit LV'), sfotype_desc_ni
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit NI'), sfotype_desc_nl
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit NL'), sfotype_desc_de
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit DE'), sfotype_desc_pl
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit PL'), sfotype_desc_pt
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit PT'), sfotype_desc_ro
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit RO'), sfotype_desc_se
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit SE'), sfotype_desc_si
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit SI'), sfotype_desc_sk
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit SK'), sfotype_desc_cs
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit CS'), sfotype_desc_mt
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit MT'), sfotype_desc_us
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit US'), sfotype_desc_rs
OPTIONS(description='sfotype Landesspezifische Bezeichnung Einheit RS'))
OPTIONS(DESCRIPTION = `Multi language reference for storeform`) AS SELECT client_id,
 sfotype_id,
 sfotype_desc_at,
 sfotype_desc_be,
 sfotype_desc_be_fr,
 sfotype_desc_bg,
 sfotype_desc_ch,
 sfotype_desc_cy,
 sfotype_desc_cz,
 sfotype_desc,
 sfotype_desc_dk,
 sfotype_desc_ee,
 sfotype_desc_es,
 sfotype_desc_fi,
 sfotype_desc_fr,
 sfotype_desc_gb,
 sfotype_desc_gr,
 sfotype_desc_hr,
 sfotype_desc_hu,
 sfotype_desc_ie,
 sfotype_desc_it,
 sfotype_desc_lt,
 sfotype_desc_lv,
 sfotype_desc_ni,
 sfotype_desc_nl,
 sfotype_desc_de,
 sfotype_desc_pl,
 sfotype_desc_pt,
 sfotype_desc_ro,
 sfotype_desc_se,
 sfotype_desc_si,
 sfotype_desc_sk,
 sfotype_desc_cs,
 sfotype_desc_mt,
 sfotype_desc_us,
 sfotype_desc_rs
FROM ldl_p_lew_mart_msi.v_ref_mov_storeformtype;