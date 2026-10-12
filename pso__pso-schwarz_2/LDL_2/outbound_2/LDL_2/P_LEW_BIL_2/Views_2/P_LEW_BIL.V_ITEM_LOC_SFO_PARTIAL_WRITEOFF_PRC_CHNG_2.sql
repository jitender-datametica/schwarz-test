/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_ITEM_LOC_SFO_PARTIAL_WRITEOFF_PRC_CHNG_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                 Generiert aus Teradata
#  1.1  19.09.2017    U.Meister         renamed loc_sid to loc_sid_store
#  1.2  17.10.2017    Arnold,Arne       Objekt STORE_TO_WAREHOUSE auf DWH_ACTUAL_FG = 1 eingeschraenkt, da ansonsten Dubletten entstehen.
#  1.3  27.10.2017    Webster,Stuart    Object STORE_TO_WAREHOSUE filterd CROSS JOIN on ACTIVE_FG
#  1.4  14.11.2017    Mustafa Sahin     CROSS JOIN to v_client_config_2 changed
#  1.5  15.11.2017    Wieber,Harald     Release 1.1
#  1.6  16.11.2017    Wieber,Harald     Relese 1.1 v2
#  1.7  20.11.2017    Wieber,Harald     Set CommentString to max length 255
#  1.8  20.11.2017    Wieber,Harald     Set CommentString to max length 255
#  1.9  20.11.2017    Wieber,Harald     Set CommentString to max length 255 (Fix 3)
#  1.1  20.11.2017    Wieber,Harald     Correct SVN File
# 1.11  05.12.2017    Meister,Ulrich    loc_sid replacement to use the loc_sid of a pseudo store instaed of the loc_sid of the warehouse
# 1.12  07.02.2018    Thole,Jens        V_ORG_STORE_SKEY_2 eliminiert und durch einfachen CROSS JOIN auf V_LOCATION_2 ersetzt. Test_2 mit Altversion ergab Identitaet.
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
# 2.02  19.02.2021    Prasanna Ranjan   REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
# 2.03  14.09.2021    Marcin Malec      REP2-10349 - Rollback of REP2-9080 (should not apply for pv, writeoff, only sales_2)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_loc_sfo_partial_writeoff_prc_chng_2 (client_id
OPTIONS(description='Landeskennzeichen'), loc_sid_store OPTIONS(description='enthaelt surrogate Key des Stores'),
src_orig_store_nr OPTIONS(description='WAWI Quellsystemschluessel Filiale'), loc_sid_wh
OPTIONS(description='Warehouse - Eindeutige Identifizierung einer Lokation ueber alle Mandanten/Laender'), orig_wh_nr
OPTIONS(description='Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH)'), item_sid
OPTIONS(description='Surrogate Key Item_2'), retail_sales_record_id
OPTIONS(description='Fakturaposition; SAP-Retail: vbrp.POSNR; SAP-BW: t_bw_2lis_13_vditm.POSNR'),
retail_sales_record_pos_id
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: vbrp.MATNR; SAP-BW: t_bw_2lis_13_vditm.MATNR'), booking_dat
OPTIONS(description='MHD Pruefung beim Wareneingang bereits vorhanden'), booking_month
OPTIONS(description='Monat_2 Buchungsdatum Artikelbeleg'), map_use_cd OPTIONS(description='Default Wert = 4'), sig_nr
OPTIONS(description='Subitemgroup / WAWI CD'), itm_mov_record_yr
OPTIONS(description='Default mit NULL Werte -Spalte wird in Abinitio verwendet'), numerator_conv_si
OPTIONS(description='Zaehler zur Umrechnung in SI-Einheit; SAP-Retail: T006.ZAEHL'), denominator_conv_si
OPTIONS(description='Nenner zur Umrechnung in SI-Einheit; SAP-Retail: T006.NENNR'), qty
OPTIONS(description='Verkaufsmenge in Lagermengeneinheit; SAP-Retail: vbrp.FKLMG; SAP-BW: t_bw_2lis_13_vditm.fklmg; eLWIS: t_s_retail_sales_record_pos.qty_lme'),
company_sid OPTIONS(description='Buchungskreis'), itmgrp_id OPTIONS(description='Artikel_2 Group ID'), sfo_total_si_qty
OPTIONS(description='Menge (ggf. umgerechnet in SI Mengeneinheit)'), sfo_total_qty
OPTIONS(description='Menge (in Erfassungsmengeneinheit, nicht umgerechnet in SI Mengeneinheit)'), foodaction_fg
OPTIONS(description='Foodactionflag'), sfo_wrtoff_zero_qty
OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'), sfo_wrtoff_zero_rtl_rl_val
OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'), sfo_wrtoff_zero_rtl_rl_net_val
OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'), itm_mov_record_id
OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'), itm_mov_record_pos_id
OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'), val_pr_diff_sfo
OPTIONS(description='Val_Pr_k Bez. Einheit sfo'), val_pr_diff_net_sfo OPTIONS(description='Default mit NULL Werte'),
sfo_total_wh_val OPTIONS(description='GROSS price warehouse * qty'), sfo_total_wh_net_val
OPTIONS(description='NET price warehouse * qty'), sfo_total_store_val OPTIONS(description='GROSS price store * qty'),
sfo_total_store_net_val OPTIONS(description='NET price store * qty'), sfo_type_cd OPTIONS(description='Sfo Typen'),
sfo_total_rtl_rl_val OPTIONS(description='GROSS final SFO amount mapped, according to column sfo_type_cd'),
sfo_total_rtl_rl_net_val OPTIONS(description='NET final SFO amount mapped, according to column sfo_type_cd'), gross_val
OPTIONS(description='GROSS final SFO amount mapped, according to column sfo_type_cd'), net_val
OPTIONS(description='Nettopreis Normal Filiale'), sfo_total_asis_fa_qty
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann  sfo_total_qty  ansonsten 0'),
sfo_wrtoff_zero_asis_fa_qty
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'),
sfo_total_rtl_rl_asis_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0'),
sfo_total_rtl_rl_net_asis_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0'),
sfo_wrtoff_zero_rtl_rl_asis_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'),
sfo_wrtoff_zero_rtl_rl_net_asis_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'),
sfo_total_fa_qty
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann  sfo_total_qty  ansonsten 0'),
sfo_wrtoff_zero_fa_qty
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'),
sfo_total_rtl_rl_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0'),
sfo_total_rtl_rl_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0'),
sfo_wrtoff_zero_rtl_rl_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'),
sfo_wrtoff_zero_rtl_rl_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'),
pcwo_reason_id
OPTIONS(description='Eindeutige ID des Abschriften_2- bzw. PV-Grundes. Landesspezifische Abschriftengruende haben ID > 100.'))
OPTIONS(DESCRIPTION = `VIEW`) AS /* Spalten fuer Aggregation Agg: t_a_sfo_wh_day_itm_asis/ t_a_sfo_store_day_sig_asis */
/* Spalten fuer Aggregation Agg: t_a_sfo_store_day */ /* benoetigt fuer Basisaggregat */
/* Falls kein ZVKP_2 vorhanden ist wird der Preis 0 verwendet */
/* Teilabschriften aus der Faktura und den Faktura Konditionen */
/* Menge in Basismenge (Im  Gegensatz zur Menge in VK_2 Mengenheit bei der Bewertung) */
/* VK_2 Bewertung aus Sales_2 Price fuer zugeordnetes WH */
/* 15.09.2016 added net column and mapped to source net column */ /* VK_2 Bewertung aus Sales_2 Price fuer Filiale */
/* Gesamtabweichung Brutto/Netto
            Kalkulation fuer Laender die Netto ausgewiesen werden */
