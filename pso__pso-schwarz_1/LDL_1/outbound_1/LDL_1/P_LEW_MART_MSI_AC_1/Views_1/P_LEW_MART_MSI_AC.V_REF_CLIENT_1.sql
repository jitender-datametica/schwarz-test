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
#  1.10  17.05.2018   Wieber,Harald            Update Release 3.8
#  1.11  17.11.2020   Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.12  27.11.2020   Morris, Michael          Add Column(s) for _BE_fr
#                                               20200824_2572_trans_NR_FR_corr
#                                               https://jira.schwarz/browse/REP4-7173
#  1.13  27.12.2021   Zied Nanaa                Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_client_1 (int_id OPTIONS(description='Lidl International ID'),
client_id OPTIONS(description='Landeskennzeichen'), country_id OPTIONS(description='Landeskennzeichen'), client_desc_at
OPTIONS(description='Landesspezifische Bezeichnung des Landes AT'), client_desc_be
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE'), client_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes BE_FR'), client_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung des Landes BG'), client_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung des Landes CH'), client_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung des Landes CY'), client_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung des Landes CZ'), client_desc
OPTIONS(description='Bezeichnung des Landes'), client_desc_dk
OPTIONS(description='Landesspezifische Bezeichnung des Landes DK'), client_desc_ee
OPTIONS(description='Landesspezifische Bezeichnung des Landes EE'), client_desc_es
OPTIONS(description='Landesspezifische Bezeichnung des Landes ES'), client_desc_fi
OPTIONS(description='Landesspezifische Bezeichnung des Landes FI'), client_desc_fr
OPTIONS(description='Landesspezifische Bezeichnung des Landes FR'), client_desc_gb
OPTIONS(description='Landesspezifische Bezeichnung des Landes GB'), client_desc_gr
OPTIONS(description='Landesspezifische Bezeichnung des Landes GR'), client_desc_hr
OPTIONS(description='Landesspezifische Bezeichnung des Landes HR'), client_desc_hu
OPTIONS(description='Landesspezifische Bezeichnung des Landes HU'), client_desc_ie
OPTIONS(description='Landesspezifische Bezeichnung des Landes IE'), client_desc_it
OPTIONS(description='Landesspezifische Bezeichnung des Landes IT'), client_desc_lt
OPTIONS(description='Landesspezifische Bezeichnung des Landes LT'), client_desc_lv
OPTIONS(description='Landesspezifische Bezeichnung des Landes LV'), client_desc_ni
OPTIONS(description='Landesspezifische Bezeichnung des Landes NI'), client_desc_nl
OPTIONS(description='Landesspezifische Bezeichnung des Landes NL'), client_desc_de
OPTIONS(description='Landesspezifische Bezeichnung des Landes DE'), client_desc_pl
OPTIONS(description='Landesspezifische Bezeichnung des Landes PL'), client_desc_pt
OPTIONS(description='Landesspezifische Bezeichnung des Landes PT'), client_desc_ro
OPTIONS(description='Landesspezifische Bezeichnung des Landes RO'), client_desc_se
OPTIONS(description='Landesspezifische Bezeichnung des Landes SE'), client_desc_si
OPTIONS(description='Landesspezifische Bezeichnung des Landes SI'), client_desc_sk
OPTIONS(description='Landesspezifische Bezeichnung des Landes SK'), client_desc_cs
OPTIONS(description='Landesspezifische Bezeichnung des Landes CS'), client_desc_mt
OPTIONS(description='Landesspezifische Bezeichnung des Landes MT'), client_desc_us
OPTIONS(description='Landesspezifische Bezeichnung des Landes US'), client_desc_rs
OPTIONS(description='Landesspezifische Bezeichnung des Landes RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE CLIENT/COUNTRY_1 DESCRIPTIONS`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_client_1;