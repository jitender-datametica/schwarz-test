/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_ITEM_LOC_SFO_PARTIAL_WRITEOFF_PRC_CHNG_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                 Generiert aus Teradata
#  1.1  19.09.2017    U.Meister         renamed loc_sid to loc_sid_store
#  1.2  17.10.2017    Arnold,Arne       Objekt STORE_TO_WAREHOUSE auf DWH_ACTUAL_FG = 1 eingeschraenkt, da ansonsten Dubletten entstehen.
#  1.3  27.10.2017    Webster,Stuart    Object STORE_TO_WAREHOSUE filterd join on ACTIVE_FG
#  1.4  14.11.2017    Mustafa Sahin     Join to v_client_config_1 changed
#  1.5  15.11.2017    Wieber,Harald     Release 1.1
#  1.6  16.11.2017    Wieber,Harald     Relese 1.1 v2
#  1.7  20.11.2017    Wieber,Harald     Set CommentString to max length 255
#  1.8  20.11.2017    Wieber,Harald     Set CommentString to max length 255
#  1.9  20.11.2017    Wieber,Harald     Set CommentString to max length 255 (Fix 3)
#  1.1  20.11.2017    Wieber,Harald     Correct SVN File
# 1.11  05.12.2017    Meister,Ulrich    loc_sid replacement to use the loc_sid of a pseudo store instaed of the loc_sid of the warehouse
# 1.12  07.02.2018    Thole,Jens        V_ORG_STORE_SKEY_1 eliminiert und durch einfachen Join auf V_LOCATION_1 ersetzt. Test_1 mit Altversion ergab Identitaet.
# 1.13  28.02.2018    Taubkin, Slavik   Umstellung auf last_known Views
# 1.14  02.03.2018    Meister,Ulrich    Spaltenkommentare wieder hinzugefuegt
# 1.16  18.04.2018    Ulrich Meister    deactivate adjustment of quantities to SI entities
# 1.17  25.04.2018    Ulrich Meister    store price now taken from the original loc_sid, not from the mapped loc_sid (in case of wh-writeoffs)
# 1.18  02.07.2018    Michael Ueding    Ermittlung WH Preis angepasst (Empfehlung von TGO)
# 1.19  03.07.2018    Michael Ueding    Korrektur Datenbankreferenz.
# 2.00  26.10.2018    Michael Strauch   correction mapping of sfo_type_cd and pcwo_reason_id - a mapping of sfo_type_cd 137 with pcwo_reason_id 43 have to be avoided --> it does not exist
#                                       LEAD-6415 / LEAD-5955 / IDMO-1192
# 2.01  30.12.2020    Michal Malinowski 20201214_2691_Frischfish_adjustments, REP3-7935
#                                       FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
# 2.02  19.02.2021    Prasanna Ranjan   REP2-9080 - Include item_1 types ZKM and ZVM from USA and Serbia
# 2.03  14.09.2021    Marcin Malec      REP2-10349 - Rollback of REP2-9080 (should not apply for pv, writeoff, only sales_1)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_LOC_SFO_PARTIAL_WRITEOFF_PRC_CHNG_1 COMMENT = 'View'
(
    client_id                                   COMMENT 'Landeskennzeichen'
    ,loc_sid_store                              COMMENT 'enthaelt surrogate Key des Stores'
    ,src_orig_store_nr                          COMMENT 'WAWI Quellsystemschluessel Filiale'
    ,loc_sid_wh                                 COMMENT 'Warehouse - Eindeutige Identifizierung einer Lokation ueber alle Mandanten/Laender'
    ,orig_wh_nr                                 COMMENT 'Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH)'
    ,item_sid                                   COMMENT 'Surrogate Key Item_1'
    ,retail_sales_record_id                     COMMENT 'Fakturaposition; SAP-Retail: vbrp.POSNR; SAP-BW: t_bw_2lis_13_vditm.POSNR'
    ,retail_sales_record_pos_id                 COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: vbrp.MATNR; SAP-BW: t_bw_2lis_13_vditm.MATNR'
    ,booking_dat                                COMMENT 'MHD Pruefung beim Wareneingang bereits vorhanden'
    ,booking_month                              COMMENT 'Monat_1 Buchungsdatum Artikelbeleg'
    ,map_use_cd                                 COMMENT 'Default Wert = 4'
    ,sig_nr                                     COMMENT 'Subitemgroup / WAWI CD'
    ,itm_mov_record_yr                          COMMENT 'Default mit NULL Werte -Spalte wird in Abinitio verwendet'
    ,numerator_conv_si                          COMMENT 'Zaehler zur Umrechnung in SI-Einheit; SAP-Retail: T006.ZAEHL'
    ,denominator_conv_si                        COMMENT 'Nenner zur Umrechnung in SI-Einheit; SAP-Retail: T006.NENNR'
    ,qty                                        COMMENT 'Verkaufsmenge in Lagermengeneinheit; SAP-Retail: vbrp.FKLMG; SAP-BW: t_bw_2lis_13_vditm.fklmg; eLWIS: t_s_retail_sales_record_pos.qty_lme'
    ,company_sid                                COMMENT 'Buchungskreis'
    ,itmgrp_id                                  COMMENT 'Artikel_1 Group ID'
    ,sfo_total_si_qty                           COMMENT 'Menge (ggf. umgerechnet in SI Mengeneinheit)'
    ,sfo_total_qty                              COMMENT 'Menge (in Erfassungsmengeneinheit, nicht umgerechnet in SI Mengeneinheit)'
    ,foodaction_fg                              COMMENT 'Foodactionflag'
    ,sfo_wrtoff_zero_qty                        COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,sfo_wrtoff_zero_rtl_rl_val                 COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,sfo_wrtoff_zero_rtl_rl_net_val             COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,itm_mov_record_id                          COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,itm_mov_record_pos_id                      COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,val_pr_diff_sfo                            COMMENT 'Val_Pr_k Bez. Einheit sfo'
    ,val_pr_diff_net_sfo                        COMMENT 'Default mit NULL Werte'
    ,sfo_total_wh_val                           COMMENT 'GROSS price warehouse * qty'
    ,sfo_total_wh_net_val                       COMMENT 'NET price warehouse * qty'
    ,sfo_total_store_val                        COMMENT 'GROSS price store * qty'
    ,sfo_total_store_net_val                    COMMENT 'NET price store * qty'
    ,sfo_type_cd                                COMMENT 'Sfo Typen'
    ,sfo_total_rtl_rl_val                       COMMENT 'GROSS final SFO amount mapped, according to column sfo_type_cd'
    ,sfo_total_rtl_rl_net_val                   COMMENT 'NET final SFO amount mapped, according to column sfo_type_cd'
    ,gross_val                                  COMMENT 'GROSS final SFO amount mapped, according to column sfo_type_cd'
    ,net_val                                    COMMENT 'Nettopreis Normal Filiale'
    ,sfo_total_asis_fa_qty                      COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann  sfo_total_qty  ansonsten 0'
    ,sfo_wrtoff_zero_asis_fa_qty                COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'
    ,sfo_total_rtl_rl_asis_fa_val               COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0'
    ,sfo_total_rtl_rl_net_asis_fa_val           COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0'
    ,sfo_wrtoff_zero_rtl_rl_asis_fa_val         COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'
    ,sfo_wrtoff_zero_rtl_rl_net_asis_fa_val     COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'
    ,sfo_total_fa_qty                           COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann  sfo_total_qty  ansonsten 0'
    ,sfo_wrtoff_zero_fa_qty                     COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'
    ,sfo_total_rtl_rl_fa_val                    COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0'
    ,sfo_total_rtl_rl_net_fa_val                COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0'
    ,sfo_wrtoff_zero_rtl_rl_fa_val              COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'
    ,sfo_wrtoff_zero_rtl_rl_net_fa_val          COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'
    ,pcwo_reason_id                             COMMENT 'Eindeutige ID des Abschriften_1- bzw. PV-Grundes. Landesspezifische Abschriftengruende haben ID > 100.'
)