/* GROSS country_2 */ /* NET country_2, gross und net spalten */
/* Gesamtabweichung Netto
            Kalkulation von Brutto (diff_amt) */ /* GROSS country_2 */
/* Teilbetraege aufgrund Aktion_2 */ /* Teilbetraege aufgrund Fakturakonditionen */
/* Ermittlung nicht zuordenbarer Betrag */ /* Ermittlung nicht zuordenbarer Betrag Netto */
/* SUMmierung Teilbetraege Teilabschrift Filiale */ /* SUMmierung Teilbetraege Teilabschrift Filiale Netto */
/* SUMmierung Teilbetraege Preisveraenderung Filiale */ /* SUMmierung Teilbetraege Preisveraenderung Filiale Netto */
/* Ermittlung SFO Type */ /* BDO-2188 */ /* Selektion SFO Betrag */ /* BDO-2188 */ /* Selektion SFO Betrag Netto */
/* BDO-2188 */ /* abgestimmte Logik in allen Aggregate-Views */
/* Defintion Ermittlung PCWO Mapping nach Vorgabe Hr. Massa (08/2016) */
/* Spezifikation im Net-DB_technical-specification chapter 11.4.2 */
/* Spezifikation im Net-DB_technical-specification chapter 11.4.2 */
/* Faktura Positionen und die Zugehoerigen Konditionen werden */
/* in einer derived table zunaechst verjoined und aggregiert */
/* Dies ist notwendig, um korrekte Ergebnisse in der spaeteren */ /* Berechnung pro Position zu erhalten */
/* Der CROSS JOIN in derived table soll bessere Partition ermoeglichen */
/* Dies scheinen Warhouse-Locations zu sein die eine_2 ORIG_WH_ID haben, die gleichzeitig auch als ORIG_STORE_NR vorkommt und dementsprechend uebersetzt werden sollen */
/* warehouses */
/* Suche alle Locations deren ORIG.Store_Nr mit den WH_IDs der selektierten WH-Zeilen uebereinstimmen */
/* Details zum Artikel_2 */ /* Normal VK_2  muss zwingend vorhanden sein */
/* select only warehouse price conditions from the denorm table */
/* Artikel_2, die am Kalendertag in einer foodaction waren */
/* Differenz Bruttostueckpreis Faktura zu Bruttokondition gerundet auf
      zwei Nachkommastellen groesser/gleich 1 Cent */
/* Ausschluß Artikelarten */ SELECT client_id,
 loc_sid_store,
 src_orig_store_nr,
 loc_sid_wh,
 orig_wh_nr,
 item_sid,
 retail_sales_record_id,
 retail_sales_record_pos_id,
 booking_dat,
 ROUND(CAST(FORMAT_DATE('%Y%m', booking_dat) AS BIGNUMERIC), 0) AS booking_month,
 map_use_cd,
 sig_nr,
 itm_mov_record_yr,
 numerator_conv_si,
 denominator_conv_si,
 qty,
 company_sid,
 itmgrp_id,
   qty * numerator_conv_si / denominator_conv_si AS sfo_total_si_qty,
 qty AS sfo_total_qty,
 foodaction_fg,
 0 AS sfo_wrtoff_zero_qty,
 0 AS sfo_wrtoff_zero_rtl_rl_val,
 0 AS sfo_wrtoff_zero_rtl_rl_net_val,
 0 AS itm_mov_record_id,
 0 AS itm_mov_record_pos_id,
 val_pr_diff_sfo,
 val_pr_diff_net_sfo,
  price_act_wh * qty AS sfo_total_wh_val,
  price_act_wh_net * qty AS sfo_total_wh_net_val,
  price_str_dir_del * qty AS sfo_total_store_val,
  price_str_net_dir_del * qty AS sfo_total_store_net_val,
 sfo_type_cd,
 sfo_amt AS sfo_total_rtl_rl_val,
 sfo_amt_net AS sfo_total_rtl_rl_net_val,
 sfo_amt AS gross_val,
 sfo_amt_net AS net_val,
  CASE
  WHEN foodaction_fg = 1
  THEN qty
  ELSE 0
  END AS sfo_total_asis_fa_qty,
 0 AS sfo_wrtoff_zero_asis_fa_qty,
  CASE
  WHEN foodaction_fg = 1
  THEN sfo_amt
  ELSE 0
  END AS sfo_total_rtl_rl_asis_fa_val,
  CASE
  WHEN foodaction_fg = 1
  THEN sfo_amt_net
  ELSE 0
  END AS sfo_total_rtl_rl_net_asis_fa_val,
 0 AS sfo_wrtoff_zero_rtl_rl_asis_fa_val,
 0 AS sfo_wrtoff_zero_rtl_rl_net_asis_fa_val,
  CASE
  WHEN foodaction_fg = 1
  THEN qty
  ELSE 0
  END AS sfo_total_fa_qty,
 0 AS sfo_wrtoff_zero_fa_qty,
  CASE
  WHEN foodaction_fg = 1
  THEN sfo_amt
  ELSE 0
  END AS sfo_total_rtl_rl_fa_val,
  CASE
  WHEN foodaction_fg = 1
  THEN sfo_amt_net
  ELSE 0
  END AS sfo_total_rtl_rl_net_fa_val,
 0 AS sfo_wrtoff_zero_rtl_rl_fa_val,
 0 AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
 pcwo_reason_id
