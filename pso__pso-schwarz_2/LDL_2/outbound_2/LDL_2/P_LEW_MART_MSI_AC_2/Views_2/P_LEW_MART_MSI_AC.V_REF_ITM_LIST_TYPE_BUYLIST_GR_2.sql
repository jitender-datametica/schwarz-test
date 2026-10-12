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
# 1.11  10.08.2020    Roy,Ritanjal             Introduce new country_2 Latviya
# 1.12  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr 
#                                              https://jira.schwarz/browse/REP4-7173
# 1.13  28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_buylist_gr_2 (buying_list_type_group_id
OPTIONS(description='Gruppe_2 der Art_2 des Artikels ( Saison, ... )'), buying_list_type_group_desc_at
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels AT'), buying_list_type_group_desc_be
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE'), buying_list_type_group_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE_FR'), buying_list_type_group_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BG'), buying_list_type_group_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CH'), buying_list_type_group_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CY'), buying_list_type_group_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CZ'), buying_list_type_group_desc
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ( Saison, ... )'),
buying_list_type_group_desc_dk OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DK'),
buying_list_type_group_desc_ee OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels EE'),
buying_list_type_group_desc_es OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ES'),
buying_list_type_group_desc_fi OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FI'),
buying_list_type_group_desc_fr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FR'),
buying_list_type_group_desc_gb OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels GB'),
buying_list_type_group_desc_gr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DG'),
buying_list_type_group_desc_hr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HR'),
buying_list_type_group_desc_hu OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HU'),
buying_list_type_group_desc_ie OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IE'),
buying_list_type_group_desc_it OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IT'),
buying_list_type_group_desc_lt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LT'),
buying_list_type_group_desc_lv OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LV'),
buying_list_type_group_desc_ni OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NI'),
buying_list_type_group_desc_nl OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NL'),
buying_list_type_group_desc_de OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DE'),
buying_list_type_group_desc_pl OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PL'),
buying_list_type_group_desc_pt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PT'),
buying_list_type_group_desc_ro OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RO'),
buying_list_type_group_desc_se OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SE'),
buying_list_type_group_desc_si OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SI'),
buying_list_type_group_desc_sk OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SK'),
buying_list_type_group_desc_cs OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CS'),
buying_list_type_group_desc_mt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels MT'),
buying_list_type_group_desc_us OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels US'),
buying_list_type_group_desc_rs OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RS_2'))
OPTIONS(DESCRIPTION = `MULTISPRACHE GRUPPEN DER ARTIKELARTEN REFERENZ`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_itm_list_type_buylist_gr_2;