AS

SELECT
       basis.client_id
      ,basis.loc_sid_store
      ,basis.src_orig_store_nr
      ,basis.loc_sid_wh
      ,basis.orig_wh_nr
      ,basis.item_sid
      ,basis.retail_sales_record_id
      ,basis.retail_sales_record_pos_id
      ,booking_dat
      ,TO_NUMBER(to_char(booking_dat,'YYYYMM')) AS booking_month
      ,basis.map_use_cd
      ,basis.sig_nr
      ,basis.itm_mov_record_yr

      ,basis.numerator_conv_si
      ,basis.denominator_conv_si
      ,basis.qty
      ,basis.company_sid
      ,basis.itmgrp_id
      ,(basis.qty * basis.numerator_conv_si/basis.denominator_conv_si) AS  sfo_total_si_qty
      ,basis.qty AS  sfo_total_qty
      ,basis.foodaction_fg

      ,0 AS sfo_wrtoff_zero_qty
      ,0 AS sfo_wrtoff_zero_rtl_rl_val
      ,0 AS sfo_wrtoff_zero_rtl_rl_net_val
      ,0 AS itm_mov_record_id
      ,0 AS itm_mov_record_pos_id
      ,val_pr_diff_sfo
      ,val_pr_diff_net_sfo

      ,(basis.price_act_wh * basis.qty)             AS sfo_total_wh_val
      ,(basis.price_act_wh_net * basis.qty) AS sfo_total_wh_net_val
      ,(basis.price_str_dir_del * basis.qty)       AS sfo_total_store_val
      ,(basis.price_str_net_dir_del * basis.qty) AS sfo_total_store_net_val
      ,basis.sfo_type_cd
      ,basis.sfo_amt AS sfo_total_rtl_rl_val
      ,basis.sfo_amt_net AS sfo_total_rtl_rl_net_val
      ,basis.sfo_amt AS gross_val
      ,basis.sfo_amt_net AS net_val

      /* Spalten fuer Aggregation Agg: t_a_sfo_wh_day_itm_asis/ t_a_sfo_store_day_sig_asis */
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_qty ELSE 0 END sfo_total_asis_fa_qty
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_qty ELSE 0 END sfo_wrtoff_zero_asis_fa_qty
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_rtl_rl_val ELSE 0 END sfo_total_rtl_rl_asis_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_rtl_rl_net_val ELSE 0 END sfo_total_rtl_rl_net_asis_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_rtl_rl_val ELSE 0 END sfo_wrtoff_zero_rtl_rl_asis_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_rtl_rl_net_val ELSE 0 END sfo_wrtoff_zero_rtl_rl_net_asis_fa_val

      /* Spalten fuer Aggregation Agg: t_a_sfo_store_day */
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_qty ELSE 0 END sfo_total_fa_qty
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_qty ELSE 0 END sfo_wrtoff_zero_fa_qty
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_rtl_rl_val ELSE 0 END sfo_total_rtl_rl_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_total_rtl_rl_net_val ELSE 0 END sfo_total_rtl_rl_net_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_rtl_rl_val ELSE 0 END sfo_wrtoff_zero_rtl_rl_fa_val
      ,CASE WHEN basis.foodaction_fg = 1 THEN  sfo_wrtoff_zero_rtl_rl_net_val ELSE 0 END sfo_wrtoff_zero_rtl_rl_net_fa_val

      /* benoetigt fuer Basisaggregat */
      ,basis.pcwo_reason_id