FROM (SELECT h.client_id,
   h.loc_sid_store,
   LOC.src_orig_store_nr,
   LOC.global_loc_id,
   W.loc_sid_wh,
   h.item_sid,
   h.dwh_cal_dt AS booking_dat,
   COALESCE(CLK.cond_val_calc, 0) AS gross_prcs_vk,
   COALESCE(CLK.net_val_calc, 0) AS net_prcs_vk,
    COALESCE(CLK.cond_val_eff_calc, 0.000) * h.qty_act AS val_rtl_rl_del,
    COALESCE(CLK.net_val_eff_calc, 0.000) * h.qty_act AS val_rtl_rl_net_del,
   '' AS itm_mov_type_cd,
   4 AS map_use_cd,
   COALESCE(CAST(IGI.src_subitemgrp_cd AS BIGNUMERIC), - 1) AS sig_nr,
   0 AS itm_mov_record_yr,
   h.retail_sales_record_id,
   h.retail_sales_record_pos_id,
   W.src_wh_id AS orig_wh_nr,
   COALESCE(D.numerator_conv_si, 1) AS numerator_conv_si,
   COALESCE(D.denominator_conv_si, 1) AS denominator_conv_si,
    h.qty_stock_unit * - 1 AS qty,
   0 AS company_sid,
   NULL AS deb_cred_cd,
   ITEM_GROUP.src_matkl AS itmgrp_id,
   cwk.cond_val_eff_calc AS price_act_wh,
   cwk.net_val_eff_calc AS price_act_wh_net,
   COALESCE(CLK.cond_val_eff_calc, 0.000) AS price_str_dir_del,
   COALESCE(CLK.net_val_eff_calc, 0.000) AS price_str_net_dir_del,
    CASE
    WHEN CNTRY.sales_gross_fg = 1
    THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
    ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
    END AS diff_amt,
    CASE
    WHEN CNTRY.sales_gross_fg = 1
    THEN CASE
       WHEN CNTRY.sales_gross_fg = 1
       THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
       ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
       END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
    END AS diff_amt_net,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'A001'
    THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_a001,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'A001'
    THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_net_a001,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
    THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_pv02,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
    THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_net_pv02,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
    THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_pv04,
    CASE
    WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
    THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
    ELSE NULL
    END AS sfo_amt_net_pv04,
    CASE
    WHEN h.zrb1_fg = 1
    THEN h.amt_zrb1
    ELSE NULL
    END AS sfo_amt_zrb1,
    CASE
    WHEN h.zrb1_fg = 1
    THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE NULL
    END AS sfo_amt_net_zrb1,
    CASE
    WHEN h.zrb2_fg = 1
    THEN h.amt_zrb2
    ELSE NULL
    END AS sfo_amt_zrb2,
    CASE
    WHEN h.zrb2_fg = 1
    THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE NULL
    END AS sfo_amt_net_zrb2,
    CASE
    WHEN h.zrb3_fg = 1
    THEN h.amt_zrb3
    ELSE NULL
    END AS sfo_amt_zrb3,
    CASE
    WHEN h.zrb3_fg = 1
    THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE NULL
    END AS sfo_amt_net_zrb3,
    CASE
    WHEN h.zrb4_fg = 1
    THEN h.amt_zrb4
    ELSE NULL
    END AS sfo_amt_zrb4,
    CASE
    WHEN h.zrb4_fg = 1
    THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE NULL
    END AS sfo_amt_net_zrb4,
    CASE
    WHEN h.zrb5_fg = 1
    THEN h.amt_zrb5
    ELSE NULL
    END AS sfo_amt_zrb5,
    CASE
    WHEN h.zrb5_fg = 1
    THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
    ELSE NULL
    END AS sfo_amt_net_zrb5,
             CASE
             WHEN CNTRY.sales_gross_fg = 1
             THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
             ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
             END - COALESCE(CASE
              WHEN h.zrb1_fg = 1
              THEN h.amt_zrb1
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN h.zrb2_fg = 1
             THEN h.amt_zrb2
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN h.zrb3_fg = 1
            THEN h.amt_zrb3
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN h.zrb4_fg = 1
           THEN h.amt_zrb4
           ELSE NULL
           END, 0) - COALESCE(CASE
          WHEN h.zrb5_fg = 1
          THEN h.amt_zrb5
          ELSE NULL
          END, 0) - COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'A001'
         THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) - COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) - COALESCE(CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END, 0) + 0 * CASE
      WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
      THEN NULL
      ELSE 1
      END AS sfo_amt_fbo,
             CASE
             WHEN CNTRY.sales_gross_fg = 1
             THEN CASE
                WHEN CNTRY.sales_gross_fg = 1
                THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
             ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
             END - COALESCE(CASE
              WHEN h.zrb1_fg = 1
              THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN h.zrb2_fg = 1
             THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN h.zrb3_fg = 1
            THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN h.zrb4_fg = 1
           THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
           ELSE NULL
           END, 0) - COALESCE(CASE
          WHEN h.zrb5_fg = 1
          THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) - COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'A001'
         THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) - COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) - COALESCE(CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
       ELSE NULL
       END, 0) + 0 * (CASE
                WHEN CNTRY.sales_gross_fg = 1
                THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                END - COALESCE(CASE
                 WHEN h.zrb1_fg = 1
                 THEN h.amt_zrb1
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb2_fg = 1
                THEN h.amt_zrb2
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN h.zrb3_fg = 1
               THEN h.amt_zrb3
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN h.zrb4_fg = 1
              THEN h.amt_zrb4
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN h.zrb5_fg = 1
             THEN h.amt_zrb5
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN CLK.reason_price_modifi_adv_calc = 'A001'
            THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
           THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) - COALESCE(CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
          THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
          ELSE NULL
          END, 0) + 0 * CASE
         WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
         THEN NULL
         ELSE 1
         END) AS sfo_amt_net_fbo,
    CASE
    WHEN CASE
        WHEN h.zrb1_fg = 1
        THEN h.amt_zrb1
        ELSE NULL
        END IS NOT NULL OR CASE
        WHEN h.zrb3_fg = 1
        THEN h.amt_zrb3
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
       WHEN CNTRY.sales_gross_fg = 1
       THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
       ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
       END IS NOT NULL AND CASE
       WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
       THEN NULL
       ELSE 1
       END IS NOT NULL
    THEN COALESCE(CASE
         WHEN h.zrb1_fg = 1
         THEN h.amt_zrb1
         ELSE NULL
         END, 0) + COALESCE(CASE
         WHEN h.zrb3_fg = 1
         THEN h.amt_zrb3
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) + COALESCE(CASE
                WHEN CNTRY.sales_gross_fg = 1
                THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                END - COALESCE(CASE
                 WHEN h.zrb1_fg = 1
                 THEN h.amt_zrb1
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb2_fg = 1
                THEN h.amt_zrb2
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN h.zrb3_fg = 1
               THEN h.amt_zrb3
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN h.zrb4_fg = 1
              THEN h.amt_zrb4
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN h.zrb5_fg = 1
             THEN h.amt_zrb5
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN CLK.reason_price_modifi_adv_calc = 'A001'
            THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
           THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) - COALESCE(CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
          THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
          ELSE NULL
          END, 0) + 0 * CASE
         WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
         THEN NULL
         ELSE 1
         END, 0)
    ELSE 0
    END AS sfo_amt_137,
    CASE
    WHEN CASE
        WHEN h.zrb1_fg = 1
        THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
        ELSE NULL
        END IS NOT NULL OR CASE
        WHEN h.zrb3_fg = 1
        THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
       THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
        WHEN CNTRY.sales_gross_fg = 1
        THEN CASE
           WHEN CNTRY.sales_gross_fg = 1
           THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
           ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
           END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
        ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
        END IS NOT NULL AND CASE
        WHEN CNTRY.sales_gross_fg = 1
        THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
        ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
        END IS NOT NULL AND CASE
       WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
       THEN NULL
       ELSE 1
       END IS NOT NULL
    THEN COALESCE(CASE
         WHEN h.zrb1_fg = 1
         THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END, 0) + COALESCE(CASE
         WHEN h.zrb3_fg = 1
         THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) + COALESCE(CASE
                WHEN CNTRY.sales_gross_fg = 1
                THEN CASE
                   WHEN CNTRY.sales_gross_fg = 1
                   THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                   ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                   END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                END - COALESCE(CASE
                 WHEN h.zrb1_fg = 1
                 THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb2_fg = 1
                THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN h.zrb3_fg = 1
               THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN h.zrb4_fg = 1
              THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN h.zrb5_fg = 1
             THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN CLK.reason_price_modifi_adv_calc = 'A001'
            THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
           THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) - COALESCE(CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
          THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
          ELSE NULL
          END, 0) + 0 * (CASE
                   WHEN CNTRY.sales_gross_fg = 1
                   THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                   ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                   END - COALESCE(CASE
                    WHEN h.zrb1_fg = 1
                    THEN h.amt_zrb1
                    ELSE NULL
                    END, 0) - COALESCE(CASE
                   WHEN h.zrb2_fg = 1
                   THEN h.amt_zrb2
                   ELSE NULL
                   END, 0) - COALESCE(CASE
                  WHEN h.zrb3_fg = 1
                  THEN h.amt_zrb3
                  ELSE NULL
                  END, 0) - COALESCE(CASE
                 WHEN h.zrb4_fg = 1
                 THEN h.amt_zrb4
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb5_fg = 1
                THEN h.amt_zrb5
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN CLK.reason_price_modifi_adv_calc = 'A001'
               THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
              THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
             THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
             ELSE NULL
             END, 0) + 0 * CASE
            WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
            THEN NULL
            ELSE 1
            END), 0)
    ELSE 0
    END AS sfo_amt_net_137,
    CASE
    WHEN CASE
         WHEN h.zrb2_fg = 1
         THEN h.amt_zrb2
         ELSE NULL
         END IS NOT NULL OR CASE
         WHEN h.zrb4_fg = 1
         THEN h.amt_zrb4
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN h.zrb5_fg = 1
        THEN h.amt_zrb5
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'A001'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
      WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
      THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
      ELSE NULL
      END IS NOT NULL
    THEN COALESCE(CASE
          WHEN h.zrb2_fg = 1
          THEN h.amt_zrb2
          ELSE NULL
          END, 0) + COALESCE(CASE
          WHEN h.zrb4_fg = 1
          THEN h.amt_zrb4
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN h.zrb5_fg = 1
         THEN h.amt_zrb5
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'A001'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) + COALESCE(CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END, 0)
    ELSE 0
    END AS sfo_amt_134,
    CASE
    WHEN CASE
         WHEN h.zrb2_fg = 1
         THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END IS NOT NULL OR CASE
         WHEN h.zrb4_fg = 1
         THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN h.zrb5_fg = 1
        THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'A001'
       THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
      WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
      THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
      ELSE NULL
      END IS NOT NULL
    THEN COALESCE(CASE
          WHEN h.zrb2_fg = 1
          THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) + COALESCE(CASE
          WHEN h.zrb4_fg = 1
          THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN h.zrb5_fg = 1
         THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'A001'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0) + COALESCE(CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
       ELSE NULL
       END, 0)
    ELSE 0
    END AS sfo_amt_net_134,
    CASE
    WHEN cal.faecher = 1
    THEN '134'
    ELSE '137'
    END AS sfo_type_cd,
    CASE
    WHEN cal.faecher = 1
    THEN CASE
     WHEN CASE
          WHEN h.zrb2_fg = 1
          THEN h.amt_zrb2
          ELSE NULL
          END IS NOT NULL OR CASE
          WHEN h.zrb4_fg = 1
          THEN h.amt_zrb4
          ELSE NULL
          END IS NOT NULL OR CASE
         WHEN h.zrb5_fg = 1
         THEN h.amt_zrb5
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'A001'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL
     THEN COALESCE(CASE
           WHEN h.zrb2_fg = 1
           THEN h.amt_zrb2
           ELSE NULL
           END, 0) + COALESCE(CASE
           WHEN h.zrb4_fg = 1
           THEN h.amt_zrb4
           ELSE NULL
           END, 0) + COALESCE(CASE
          WHEN h.zrb5_fg = 1
          THEN h.amt_zrb5
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'A001'
         THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0)
     ELSE 0
     END
    ELSE CASE
     WHEN CASE
         WHEN h.zrb1_fg = 1
         THEN h.amt_zrb1
         ELSE NULL
         END IS NOT NULL OR CASE
         WHEN h.zrb3_fg = 1
         THEN h.amt_zrb3
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END IS NOT NULL OR CASE
        WHEN CNTRY.sales_gross_fg = 1
        THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
        ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
        END IS NOT NULL AND CASE
        WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
        THEN NULL
        ELSE 1
        END IS NOT NULL
     THEN COALESCE(CASE
          WHEN h.zrb1_fg = 1
          THEN h.amt_zrb1
          ELSE NULL
          END, 0) + COALESCE(CASE
          WHEN h.zrb3_fg = 1
          THEN h.amt_zrb3
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
         THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) + COALESCE(CASE
                 WHEN CNTRY.sales_gross_fg = 1
                 THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                 ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                 END - COALESCE(CASE
                  WHEN h.zrb1_fg = 1
                  THEN h.amt_zrb1
                  ELSE NULL
                  END, 0) - COALESCE(CASE
                 WHEN h.zrb2_fg = 1
                 THEN h.amt_zrb2
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb3_fg = 1
                THEN h.amt_zrb3
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN h.zrb4_fg = 1
               THEN h.amt_zrb4
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN h.zrb5_fg = 1
              THEN h.amt_zrb5
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN CLK.reason_price_modifi_adv_calc = 'A001'
             THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
            THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
           THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) + 0 * CASE
          WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
          THEN NULL
          ELSE 1
          END, 0)
     ELSE 0
     END
    END AS sfo_amt,
    CASE
    WHEN cal.faecher = 1
    THEN CASE
     WHEN CASE
          WHEN h.zrb2_fg = 1
          THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END IS NOT NULL OR CASE
          WHEN h.zrb4_fg = 1
          THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END IS NOT NULL OR CASE
         WHEN h.zrb5_fg = 1
         THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'A001'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END IS NOT NULL OR CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
       THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL
     THEN COALESCE(CASE
           WHEN h.zrb2_fg = 1
           THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
           ELSE NULL
           END, 0) + COALESCE(CASE
           WHEN h.zrb4_fg = 1
           THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
           ELSE NULL
           END, 0) + COALESCE(CASE
          WHEN h.zrb5_fg = 1
          THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'A001'
         THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) + COALESCE(CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END, 0)
     ELSE 0
     END
    ELSE CASE
     WHEN CASE
         WHEN h.zrb1_fg = 1
         THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END IS NOT NULL OR CASE
         WHEN h.zrb3_fg = 1
         THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE NULL
         END IS NOT NULL OR CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
        THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
        ELSE NULL
        END IS NOT NULL OR CASE
         WHEN CNTRY.sales_gross_fg = 1
         THEN CASE
            WHEN CNTRY.sales_gross_fg = 1
            THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
            ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
            END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
         ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
         END IS NOT NULL AND CASE
         WHEN CNTRY.sales_gross_fg = 1
         THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
         ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
         END IS NOT NULL AND CASE
        WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
        THEN NULL
        ELSE 1
        END IS NOT NULL
     THEN COALESCE(CASE
          WHEN h.zrb1_fg = 1
          THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) + COALESCE(CASE
          WHEN h.zrb3_fg = 1
          THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
          ELSE NULL
          END, 0) + COALESCE(CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
         THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
         ELSE NULL
         END, 0) + COALESCE(CASE
                 WHEN CNTRY.sales_gross_fg = 1
                 THEN CASE
                    WHEN CNTRY.sales_gross_fg = 1
                    THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                    ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                    END * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                 ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                 END - COALESCE(CASE
                  WHEN h.zrb1_fg = 1
                  THEN h.amt_zrb1 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                  ELSE NULL
                  END, 0) - COALESCE(CASE
                 WHEN h.zrb2_fg = 1
                 THEN h.amt_zrb2 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb3_fg = 1
                THEN h.amt_zrb3 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN h.zrb4_fg = 1
               THEN h.amt_zrb4 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN h.zrb5_fg = 1
              THEN h.amt_zrb5 * 100 / (IF(100 = 0, NULL, 100) + CLK.tax_rate_calc)
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN CLK.reason_price_modifi_adv_calc = 'A001'
             THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
             ELSE NULL
             END, 0) - COALESCE(CASE
            WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
            THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
            ELSE NULL
            END, 0) - COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
           THEN (CLK.net_val_adv_calc - COALESCE(CLK.net_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) + 0 * (CASE
                    WHEN CNTRY.sales_gross_fg = 1
                    THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                    ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                    END - COALESCE(CASE
                     WHEN h.zrb1_fg = 1
                     THEN h.amt_zrb1
                     ELSE NULL
                     END, 0) - COALESCE(CASE
                    WHEN h.zrb2_fg = 1
                    THEN h.amt_zrb2
                    ELSE NULL
                    END, 0) - COALESCE(CASE
                   WHEN h.zrb3_fg = 1
                   THEN h.amt_zrb3
                   ELSE NULL
                   END, 0) - COALESCE(CASE
                  WHEN h.zrb4_fg = 1
                  THEN h.amt_zrb4
                  ELSE NULL
                  END, 0) - COALESCE(CASE
                 WHEN h.zrb5_fg = 1
                 THEN h.amt_zrb5
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN CLK.reason_price_modifi_adv_calc = 'A001'
                THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
               THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
              THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
              ELSE NULL
              END, 0) + 0 * CASE
             WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
             THEN NULL
             ELSE 1
             END), 0)
     ELSE 0
     END
    END AS sfo_amt_net,
    CASE
    WHEN FA.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS foodaction_fg,
    CASE
    WHEN CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'A001'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
       WHEN h.zrb2_fg = 1
       THEN h.amt_zrb2
       ELSE NULL
       END IS NOT NULL OR CASE
      WHEN h.zrb5_fg = 1
      THEN h.amt_zrb5
      ELSE NULL
      END IS NOT NULL
    THEN 41
    WHEN CAST(CASE
        WHEN cal.faecher = 1
        THEN '134'
        ELSE '137'
        END AS FLOAT64) <> 137
      /* the mapping of sfo_type 137 with the pcwo_reason_cd 43 does not exists - therefore the reason_id has to be set to next codes */
       AND (CASE
        WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
        THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
        ELSE NULL
        END IS NOT NULL OR CASE
        WHEN h.zrb4_fg = 1
        THEN h.amt_zrb4
        ELSE NULL
        END IS NOT NULL)
    THEN 43
    WHEN CASE
       WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
       THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
       ELSE NULL
       END IS NOT NULL OR CASE
       WHEN h.zrb3_fg = 1
       THEN h.amt_zrb3
       ELSE NULL
       END IS NOT NULL OR CASE
       WHEN h.zrb1_fg = 1
       THEN h.amt_zrb1
       ELSE NULL
       END IS NOT NULL AND CAST(IGI.src_itemgrp_int_cd AS INTEGER) IN (7, 70)
    THEN 6
    WHEN CASE
       WHEN CNTRY.sales_gross_fg = 1
       THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
       ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
       END IS NOT NULL AND CASE
       WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
       THEN NULL
       ELSE 1
       END IS NOT NULL OR CASE
       WHEN h.zrb1_fg = 1
       THEN h.amt_zrb1
       ELSE NULL
       END IS NOT NULL AND CAST(IGI.src_itemgrp_int_cd AS INTEGER) NOT IN (7, 70)
    THEN 5
    ELSE NULL
    END AS pcwo_reason_id,
   CAST(NULL AS NUMERIC) AS val_pr_diff_sfo,
   CAST(NULL AS NUMERIC) AS val_pr_diff_net_sfo
  FROM (SELECT K.client_id,
     P.retail_sales_record_id,
     P.retail_sales_record_pos_id,
     K.dwh_cal_dt,
     K.invoice_class_cd,
     P.item_sid,
     P.loc_sid,
     COALESCE(lm.loc_sid_store, P.loc_sid) AS loc_sid_store,
     P.uom_sid,
     P.qty_stock_unit,
     P.net_val,
     P.tax_val,
     P.qty_act,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZRB1'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zrb1,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZRB2'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zrb2,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZRB3'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zrb3,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZRB4'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zrb4,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZRB5'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zrb5,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZPRP'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zprp,
     SUM(CASE
       WHEN C.cond_type_cd = 'ZPRA'
       THEN C.cond_val
       ELSE 0
       END) AS amt_zpra,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZRB1'
       THEN 1
       ELSE 0
       END) AS zrb1_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZRB2'
       THEN 1
       ELSE 0
       END) AS zrb2_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZRB3'
       THEN 1
       ELSE 0
       END) AS zrb3_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZRB4'
       THEN 1
       ELSE 0
       END) AS zrb4_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZRB5'
       THEN 1
       ELSE 0
       END) AS zrb5_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZPRP'
       THEN 1
       ELSE 0
       END) AS zprp_fg,
     MAX(CASE
       WHEN C.cond_type_cd = 'ZPRA'
       THEN 1
       ELSE 0
       END) AS zpra_fg
    FROM ldl_p_lew_core_ac.v_retail_sales_record_2 AS K
     INNER JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos_2 AS P ON K.client_id = P.client_id AND K.retail_sales_record_id
         = P.retail_sales_record_id AND K.dwh_cal_dt = P.dwh_cal_dt
     LEFT JOIN (SELECT WH.loc_sid,
       WH.client_id,
       ST.loc_sid AS loc_sid_store
      FROM ldl_p_lew_core_ac.v_location_2 AS WH
       INNER JOIN ldl_p_lew_core_ac.v_location_2 AS ST ON WH.src_wh_id = ST.src_orig_store_nr AND WH.client_id = ST.client_id
         ) AS lm ON P.loc_sid = lm.loc_sid AND P.client_id = lm.client_id
       /* Konditionsart ZRB1, ZRB2, ZBR3, ZRB4, ZPRP und ZPRA aus Fakturakonditionen */
     LEFT JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos_cond_2 AS C ON P.client_id = C.client_id AND P.retail_sales_record_id
           = C.retail_sales_record_id AND P.retail_sales_record_pos_id = C.retail_sales_record_pos_id AND P.dwh_cal_dt =
        C.dwh_cal_dt AND C.cond_type_cd IN ('ZRB1', 'ZRB2', 'ZRB3', 'ZRB4', 'ZRB5', 'ZPRP', 'ZPRA')
    GROUP BY K.client_id,
     P.retail_sales_record_id,
     P.retail_sales_record_pos_id,
     K.dwh_cal_dt,
     K.invoice_class_cd,
     P.item_sid,
     P.loc_sid,
     loc_sid_store,
     P.uom_sid,
     P.qty_stock_unit,
     P.net_val,
     P.tax_val,
     P.qty_act) AS h
   INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITEM_2 ON h.client_id = ITEM.client_id AND h.item_sid = ITEM.item_sid AND
     CURRENT_DATE BETWEEN ITEM.dwh_valid_from AND ITEM.dwh_valid_to
     /* Referenz zu Artikelart zur Filterung der Artikelarten */
   INNER JOIN ldl_p_lew_core_ac.v_item_group_2 AS ITEM_GROUP ON ITEM.client_id = ITEM_GROUP.client_id AND ITEM.item_grp_sid
      = ITEM_GROUP.item_grp_sid /* Details zum Artikel_2 Art_2 */
   INNER JOIN ldl_p_lew_core_ac.v_item_type_2 AS ITEM_TYPE ON ITEM.client_id = ITEM_TYPE.client_id AND ITEM.item_type_sid
     = ITEM_TYPE.item_type_sid /* Zu ignorierende Artikelarten */
   LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG ON ITEM_TYPE.client_id = IG.client_id AND ITEM_TYPE.src_mtart
       = IG.item_type_cd AND IG.item_type_grp_cd IN ('BAGLEVY', 'ADJ')
    /* Filterung von TestFilialen und Vorlage-Filialen */
   INNER JOIN ldl_p_lew_bil.v_store_2 AS LOC ON h.client_id = LOC.client_id AND h.loc_sid_store = LOC.loc_sid_store AND
     CURRENT_DATE BETWEEN LOC.dwh_valid_from AND LOC.dwh_valid_to /* Ermittlung WH zu Store */
   INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown_2 AS W ON h.client_id = W.client_id AND h.loc_sid_store = W.loc_sid_store
     /* Mapping cntry process table for NET/GROSS country_2 information */
   LEFT JOIN ldl_p_lew_process_ac.v_client_config_2 AS CNTRY ON h.client_id = CNTRY.client_id
    /* Details zum Umrechnungsfaktor */
   LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_2 AS D ON h.uom_sid = D.uom_sid
    /* VK_2 Preisermittlung Filial - Bestellkopfartikel, Filiale Datum */
   INNER JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm_2 AS CLK ON h.client_id = CLK.client_id AND h.item_sid = CLK.item_sid
         AND h.loc_sid = CLK.loc_sid AND h.uom_sid = CLK.uom_sid_cond AND h.dwh_cal_dt BETWEEN CLK.dwh_valid_from AND
     CLK.dwh_valid_to /* VK_2 Preisermittlung Niederlassung -Bestellkopfartikel, Niederlassung Datum */
   LEFT JOIN (SELECT D0.client_id,
     D0.item_sid,
     D0.loc_sid,
     D0.uom_sid_cond,
     D0.dwh_valid_from,
     D0.dwh_valid_to,
     D0.net_val_eff_calc,
     D0.cond_val_eff_calc
    FROM ldl_p_lew_bil.v_item_loc_sales_cond_denorm_2 AS D0
     INNER JOIN ldl_p_lew_core_ac.v_location_2 AS WH0 ON D0.client_id = WH0.client_id AND D0.loc_sid = WH0.loc_sid AND
       UPPER(WH0.wh_store_mark) = 'B' /* Warehouse */) AS cwk ON h.client_id = cwk.client_id AND h.item_sid = cwk.item_sid
         AND W.loc_sid_wh = cwk.loc_sid AND h.uom_sid = cwk.uom_sid_cond AND h.dwh_cal_dt BETWEEN cwk.dwh_valid_from AND
     cwk.dwh_valid_to /* Details zur Artikel_2 Hierarchie */
   INNER JOIN ldl_p_lew_bil.v_item_hierarchy_2 AS IGI ON ITEM.item_sid = IGI.item_sid AND ITEM.client_id = IGI.client_id
     /* Dummy_2 um bei Vorhandensein von 137 UND 134 ggf. die Zeile aufzufaechern */
   INNER JOIN (SELECT RANK() OVER (ORDER BY cal_dt IS NULL, cal_dt) AS faecher
    FROM ldl_p_lew_core_ac.v_cal_calendarday_2
    WHERE cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) AND (CURRENT_DATE)) AS cal ON cal.faecher = 1 AND CASE
       WHEN CASE
            WHEN h.zrb2_fg = 1
            THEN h.amt_zrb2
            ELSE NULL
            END IS NOT NULL OR CASE
            WHEN h.zrb4_fg = 1
            THEN h.amt_zrb4
            ELSE NULL
            END IS NOT NULL OR CASE
           WHEN h.zrb5_fg = 1
           THEN h.amt_zrb5
           ELSE NULL
           END IS NOT NULL OR CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'A001'
          THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
          ELSE NULL
          END IS NOT NULL OR CASE
         WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
         THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
         ELSE NULL
         END IS NOT NULL
       THEN COALESCE(CASE
             WHEN h.zrb2_fg = 1
             THEN h.amt_zrb2
             ELSE NULL
             END, 0) + COALESCE(CASE
             WHEN h.zrb4_fg = 1
             THEN h.amt_zrb4
             ELSE NULL
             END, 0) + COALESCE(CASE
            WHEN h.zrb5_fg = 1
            THEN h.amt_zrb5
            ELSE NULL
            END, 0) + COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'A001'
           THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) + COALESCE(CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
          THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
          ELSE NULL
          END, 0)
       ELSE 0
       END <> 0 OR cal.faecher = 2 AND CASE
       WHEN CASE
           WHEN h.zrb1_fg = 1
           THEN h.amt_zrb1
           ELSE NULL
           END IS NOT NULL OR CASE
           WHEN h.zrb3_fg = 1
           THEN h.amt_zrb3
           ELSE NULL
           END IS NOT NULL OR CASE
          WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
          THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
          ELSE NULL
          END IS NOT NULL OR CASE
          WHEN CNTRY.sales_gross_fg = 1
          THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
          ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
          END IS NOT NULL AND CASE
          WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
          THEN NULL
          ELSE 1
          END IS NOT NULL
       THEN COALESCE(CASE
            WHEN h.zrb1_fg = 1
            THEN h.amt_zrb1
            ELSE NULL
            END, 0) + COALESCE(CASE
            WHEN h.zrb3_fg = 1
            THEN h.amt_zrb3
            ELSE NULL
            END, 0) + COALESCE(CASE
           WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
           THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
           ELSE NULL
           END, 0) + COALESCE(CASE
                   WHEN CNTRY.sales_gross_fg = 1
                   THEN h.net_val + h.tax_val - COALESCE(CLK.cond_val_calc, 0) * h.qty_act
                   ELSE h.net_val - COALESCE(CLK.net_val_calc, 0) * h.qty_act
                   END - COALESCE(CASE
                    WHEN h.zrb1_fg = 1
                    THEN h.amt_zrb1
                    ELSE NULL
                    END, 0) - COALESCE(CASE
                   WHEN h.zrb2_fg = 1
                   THEN h.amt_zrb2
                   ELSE NULL
                   END, 0) - COALESCE(CASE
                  WHEN h.zrb3_fg = 1
                  THEN h.amt_zrb3
                  ELSE NULL
                  END, 0) - COALESCE(CASE
                 WHEN h.zrb4_fg = 1
                 THEN h.amt_zrb4
                 ELSE NULL
                 END, 0) - COALESCE(CASE
                WHEN h.zrb5_fg = 1
                THEN h.amt_zrb5
                ELSE NULL
                END, 0) - COALESCE(CASE
               WHEN CLK.reason_price_modifi_adv_calc = 'A001'
               THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
               ELSE NULL
               END, 0) - COALESCE(CASE
              WHEN CLK.reason_price_modifi_adv_calc = 'PV02'
              THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
              ELSE NULL
              END, 0) - COALESCE(CASE
             WHEN CLK.reason_price_modifi_adv_calc = 'PV04'
             THEN (CLK.cond_val_adv_calc - COALESCE(CLK.cond_val_calc, 0)) * h.qty_act
             ELSE NULL
             END, 0) + 0 * CASE
            WHEN CLK.cond_val_adv_calc IS NOT NULL AND CLK.reason_price_modifi_adv_calc IS NULL
            THEN NULL
            ELSE 1
            END, 0)
       ELSE 0
       END <> 0
   LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist_2 AS FA ON h.client_id = FA.client_id AND h.item_sid = FA.item_sid AND h
     .dwh_cal_dt BETWEEN FA.dwh_valid_from AND FA.dwh_valid_to /* Menge ungleich 0, ggf. sind 0 Mengen nur Testfaelle */
     
  WHERE h.qty_act <> 0
   AND h.invoice_class_cd = 'ZFPU' /* Lidl Umsatz */ /* Provisions- und Vermittlungsgeschaefte ignorieren */
   AND CASE
     WHEN (h.zprp_fg = 1 OR h.zpra_fg = 1) AND ITEM_TYPE.src_mtart IN ('ZVM', 'ZKM') AND h.invoice_class_cd = 'ZFPU'
     THEN 0
     ELSE 1
     END = 1 /* Bruttofakturawert ungleich Bruttokondition * Fakturamenge gerundet
      auf zwei Nachkommastellen */
   AND ROUND(CAST(h.net_val + h.tax_val AS NUMERIC), 2) <> ROUND(CAST(COALESCE(CLK.cond_val_calc, 0) * h.qty_act AS NUMERIC)
     , 2)
   AND ABS(ABS(CAST((h.net_val + h.tax_val) / h.qty_act AS NUMERIC)) - ABS(ROUND(CAST(COALESCE(CLK.cond_val_calc, 0) AS NUMERIC)
        , 2))) >= 0.01
   AND IG.client_id IS NULL) AS basis;