/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_PSA_MWST
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  06.03.2023    Bialek, Aleksander           filtering for UWg extended to cover also newly added UWGs (between 200 and 399), ADO: 448371, it4you:PRJ0015189
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_psa_mwst (client_id, dat_adv, orig_item_nr, wh_id, dat_valid_from, mwst) AS
SELECT ADV.client_id,
 ADV.dat_adv,
 I.orig_item_nr,
 ADV.wh_id,
 I.valid_from AS dat_valid_from,
 VAT.pct_vat AS mwst
FROM ldl_p_lew_mart_cs.v_gen_vat_hist AS VAT
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis AS I ON VAT.client_id = I.client_id AND VAT.vat_id = I.vat_id
 INNER JOIN ldl_p_lew_bil_ac.v_adv_orig_item_advertising AS ADV ON I.client_id = ADV.client_id
    /* AND i.dat_valid_from = adv.dat_valid_from */ AND I.orig_item_nr = ADV.orig_item_nr AND ADV.dat_adv BETWEEN VAT.dat_rec_start
   AND VAT.dat_rec_end
WHERE I.subitemgroup_id BETWEEN 100 AND 399
 AND VAT.vat_id >= 0
 AND VAT.language_id = 7
GROUP BY ADV.client_id,
 ADV.dat_adv,
 I.orig_item_nr,
 ADV.wh_id,
 dat_valid_from,
 mwst;