FROM
(
  SELECT
         h.client_id
        ,h.loc_sid_store
        ,loc.src_orig_store_nr
        ,loc.global_loc_id
        ,w.loc_sid_wh
        ,h.item_sid
        ,h.dwh_cal_dt AS booking_dat
         /*Falls kein ZVKP_1 vorhanden ist wird der Preis 0 verwendet*/
        ,COALESCE(clk.cond_val_calc, 0) AS gross_prcs_vk
        ,COALESCE(clk.net_val_calc, 0) AS net_prcs_vk
        ,COALESCE(clk.cond_val_eff_calc, 0.000) * h.qty_act AS val_rtl_rl_del
        ,COALESCE(clk.net_val_eff_calc, 0.000) * h.qty_act AS val_rtl_rl_net_del
        ,'' AS itm_mov_type_cd
         /*Teilabschriften aus der Faktura und den Faktura Konditionen*/
        ,4 AS map_use_cd
        ,COALESCE(igi.src_subitemgrp_cd, -1) AS sig_nr
        ,0  AS itm_mov_record_yr
        ,h.retail_sales_record_id
        ,h.retail_sales_record_pos_id
        ,w.src_wh_id AS orig_wh_nr
        ,COALESCE(d.numerator_conv_si, 1) AS numerator_conv_si
        ,COALESCE(d.denominator_conv_si, 1) AS denominator_conv_si
         /* Menge in Basismenge (Im  Gegensatz zur Menge in VK_1 Mengenheit bei der Bewertung) */
        ,h.qty_stock_unit *(-1)                          AS qty
        ,0                                               AS company_sid
        ,NULL                                            AS deb_cred_cd
        ,item_group.src_matkl AS itmgrp_id
         /*VK_1 Bewertung aus Sales_1 Price fuer zugeordnetes WH*/
        ,cwk.cond_val_eff_calc     AS price_act_wh
         /*15.09.2016 added net column and mapped to source net column */
        ,cwk.net_val_eff_calc          AS price_act_wh_net
         /*VK_1 Bewertung aus Sales_1 Price fuer Filiale */
        ,COALESCE(clk.cond_val_eff_calc, 0.000)        AS price_str_dir_del
        ,COALESCE(clk.net_val_eff_calc, 0.000)          AS price_str_net_dir_del
         /* Gesamtabweichung Brutto/Netto
            Kalkulation fuer Laender die Netto ausgewiesen werden*/
        ,CASE WHEN cntry.sales_gross_fg = 1
              THEN /* GROSS country_1*/
                  (h.net_val + h.tax_val) - (gross_prcs_vk * h.qty_act)
              ELSE /* NET country_1, gross und net spalten*/
                  (h.net_val) - (net_prcs_vk * h.qty_act)
         END                                     AS diff_amt
         /* Gesamtabweichung Netto
            Kalkulation von Brutto (diff_amt) */
        ,CASE WHEN cntry.sales_gross_fg = 1
              THEN /* GROSS country_1*/
                  diff_amt * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc)
              ELSE
                   (h.net_val) - (net_prcs_vk * h.qty_act)
              END                                     AS diff_amt_net
         /* Teilbetraege aufgrund Aktion_1 */
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'A001'
              THEN (clk.cond_val_adv_calc - gross_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_a001
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'A001'
              THEN (clk.net_val_adv_calc - net_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_net_a001
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02'
              THEN (clk.cond_val_adv_calc - gross_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_pv02
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02'
              THEN (clk.net_val_adv_calc - net_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_net_pv02
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04'
              THEN (clk.cond_val_adv_calc - gross_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_pv04
        ,CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04'
              THEN (clk.net_val_adv_calc - net_prcs_vk) * h.qty_act
              ELSE NULL
         END                                           AS sfo_amt_net_pv04
         /* Teilbetraege aufgrund Fakturakonditionen */
        ,CASE WHEN h.zrb1_fg = 1
              THEN h.amt_zrb1
              ELSE NULL
         END                                           AS sfo_amt_zrb1
        ,CASE WHEN h.zrb1_fg = 1
              THEN (h.amt_zrb1 * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc))
              ELSE NULL
         END                                           AS sfo_amt_net_zrb1
        ,CASE WHEN h.zrb2_fg = 1
              THEN h.amt_zrb2
              ELSE NULL
         END                                           AS sfo_amt_zrb2
        ,CASE WHEN h.zrb2_fg = 1
              THEN (h.amt_zrb2 * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc))
              ELSE NULL
         END                                          AS sfo_amt_net_zrb2
        ,CASE WHEN h.zrb3_fg = 1
              THEN h.amt_zrb3
              ELSE NULL
         END                                           AS sfo_amt_zrb3
        ,CASE WHEN h.zrb3_fg = 1
              THEN (h.amt_zrb3 * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc))
              ELSE NULL
         END                                           AS sfo_amt_net_zrb3
        ,CASE WHEN h.zrb4_fg = 1
              THEN h.amt_zrb4
              ELSE NULL
         END                                           AS sfo_amt_zrb4
        ,CASE WHEN h.zrb4_fg = 1
              THEN (h.amt_zrb4 * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc))
              ELSE NULL
         END                                           AS sfo_amt_net_zrb4
        ,CASE WHEN h.zrb5_fg = 1
              THEN h.amt_zrb5
              ELSE NULL
         END                                           AS sfo_amt_zrb5
        ,CASE WHEN h.zrb5_fg = 1
               THEN (h.amt_zrb5 * 100 / (NullIfZero(TO_NUMBER(100, 19, 5)) + clk.tax_rate_calc))
               ELSE NULL
         END                                           AS sfo_amt_net_zrb5
         /* Ermittlung nicht zuordenbarer Betrag */
        ,diff_amt - COALESCE(sfo_amt_zrb1, 0)
                  - COALESCE(sfo_amt_zrb2, 0)
                  - COALESCE(sfo_amt_zrb3, 0)
                  - COALESCE(sfo_amt_zrb4, 0)
                  - COALESCE(sfo_amt_zrb5, 0)
                  - COALESCE(sfo_amt_a001, 0)
                  - COALESCE(sfo_amt_pv02, 0)
                  - COALESCE(sfo_amt_pv04, 0)
         +
         (
           0 * CASE WHEN clk.cond_val_adv_calc IS NOT NULL AND clk.reason_price_modifi_adv_calc IS NULL
                    THEN NULL
                    ELSE 1
               END
         )                                             AS sfo_amt_fbo
         /* Ermittlung nicht zuordenbarer Betrag Netto*/
        ,diff_amt_net - COALESCE(sfo_amt_net_zrb1, 0)
                      - COALESCE(sfo_amt_net_zrb2, 0)
                      - COALESCE(sfo_amt_net_zrb3, 0)
                      - COALESCE(sfo_amt_net_zrb4, 0)
                      - COALESCE(sfo_amt_net_zrb5, 0)
                      - COALESCE(sfo_amt_net_a001, 0)
                      - COALESCE(sfo_amt_net_pv02, 0)
                      - COALESCE(sfo_amt_net_pv04, 0)

         + (0 * sfo_amt_fbo)                           AS sfo_amt_net_fbo
         /* SUMmierung Teilbetraege Teilabschrift Filiale */
        ,CASE WHEN sfo_amt_zrb1 IS NOT NULL
                   OR sfo_amt_zrb3 IS NOT NULL
                   OR sfo_amt_pv02 IS NOT NULL
                   OR sfo_amt_fbo IS NOT NULL
              THEN COALESCE(sfo_amt_zrb1, 0)
                   + COALESCE(sfo_amt_zrb3, 0)
                   + COALESCE(sfo_amt_pv02, 0)
                   + COALESCE(sfo_amt_fbo, 0)
              ELSE 0
         END                                           AS sfo_amt_137
         /* SUMmierung Teilbetraege Teilabschrift Filiale Netto*/
        ,CASE WHEN sfo_amt_net_zrb1 IS NOT NULL
                   OR sfo_amt_net_zrb3  IS NOT NULL
                   OR sfo_amt_net_pv02  IS NOT NULL
                   OR sfo_amt_net_fbo   IS NOT NULL
              THEN COALESCE(sfo_amt_net_zrb1, 0)
                   + COALESCE(sfo_amt_net_zrb3, 0)
                   + COALESCE(sfo_amt_net_pv02, 0)
                   + COALESCE(sfo_amt_net_fbo, 0)
              ELSE 0
         END                                           AS sfo_amt_net_137
         /*SUMmierung Teilbetraege Preisveraenderung Filiale */
        ,CASE WHEN sfo_amt_zrb2 IS NOT NULL
                   OR sfo_amt_zrb4 IS NOT NULL
                   OR sfo_amt_zrb5 IS NOT NULL
                   OR sfo_amt_a001 IS NOT NULL
                   OR sfo_amt_pv04 IS NOT NULL
              THEN COALESCE(sfo_amt_zrb2, 0)
                   + COALESCE(sfo_amt_zrb4, 0)
                   + COALESCE(sfo_amt_zrb5, 0)
                   + COALESCE(sfo_amt_a001, 0)
                   + COALESCE(sfo_amt_pv04, 0)
              ELSE 0
         END                                           AS sfo_amt_134
         /*SUMmierung Teilbetraege Preisveraenderung Filiale Netto*/
        ,CASE WHEN sfo_amt_net_zrb2 IS NOT NULL
                   OR sfo_amt_net_zrb4 IS NOT NULL
                   OR sfo_amt_net_zrb5 IS NOT NULL
                   OR sfo_amt_net_a001 IS NOT NULL
                   OR sfo_amt_net_pv04 IS NOT NULL
              THEN COALESCE(sfo_amt_net_zrb2, 0)
                   + COALESCE(sfo_amt_net_zrb4, 0)
                   + COALESCE(sfo_amt_net_zrb5, 0)
                   + COALESCE(sfo_amt_net_a001, 0)
                   + COALESCE(sfo_amt_net_pv04, 0)
              ELSE 0
          END                                           AS sfo_amt_net_134
         /* Ermittlung SFO Type */
        ,CASE /* BDO-2188 */
              WHEN cal.faecher = 1
              THEN '134'
              ELSE '137'
         END                                           AS sfo_type_cd
         /* Selektion SFO Betrag */
        ,CASE /* BDO-2188 */
              WHEN cal.faecher = 1
              THEN sfo_amt_134
              ELSE sfo_amt_137
         END                                           AS sfo_amt
         /* Selektion SFO Betrag Netto*/
        ,CASE /* BDO-2188 */
              WHEN cal.faecher = 1
              THEN sfo_amt_net_134
              ELSE sfo_amt_net_137
         END                                           AS sfo_amt_net
         /* abgestimmte Logik in allen Aggregate-Views */
        ,CASE
              WHEN fa.client_id IS NOT NULL
              THEN 1
              ELSE 0
         END                                           AS foodaction_fg
         /*Defintion Ermittlung PCWO Mapping nach Vorgabe Hr. Massa (08/2016)*/
        ,CASE WHEN sfo_amt_a001 IS NOT NULL
                OR sfo_amt_zrb2 IS NOT NULL
                OR sfo_amt_zrb5 IS NOT NULL THEN 41
              WHEN sfo_type_cd <> 137  /*the mapping of sfo_type 137 with the pcwo_reason_cd 43 does not exists - therefore the reason_id has to be set to next codes*/
               AND (sfo_amt_pv04 IS NOT NULL
               OR   sfo_amt_zrb4 IS NOT NULL ) THEN 43 
              WHEN sfo_amt_pv02 IS NOT NULL
                OR sfo_amt_zrb3 IS NOT NULL
                OR (sfo_amt_zrb1 IS NOT NULL AND igi.src_itemgrp_int_cd IN ( 7, 70 )) THEN 6
              WHEN sfo_amt_fbo IS NOT NULL
                OR (sfo_amt_zrb1 IS NOT NULL AND igi.src_itemgrp_int_cd NOT IN ( 7, 70 ) ) THEN 5
              ELSE NULL
         END                                           AS pcwo_reason_id
         /* Spezifikation im Net-DB_technical-specification chapter 11.4.2 */
        ,TO_NUMBER(NULL, 18, 4) AS val_pr_diff_sfo
         /* Spezifikation im Net-DB_technical-specification chapter 11.4.2 */
        ,TO_NUMBER(NULL, 19, 5) AS val_pr_diff_net_sfo
          /* Faktura Positionen und die Zugehoerigen Konditionen werden    */
          /* in einer derived table zunaechst verjoined und aggregiert     */
          /* Dies ist notwendig, um korrekte Ergebnisse in der spaeteren   */
          /* Berechnung pro Position zu erhalten                          */
          /* Der Join in derived table soll bessere Partition ermoeglichen */
  FROM
  (
    SELECT
           k.client_id
          ,p.retail_sales_record_id
          ,p.retail_sales_record_pos_id
          ,k.dwh_cal_dt
          ,k.invoice_class_cd
          ,p.item_sid
          ,p.loc_sid
          ,COALESCE(lm.loc_sid_store,p.loc_sid) loc_sid_store
          ,p.uom_sid
          ,p.qty_stock_unit
          ,p.net_val
          ,p.tax_val
          ,p.qty_act
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZRB1'
                  THEN c.cond_val
                  ELSE 0
             END
           ) AS amt_zrb1
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZRB2'
                  THEN c.cond_val
                  ELSE 0
             END
           ) AS amt_zrb2
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZRB3'
                  THEN c.cond_val
                  ELSE 0
             END
           ) AS amt_zrb3
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZRB4'
                  THEN c.cond_val
                  ELSE 0
              END
           ) AS amt_zrb4
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZRB5'
                  THEN c.cond_val
                  ELSE 0
              END
           ) AS amt_zrb5
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZPRP'
                  THEN c.cond_val
                  ELSE 0
             END
           ) AS amt_zprp
          ,SUM
           (
             CASE WHEN c.cond_type_cd = 'ZPRA'
                  THEN c.cond_val
                  ELSE 0
             END
           ) AS amt_zpra
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZRB1'
                  THEN 1
                  ELSE 0
             END
           ) AS zrb1_fg
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZRB2'
                  THEN 1
                  ELSE 0
             END
           ) AS zrb2_fg
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZRB3'
                  THEN 1
                  ELSE 0
             END
           ) AS zrb3_fg
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZRB4'
                  THEN 1
                  ELSE 0
             END
           ) AS zrb4_fg
          ,MAX
           (
              CASE WHEN c.cond_type_cd = 'ZRB5'
                   THEN 1
                   ELSE 0
               END
           ) AS zrb5_fg
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZPRP'
                  THEN 1
                  ELSE 0
             END
           ) AS zprp_fg
          ,MAX
           (
             CASE WHEN c.cond_type_cd = 'ZPRA'
                  THEN 1
                  ELSE 0
             END
           ) AS zpra_fg
    FROM P_LEW_CORE_AC.v_retail_sales_record_1   k

    INNER JOIN P_LEW_CORE_AC.v_retail_sales_record_pos_1 p
    ON k.client_id = p.client_id
      AND k.retail_sales_record_id = p.retail_sales_record_id
      AND k.dwh_cal_dt= p.dwh_cal_dt

    LEFT OUTER JOIN
     ( /*Dies scheinen Warhouse-Locations zu sein die eine_1 ORIG_WH_ID haben, die gleichzeitig auch als ORIG_STORE_NR vorkommt und dementsprechend uebersetzt werden sollen*/
      SELECT
             wh.loc_sid
            ,wh.client_id
            ,st.loc_sid loc_sid_store
      FROM P_LEW_CORE_AC.v_location_1 wh /* warehouses */
      /* Suche alle Locations deren ORIG.Store_Nr mit den WH_IDs der selektierten WH-Zeilen uebereinstimmen */

      INNER JOIN P_LEW_CORE_AC.v_location_1 st
          ON wh.src_wh_id=st.src_orig_store_nr
             AND wh.client_id=st.client_id
      ) lm
      ON p.loc_sid=lm.loc_sid
        AND p.client_id = lm.client_id

     /* Konditionsart ZRB1, ZRB2, ZBR3, ZRB4, ZPRP und ZPRA aus Fakturakonditionen  */
    LEFT OUTER JOIN P_LEW_CORE_AC.v_retail_sales_record_pos_cond_1  c
    ON p.client_id = c.client_id
      AND p.retail_sales_record_id = c.retail_sales_record_id
      AND p.retail_sales_record_pos_id = c.retail_sales_record_pos_id
      AND p.dwh_cal_dt = c.dwh_cal_dt
      AND c.cond_type_cd IN ('ZRB1', 'ZRB2', 'ZRB3', 'ZRB4', 'ZRB5','ZPRP', 'ZPRA')

    GROUP BY
             k.client_id
            ,p.retail_sales_record_id
            ,p.retail_sales_record_pos_id
            ,k.dwh_cal_dt
            ,k.invoice_class_cd
            ,p.item_sid
            ,p.loc_sid
            ,COALESCE(lm.loc_sid_store,p.loc_sid)
            ,p.uom_sid
            ,p.qty_stock_unit
            ,p.net_val
            ,p.tax_val
            ,p.qty_act
  ) h

  /* Details zum Artikel_1 */
  INNER JOIN P_LEW_CORE_AC.v_item_hist_1 item_1
  ON h.client_id = item.client_id
    AND h.item_sid = item.item_sid
    AND CURRENT_DATE BETWEEN item.dwh_valid_from AND item.dwh_valid_to

  /*Referenz zu Artikelart zur Filterung der Artikelarten*/
  INNER JOIN P_LEW_CORE_AC.v_item_group_1 item_group
  ON item.client_id = item_group.client_id
    AND item.item_grp_sid = item_group.item_grp_sid

  /* Details zum Artikel_1 Art_1*/
  INNER JOIN P_LEW_CORE_AC.v_item_type_1 item_type
  ON item.client_id = item_type.client_id
    AND item.item_type_sid = item_type.item_type_sid

  /* Zu ignorierende Artikelarten */
  LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore_1 ig
  ON item_type.client_id = ig.client_id
    AND item_type.src_mtart = ig.item_type_cd
    AND ig.item_type_grp_cd IN ('BAGLEVY', 'ADJ')

  /* Filterung von TestFilialen und Vorlage-Filialen */
  INNER JOIN P_LEW_BIL.v_store_1 loc
  ON h.client_id = loc.client_id
    AND h.loc_sid_store = loc.loc_sid_store
    AND CURRENT_DATE BETWEEN loc.dwh_valid_from AND loc.dwh_valid_to

  /*Ermittlung WH zu Store*/
  INNER JOIN P_LEW_BIL.v_store_to_warehouse_lastknown_1 AS w
  ON h.client_id = w.client_id
    AND h.loc_sid_store = w.loc_sid_store

  /* Mapping cntry process table for NET/GROSS country_1 information */
  LEFT OUTER JOIN P_LEW_PROCESS_AC.v_client_config_1 cntry
  ON h.client_id = cntry.client_id

  /* Details zum Umrechnungsfaktor */
  LEFT OUTER JOIN  P_LEW_CORE_AC.v_unit_of_measurement_1 d
  ON h.uom_sid = d.uom_sid

  /* VK_1 Preisermittlung Filial - Bestellkopfartikel, Filiale Datum */
  INNER JOIN P_LEW_BIL.v_item_loc_sales_cond_denorm_1 clk
  /*Normal VK_1  muss zwingend vorhanden sein */
  ON h.client_id = clk.client_id
    AND h.item_sid = clk.item_sid
    AND h.loc_sid = clk.loc_sid
    AND h.uom_sid = clk.uom_sid_cond
    AND h.dwh_cal_dt BETWEEN clk.dwh_valid_from AND clk.dwh_valid_to

  /*  VK_1 Preisermittlung Niederlassung -Bestellkopfartikel, Niederlassung Datum */
  LEFT OUTER JOIN
  (
    /* select only warehouse price conditions from the denorm table */
    SELECT  
           d.client_id
          ,d.item_sid
          ,d.loc_sid
          ,d.uom_sid_cond
          ,d.dwh_valid_from 
          ,d.dwh_valid_to
          ,d.net_val_eff_calc
          ,d.cond_val_eff_calc
    FROM P_LEW_BIL.v_item_loc_sales_cond_denorm_1 AS d
 
    
INNER JOIN P_LEW_CORE_AC.v_location_1 wh ON
wh.client_id = d.client_id
AND wh.loc_sid = d.loc_sid
AND UPPER(wh.wh_store_mark) = 'B' /* Warehouse */
) cwk ON
h.client_id = cwk.client_id
AND h.item_sid = cwk.item_sid
AND w.loc_sid_wh = cwk.loc_sid
AND h.uom_sid = cwk.uom_sid_cond
AND h.dwh_cal_dt BETWEEN cwk.dwh_valid_from AND cwk.dwh_valid_to

  /* Details zur Artikel_1 Hierarchie */
  INNER JOIN P_LEW_BIL.v_item_hierarchy_1 igi
  ON item.item_sid  = igi.item_sid
    AND item.client_id = igi.client_id

  /* Dummy_1 um bei Vorhandensein von 137 UND 134 ggf. die Zeile aufzufaechern */

  INNER JOIN
  (
    SELECT
    RANK() OVER (ORDER BY cal_dt) AS faecher
    FROM p_lew_core_ac.v_cal_calendarday_1
    WHERE cal_dt BETWEEN CURRENT_DATE -1 AND CURRENT_DATE
) cal
ON (faecher = 1 AND 
                   (
                        CASE WHEN 
                                (
                                    CASE WHEN h.zrb2_fg = 1
                                         THEN h.amt_zrb2
                                         ELSE NULL
                                    END 
                                ) IS NOT NULL
                                
                               OR 
                                (
                                    CASE WHEN h.zrb4_fg = 1
                                         THEN h.amt_zrb4
                                         ELSE NULL
                                    END
                                ) IS NOT NULL
                                
                               OR 
                                (
                                    CASE WHEN h.zrb5_fg = 1
                                         THEN h.amt_zrb5
                                         ELSE NULL
                                    END
                                ) IS NOT NULL
                                
                               OR 
                                (
                                    CASE WHEN clk.reason_price_modifi_adv_calc = 'A001'
                                         THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                         ELSE NULL
                                    END
                                ) IS NOT NULL
                                
                               OR 
                                (
                                    CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04'
                                         THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                         ELSE NULL
                                    END
                                ) IS NOT NULL
                            
                            THEN COALESCE
                                        (
                                            CASE WHEN h.zrb2_fg = 1
                                                 THEN h.amt_zrb2
                                                 ELSE NULL
                                            END, 0
                                        )
                            
                              + COALESCE
                                       (
                                            CASE WHEN h.zrb4_fg = 1
                                                 THEN h.amt_zrb4
                                                 ELSE NULL
                                            END , 0
                                       )
                            
                              + COALESCE
                                       (
                                            CASE WHEN h.zrb5_fg = 1
                                                 THEN h.amt_zrb5
                                                 ELSE NULL
                                            END, 0
                                       )
                            
                              + COALESCE
                                       (
                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'A001'
                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                                 ELSE NULL
                                            END, 0
                                       )
                            
                              + COALESCE
                                       (
                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04'
                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                                 ELSE NULL
                                            END, 0
                                       )
                            ELSE 0
                        END
                    ) <> 0
    )
