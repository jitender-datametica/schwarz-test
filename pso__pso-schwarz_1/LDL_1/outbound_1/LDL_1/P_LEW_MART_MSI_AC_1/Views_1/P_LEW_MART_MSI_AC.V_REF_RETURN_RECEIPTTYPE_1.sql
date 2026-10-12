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
# 1.11  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.12  04.01.2022    Morris, Michael          Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_return_receipttype_1 (return_receipttype_id
OPTIONS(description='Return_k Bez. Einheit id'), return_receipttype_desc_at
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit AT'), return_receipttype_desc_be
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BE'), return_receipttype_desc_be_fr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BE_FR'), return_receipttype_desc_bg
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BG'), return_receipttype_desc_ch
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CH'), return_receipttype_desc_cy
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CY'), return_receipttype_desc_cz
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CZ'), return_receipttype_desc
OPTIONS(description='Return_k Bez. Einheit desc'), return_receipttype_desc_dk
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit DK'), return_receipttype_desc_ee
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit EE'), return_receipttype_desc_es
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit ES'), return_receipttype_desc_fi
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit FI'), return_receipttype_desc_fr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit FR'), return_receipttype_desc_gb
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit GB'), return_receipttype_desc_gr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit GR'), return_receipttype_desc_hr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit HR'), return_receipttype_desc_hu
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit HU'), return_receipttype_desc_ie
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit IE'), return_receipttype_desc_it
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit IT'), return_receipttype_desc_lt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit LT'), return_receipttype_desc_lv
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit LV'), return_receipttype_desc_ni
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit NI'), return_receipttype_desc_nl
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit NL'), return_receipttype_desc_de
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit DE'), return_receipttype_desc_pl
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit PL'), return_receipttype_desc_pt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit PT'), return_receipttype_desc_ro
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit RO'), return_receipttype_desc_se
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SE'), return_receipttype_desc_si
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SI'), return_receipttype_desc_sk
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SK'), return_receipttype_desc_cs
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CS'), return_receipttype_desc_mt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit MT'), return_receipttype_desc_us
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit US'), return_receipttype_desc_rs
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE RETURN RECEIPT TYPE REFERENCE`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ref_return_receipttype_1;