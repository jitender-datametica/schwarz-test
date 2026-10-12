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
#  2.0  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.11 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              Patch: 20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 27.12.2021    Zied Nanaa               Add languages BE_FR and EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_actiongroup_desc_1 (client_id OPTIONS(description='Landeskennzeichen'),
item_actiongroup_id
OPTIONS(description='Referenziert auf C665_MAINGRPNR, in der WAWI auf STRING 13, da zuerst geplant war, ACTIONGRP und AC'),
dat_valid_from OPTIONS(description='Gültig ab, wird vom Vorsystem Wawi geliefert'), dat_valid_until
OPTIONS(description='Gültig bis, wird vom Vorsystem Wawi geliefert'), item_actgroup_desc_at
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung AT'), item_actgroup_desc_be
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BE'), item_actgroup_desc_be_fr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BE_FR'), item_actgroup_desc_bg
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung BG'), item_actgroup_desc_ch
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CH'), item_actgroup_desc_cy
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CY'), item_actgroup_desc_cz
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CZ'), item_actgroup_desc
OPTIONS(description='Artikel_1 - Aktionsgruppe Beschreibung'), item_actgroup_desc_dk
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung DK'), item_actgroup_desc_ee
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung EE'), item_actgroup_desc_es
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung ES'), item_actgroup_desc_fi
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung FI'), item_actgroup_desc_fr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung FR'), item_actgroup_desc_gb
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung GB'), item_actgroup_desc_gr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung GR'), item_actgroup_desc_hr
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung HR'), item_actgroup_desc_hu
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung HU'), item_actgroup_desc_ie
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung IE'), item_actgroup_desc_it
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung IT'), item_actgroup_desc_lt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung LT'), item_actgroup_desc_lv
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung LV'), item_actgroup_desc_ni
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung NI'), item_actgroup_desc_nl
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung NL'), item_actgroup_desc_de
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung DE'), item_actgroup_desc_pl
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung PL'), item_actgroup_desc_pt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung PT'), item_actgroup_desc_ro
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung RO'), item_actgroup_desc_se
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SE'), item_actgroup_desc_si
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SI'), item_actgroup_desc_sk
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung SK'), item_actgroup_desc_cs
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung CS'), item_actgroup_desc_mt
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung MT'), item_actgroup_desc_us
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung US'), item_actgroup_desc_rs
OPTIONS(description='Artikel_1 - Aktionsgruppe Landesspezifische Bezeichnung RS_1'))
OPTIONS(DESCRIPTION = `Mulri language item_1 action group descriptions`) AS SELECT client_id,
 item_actiongroup_id,
 dat_valid_from,
 dat_valid_until,
 item_actgroup_desc_at,
 item_actgroup_desc_be,
 item_actgroup_desc_be_fr,
 item_actgroup_desc_bg,
 item_actgroup_desc_ch,
 item_actgroup_desc_cy,
 item_actgroup_desc_cz,
 item_actgroup_desc,
 item_actgroup_desc_dk,
 item_actgroup_desc_ee,
 item_actgroup_desc_es,
 item_actgroup_desc_fi,
 item_actgroup_desc_fr,
 item_actgroup_desc_gb,
 item_actgroup_desc_gr,
 item_actgroup_desc_hr,
 item_actgroup_desc_hu,
 item_actgroup_desc_ie,
 item_actgroup_desc_it,
 item_actgroup_desc_lt,
 item_actgroup_desc_lv,
 item_actgroup_desc_ni,
 item_actgroup_desc_nl,
 item_actgroup_desc_de,
 item_actgroup_desc_pl,
 item_actgroup_desc_pt,
 item_actgroup_desc_ro,
 item_actgroup_desc_se,
 item_actgroup_desc_si,
 item_actgroup_desc_sk,
 item_actgroup_desc_cs,
 item_actgroup_desc_mt,
 item_actgroup_desc_us,
 item_actgroup_desc_rs
FROM ldl_p_lew_mart_msi.v_itm_actiongroup_desc_1;