OR (faecher = 2 AND 
                    (
                        CASE WHEN 
                                (
                                    CASE WHEN h.zrb1_fg = 1
                                        THEN h.amt_zrb1
                                        ELSE NULL
                                    END 
                                ) IS NOT NULL
                                    
                            OR 
                                (
                                    CASE WHEN h.zrb3_fg = 1
                                        THEN h.amt_zrb3
                                        ELSE NULL
                                    END 
                                ) IS NOT NULL
                            OR 
                                (
                                    CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02'
                                        THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                        ELSE NULL
                                    END
                                ) IS NOT NULL
                                
                            OR 
                                (
                                    (
                                        CASE WHEN cntry.sales_gross_fg = 1
                                            THEN (h.net_val + h.tax_val) - (COALESCE(clk.cond_val_calc, 0) * h.qty_act)
                                            ELSE (h.net_val) - (COALESCE(clk.net_val_calc, 0) * h.qty_act)
                                        END
                                    )    
                                    - COALESCE
                                            (
                                                CASE WHEN h.zrb1_fg = 1
                                                     THEN h.amt_zrb1
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN h.zrb2_fg = 1
                                                     THEN h.amt_zrb2
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN h.zrb3_fg = 1
                                                     THEN h.amt_zrb3
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN h.zrb4_fg = 1
                                                     THEN h.amt_zrb4
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN h.zrb5_fg = 1
                                                     THEN h.amt_zrb5
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN clk.reason_price_modifi_adv_calc = 'A001'
                                                     THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02'
                                                     THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act
                                                     ELSE NULL
                                                END, 0
                                            )
                                            
                                    - COALESCE
                                            (
                                                CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04' 
                                                     THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act  
                                                     ELSE NULL  
                                                END, 0
                                            )   
                                    +   
                                            (   
                                            0 * CASE WHEN clk.cond_val_adv_calc IS NOT NULL AND clk.reason_price_modifi_adv_calc IS NULL    
                                                     THEN NULL  
                                                     ELSE 1 
                                                END 
                                            )
                                ) IS NOT NULL   
                                
                            THEN COALESCE
                                        (
                                            CASE WHEN h.zrb1_fg = 1 
                                                 THEN h.amt_zrb1    
                                                 ELSE NULL  
                                            END, 0
                                        )
                                        
                                + COALESCE
                                        (
                                            CASE WHEN h.zrb3_fg = 1 
                                                 THEN h.amt_zrb3    
                                                 ELSE NULL  
                                            END, 0
                                        )
                                        
                                + COALESCE
                                        (
                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02' 
                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act  
                                                 ELSE NULL  
                                            END, 0
                                        )   
                                + COALESCE
                                        (
                                            (
                                                (
                                                    CASE WHEN cntry.sales_gross_fg = 1  
                                                        THEN(h.net_val + h.tax_val) - (COALESCE(clk.cond_val_calc, 0) * h.qty_act)  
                                                        ELSE(h.net_val) - (COALESCE(clk.net_val_calc, 0) * h.qty_act)   
                                                    END
                                                )  
                                                
                                                - COALESCE
                                                        (
                                                            CASE WHEN h.zrb1_fg = 1 
                                                                 THEN h.amt_zrb1    
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN h.zrb2_fg = 1 
                                                                 THEN h.amt_zrb2    
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN h.zrb3_fg = 1 
                                                                 THEN h.amt_zrb3    
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN h.zrb4_fg = 1 
                                                                 THEN h.amt_zrb4    
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN h.zrb5_fg = 1 
                                                                 THEN h.amt_zrb5    
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'A001' 
                                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act  
                                                                 ELSE NULL  
                                                            END, 0
                                                        )
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'PV02' 
                                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act  
                                                                 ELSE NULL  
                                                            END, 0
                                                        )   
                                                        
                                                - COALESCE
                                                        (
                                                            CASE WHEN clk.reason_price_modifi_adv_calc = 'PV04' 
                                                                 THEN (clk.cond_val_adv_calc - COALESCE(clk.cond_val_calc, 0)) * h.qty_act  
                                                                 ELSE NULL  
                                                            END, 0
                                                        )   
                                                +   
                                                        (   
                                                        0 * CASE WHEN clk.cond_val_adv_calc IS NOT NULL AND clk.reason_price_modifi_adv_calc IS NULL    
                                                                 THEN NULL  
                                                                 ELSE 1 
                                                            END 
                                                        )
                                            )
                                        , 0
                                        )   
                            ELSE 0  
                        END 
                    ) <> 0
    )   

  /* Artikel_1, die am Kalendertag in einer foodaction waren */
  LEFT OUTER JOIN  P_LEW_BIL.v_item_foodaction_hist_1 fa
  ON h.client_id = fa.client_id
    AND h.item_sid = fa.item_sid
    AND h.dwh_cal_dt BETWEEN fa.dwh_valid_from AND fa.dwh_valid_to

  /*Menge ungleich 0, ggf. sind 0 Mengen nur Testfaelle */
  WHERE h.qty_act <> 0
    AND h.invoice_class_cd = 'ZFPU' /*Lidl Umsatz*/
    /*Provisions- und Vermittlungsgeschaefte ignorieren*/
    AND CASE WHEN (
                    (
                      h.zprp_fg = 1
                      OR h.zpra_fg    = 1
                    )
                    AND item_type.src_mtart IN ('ZVM', 'ZKM')
                    AND h.invoice_class_cd = 'ZFPU'
                  )
             THEN 0
             ELSE 1
        END = 1
    /*Bruttofakturawert ungleich Bruttokondition * Fakturamenge gerundet
      auf zwei Nachkommastellen*/
    AND TO_NUMBER(( h.net_val + h.tax_val), 18, 2)
        <>
        TO_NUMBER((gross_prcs_vk * h.qty_act),18, 2)
    /*Differenz Bruttostueckpreis Faktura zu Bruttokondition gerundet auf
      zwei Nachkommastellen groesser/gleich 1 Cent*/
    AND ABS(ABS(TO_NUMBER((( h.net_val + h.tax_val) / h.qty_act), 18, 2)) - ABS(TO_NUMBER(gross_prcs_vk, 18, 2))) >= 0.01
    AND  ig.client_id IS NULL /*Ausschluß Artikelarten */
) basis
;