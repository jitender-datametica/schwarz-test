/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_ITEM_LOC_SFO_ZERO_WRITEOFF_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                          Generiert aus Teradata
#  1.1  19.09.2017    U.Meister                  adjusted due to column name changes in source views
#  1.2  17.10.2017    Arnold.Arne                Objekt STORE_TO_WAREHOUSE auf DWH_ACTUAL_FG = 1 eingeschraenkt. da ansonsten Dubletten entstehen.
#  1.3  27.10.2017    Webster.Stuart             Obkect STORE_TO_WAREHOUSE linked using ACTIVE Flag g g
#  1.4  15.11.2017    Wieber.Harald              Release 1.1
#  1.5  16.11.2017    Wieber.Harald              Relese 1.1 v2
#  1.6  20.11.2017    Wieber.Harald              Set CommentString to max length 255
#  1.7  20.11.2017    Wieber.Harald              Set CommentString to max length 255
#  1.8  20.11.2017    Wieber.Harald              Set CommentString to max length 255 (Fix 3)
#  1.9  20.11.2017    Wieber.Harald              Correct SVN File
#  1.1  06.12.2017    Meister.Ulrich             loc_sid replacement to use the loc_sid of a pseudo store instaed of the loc_sid of the warehouse
# 1.11  11.12.2017    Meister.Ulrich             calculation of val_pr_diff_net_sfo adjusted
# 1.12  07.02.2018    Thole.Jens                 V_ORG_STORE_SKEY_2 eliminiert und durch einfachen CROSS JOIN auf V_LOCATION_2 ersetzt. Test_2 mit Altversion ergab Identitaet.
# 1.13  28.02.2018    Taubkin. Slavik            Umstellung auf last_known Views
# 1.14  02.03.2018    Meister.Ulrich             Spaltenkommentare wieder hinzugefuegt
# 1.15  12.03.2018    Webster.Stuart             Update logic for val_pr_diff_sfo to match that on CoEx (OP#:230101 Patch:20170830_1444_Adjustment_Views_Metrics_DWH_Support )
# 1.16  18.04.2018    Ulrich Meister             deactivate adjustment of quantities to SI entities
# 1.17  19.04.2018    Knopp.Timo                 Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
# 1.18  19.04.2018    Knopp,Timo                 Modification of access to core table lew_core.t_map_mis_move_type_2 / map_mis_move_type_deliv after renaming core-Table
# 1.19  25.04.2018    Ulrich Meister             store price now taken from the original loc_sid, not from the mapped loc_sid (in case of wh-writeoffs)
# 1.20  15.05.2018    Ulrich Meister             Konsolidierung Aenderungen 1.16.-1.19.
# 1.18  02.07.2018    Michael Ueding             Ermittlung WH Preis angepasst (Empfehlung von TGO)
# 1.19  03.07.2018    Michael Ueding             Korrektur Datenbankreferenz.
# 1.21  13.07.2020    Ekaterina Novgorodtseva    20200713_2531_item_loc_zero_writeoff
#                                                Changed logic in Artikelstamm to check the whether 
#                                                dwh_cal_dt instead of DATE fits in the validity_2 period.
# 1.22  18.12.2020    Thole.Jens                 Bugfix zu INC1927004 "AT / MIS lead / Abschriften_2 + PV im GJ 19 viel zu niedrig". Die in der Basistabelle vorliegende ship_qty hat 
#                                                wilde Vorzeichenfehler aufgrund mehrere hist. Aenderungen der Ladeparadigmen. Es wurde das urspruengliche Ladeparadigma hier nun hart codiert,
#                                                um den Datenbestand der Basistabelle nicht aendern zu muessen.
#                                                Es gilt nun wieder: Holl-Haben-KZ: ('H' -> negativ; sonst (i.a.'S') -> positiv)
# 1.23  19.02.2021    Prasanna Ranjan            REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
# 1.24  21.07.2021    Christian Marose           Fehlerhafte Reihenfolge bei den Comment-Statements korrigiert
# 1.25  14.09.2021    Marcin Malec               REP2-10349 - Rollback of REP2-9080 (should not apply for pv, writeoff, only sales_2)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_loc_sfo_zero_writeoff_2 (client_id OPTIONS(description='Landeskennzeichen'),
loc_sid_store OPTIONS(description='enthaelt surrogate Key des Stores'), orig_store_nr
OPTIONS(description='WAWI Quellsystemschluessel'), item_sid OPTIONS(description='Surrogate Key Item_2'), booking_date
OPTIONS(description='Buchungsdatum Artikelbeleg'), booking_month OPTIONS(description='Monat_2 Buchungsdatum Artikelbeleg'),
src_subitemgrp_cd OPTIONS(description='Subitemgroup / WAWI CD'), loc_sid_wh
OPTIONS(description='Warehouse - Eindeutige Identifizierung einer Lokation ueber alle Mandanten/Laender'), orig_wh_nr
OPTIONS(description='Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH)'), sfo_wawi_id
OPTIONS(description='Klassifizierung des Abschriftenbeleges'), map_use_cd OPTIONS(description='Default Wert = 4'),
pcwo_reason_id
OPTIONS(description='Eindeutige ID des Abschriften_2- bzw. PV-Grundes. Landesspezifische Abschriftengruende haben ID > 100.'),
ship_qty
OPTIONS(description='Menge in Erfassungsmengeneinheit - rohes Feld aus P_LEW_CORE.t_item_movement_record_pos_2; vorzeichenfehlerbehaftet'),
ship_qty_corr OPTIONS(description='Menge in Erfassungsmengeneinheit - [vorzeichenkorrigiert]'), numerator_si
OPTIONS(description='Zaehler fuer Umrechnung in SI Mengeneinheit'), denominator_si
OPTIONS(description='Nenner fuer Umrechnung in SI Mengeneinheit'), sfo_total_si_qty
OPTIONS(description='Menge (ggf. umgerechnet in SI Mengeneinheit) - [vorzeichenkorrigiert]'), sfo_total_qty
OPTIONS(description='Menge (in Erfassungsmengeneinheit, nicht umgerechnet in SI Mengeneinheit) - [vorzeichenkorrigiert]'),
sfo_wrtoff_zero_qty OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'),
sfo_total_store_val OPTIONS(description='GROSS price store * qty [vorzeichenkorrigiert]'), sfo_total_rtl_rl_val
OPTIONS(description='GROSS final SFO amount mapped, according to column sfo_type_cd  [vorzeichenkorrigiert]'),
sfo_wrtoff_zero_rtl_rl_val OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'),
sfo_total_store_net_val OPTIONS(description='NET price store * qty [vorzeichenkorrigiert]'), sfo_total_rtl_rl_net_val
OPTIONS(description='NET final SFO amount mapped, according to column sfo_type_cd [vorzeichenkorrigiert]'),
sfo_wrtoff_zero_rtl_rl_net_val OPTIONS(description='Logik aus Abinitio in View uebernommen default mit Wert 0'),
sfo_total_wh_val OPTIONS(description='GROSS price warehouse * qty [vorzeichenkorrigiert]'), sfo_total_wh_net_val
OPTIONS(description='NET price warehouse * qty [vorzeichenkorrigiert]'), val_pr_diff_sfo
OPTIONS(description='Val_Pr_k Bez. Einheit sfo'), val_pr_diff_net_sfo OPTIONS(description='Default mit NULL Werte'),
foodaction_fg OPTIONS(description='Foodactionflag'), sfo_wrtoff_zero_fa_qty
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'),
sfo_total_store_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann GROSS price store * qty ansonsten 0  [vorzeichenkorrigiert]'),
sfo_total_rtl_rl_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0 [vorzeichenkorrigiert]'),
sfo_wrtoff_zero_rtl_rl_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'),
sfo_total_store_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann NET price store * qty ansonsten 0 [vorzeichenkorrigiert]'),
sfo_total_rtl_rl_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0 [vorzeichenkorrigiert]'),
sfo_wrtoff_zero_rtl_rl_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'),
sfo_total_wh_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann GROSS price warehouse * qty ansonsten 0 [vorzeichenkorrigiert]'),
sfo_total_wh_net_fa_val
OPTIONS(description='Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann NET price warehouse * qty ansonsten 0 [vorzeichenkorrigiert]'),
item_movement_record_id OPTIONS(description='Artikelbeleg; SAP-Retail: mkpf.mblnr; SAP-BW: t_bw_2lis_03_bf.mblnr'),
item_movement_record_pos_id
OPTIONS(description='Position im Artikelbeleg; SAP-Retail: mseg.zeile; SAP-BW: t_bw_2lis_03_bf.zeile'))
OPTIONS(DESCRIPTION = `VIEW`) AS /* Referenz Store technisch */ /* Referenz Store fachlich */
/* Buchungsdatum Artikelbeleg */ /* Monat_2 Buchungsdatum Artikelbeleg */
/* Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH) */ /* Klassifizierung des Abschriftenbeleges */
/* SFO Typ: Vollabschrift */ /* Referenz Abschriftengrund fachlich */
/* Menge Vorzeichenkorrigiert (JT 20201216 - wegen Bug INC1927004 "AT / MIS lead / Abschriften_2 + PV im GJ 19 viel zu niedrig") */
/* Zaehler fuer Umrechnung in SI Mengeneinheit */ /* Nenner fuer Umrechnung in SI Mengeneinheit */
/* Menge (ggf. umgerechnet in SI Mengeneinheit) */
/* Es wird ab hier nur noch die vorzeichenkorrigierte Menge ship_qty_corr verwendet (JT 20201216 - wegen Bug INC1927004 "AT / MIS lead / Abschriften_2 + PV im GJ 19 viel zu niedrig") */
/* Die hier gebildeten 2 Alt-Felder sfo_total_si_qty/sfo_total_qty sind somit ebenfalls vorzeichenkorrigiert. */
/* Fuer weitere unten liegende Berechungen wurden bereits frueher nur das Feld sfo_total_qty verwandt, so dass weiter nichts geaendert werden musste. */
/* Menge in Erfassungsmengenheiheit */ /* Menge in Erfassungsmengenheiheit fuer relevante SFO Klassen */
/* Brutto Betrag Store */ /* Store Bruttopreis * Menge in SI Mengeneinheit */ /* Netto Betrag Store */
/* Store Nettopreis * Menge in SI Mengeneinheit */ /* Betraege WH */ /* WH Bruttopreis * Menge in SI Mengeneinheit */
/* WH Nettopreis * Menge in SI Mengeneinheit */
/* Brutto Differenz Store zu WH Preisen * Menge in Erfassungsmengenheiheit */
/* Berechnung deaktiviert nach Patch 1444 in Eco: ship_qty * (pr.cond_val_eff_calc - pr_wh.cond_val_eff_calc) END  -- Menge * Differenz Brutto Store WH */
/* Netto Differenz Store zu WH (als Brutto Differenz ohne Tax wie in aktueller Implementierung) */
/* Berechnung deaktiviert nach Patch 1444 in Eco: Cast(val_pr_diff_sfo * 100 / NullIfZero(pr.tax_rate_calc + 100) AS NUMERIC(19,5)) --Brutto Preisdifferenz ohne Tax */
/* Foodction Flag */ /* SFO Betrag und Mengen unter Beruecksichtigung des Foodaction Flags */
/* Referenz zum Bewegungsdatensatz */
/* Dies scheinen Warhouse-Locations zu sein die eine_2 ORIG_WH_ID haben, die gleichzeitig auch als ORIG_STORE_NR vorkommt und dementsprechend uebersetzt werden sollen */
/* warehouses */
/* Suche alle Locations deren ORIG.Store_Nr mit den WH_IDs der selektierten WH-Zeilen uebereinstimmen */
/* select only warehouse price conditions from the denorm table */ /* Ausschluss Artikelarten */ SELECT P.client_id,
 COALESCE(lm.loc_sid_store, P.loc_sid) AS loc_sid_store,
 W.src_orig_store_nr AS orig_store_nr,
 P.item_sid /* Referenz Item_2 technisch */,
 P.dwh_cal_dt AS booking_date,
 EXTRACT(MONTH FROM P.dwh_cal_dt) AS booking_month,
 H.src_subitemgrp_cd /* Referenz Subitemgroup aus Artikelhierarchie fachlich */,
 W.loc_sid_wh /* Referenz Warehouse technisch */,
 W.src_wh_id AS orig_wh_nr,
 SFO.mis_sfo_type_id AS sfo_wawi_id,
 SFO.map_use_id AS map_use_cd,
 COALESCE(PCWO.mis_pcwo_reason_id, - 1) AS pcwo_reason_id,
 P.ship_qty /* Menge in Erfassungsmengeneinheit */,
  ABS(P.ship_qty) * CASE
   WHEN P.deb_cred_cd = 'H'
   THEN - 1
   ELSE 1
   END AS ship_qty_corr,
 COALESCE(UOM.numerator_conv_si, 1) AS numerator_si,
 COALESCE(UOM.denominator_conv_si, 1) AS denominator_si,
   ABS(P.ship_qty) * CASE
    WHEN P.deb_cred_cd = 'H'
    THEN - 1
    ELSE 1
    END * (COALESCE(UOM.numerator_conv_si, 1) / CAST(COALESCE(UOM.denominator_conv_si, 1) AS NUMERIC)) AS
 sfo_total_si_qty,
  ABS(P.ship_qty) * CASE
   WHEN P.deb_cred_cd = 'H'
   THEN - 1
   ELSE 1
   END AS sfo_total_qty,
  CASE
  WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192)
  THEN ABS(P.ship_qty) * CASE
    WHEN P.deb_cred_cd = 'H'
    THEN - 1
    ELSE 1
    END
  ELSE 0.0000
  END AS sfo_wrtoff_zero_qty,
 ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
       WHEN P.deb_cred_cd = 'H'
       THEN - 1
       ELSE 1
       END) AS NUMERIC), 4) AS sfo_total_store_val,
 ROUND(CAST(COALESCE(ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
          WHEN P.deb_cred_cd = 'H'
          THEN - 1
          ELSE 1
          END) AS NUMERIC), 4), P.gross_price_val) AS NUMERIC), 4) AS sfo_total_rtl_rl_val,
  CASE
  WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192) /* fuer relevante SFO Klassen */
  THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
           WHEN P.deb_cred_cd = 'H'
           THEN - 1
           ELSE 1
           END) AS NUMERIC), 4), P.gross_price_val) AS NUMERIC), 4)
  ELSE 0.0000
  END AS sfo_wrtoff_zero_rtl_rl_val,
 ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
       WHEN P.deb_cred_cd = 'H'
       THEN - 1
       ELSE 1
       END) AS NUMERIC), 4) AS sfo_total_store_net_val,
 ROUND(CAST(COALESCE(ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
          WHEN P.deb_cred_cd = 'H'
          THEN - 1
          ELSE 1
          END) AS NUMERIC), 4), P.net_sales_val) AS NUMERIC), 4) AS sfo_total_rtl_rl_net_val,
  CASE
  WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192) /* fuer relevante SFO Klassen */
  THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
           WHEN P.deb_cred_cd = 'H'
           THEN - 1
           ELSE 1
           END) AS NUMERIC), 4), P.net_sales_val) AS NUMERIC), 4)
  ELSE 0.0000
  END AS sfo_wrtoff_zero_rtl_rl_net_val,
 ROUND(CAST(pr_wh.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
       WHEN P.deb_cred_cd = 'H'
       THEN - 1
       ELSE 1
       END) AS NUMERIC), 4) AS sfo_total_wh_val,
 ROUND(CAST(pr_wh.net_val_eff_calc * (ABS(P.ship_qty) * CASE
       WHEN P.deb_cred_cd = 'H'
       THEN - 1
       ELSE 1
       END) AS NUMERIC), 4) AS sfo_total_wh_net_val,
 CAST(NULL AS NUMERIC) AS val_pr_diff_sfo,
 CAST(NULL AS NUMERIC) AS val_pr_diff_net_sfo,
  CASE
  WHEN F.client_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS foodaction_fg,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192)
   THEN ABS(P.ship_qty) * CASE
     WHEN P.deb_cred_cd = 'H'
     THEN - 1
     ELSE 1
     END
   ELSE 0.0000
   END
  ELSE 0
  END AS sfo_wrtoff_zero_fa_qty,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
        WHEN P.deb_cred_cd = 'H'
        THEN - 1
        ELSE 1
        END) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_store_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
           WHEN P.deb_cred_cd = 'H'
           THEN - 1
           ELSE 1
           END) AS NUMERIC), 4), P.gross_price_val) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_rtl_rl_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192)
   THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
            WHEN P.deb_cred_cd = 'H'
            THEN - 1
            ELSE 1
            END) AS NUMERIC), 4), P.gross_price_val) AS NUMERIC), 4)
   ELSE 0.0000
   END
  ELSE 0
  END AS sfo_wrtoff_zero_rtl_rl_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
        WHEN P.deb_cred_cd = 'H'
        THEN - 1
        ELSE 1
        END) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_store_net_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
           WHEN P.deb_cred_cd = 'H'
           THEN - 1
           ELSE 1
           END) AS NUMERIC), 4), P.net_sales_val) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_rtl_rl_net_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN SFO.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192)
   THEN ROUND(CAST(COALESCE(ROUND(CAST(PR.net_val_eff_calc * (ABS(P.ship_qty) * CASE
            WHEN P.deb_cred_cd = 'H'
            THEN - 1
            ELSE 1
            END) AS NUMERIC), 4), P.net_sales_val) AS NUMERIC), 4)
   ELSE 0.0000
   END
  ELSE 0
  END AS sfo_wrtoff_zero_rtl_rl_net_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(pr_wh.cond_val_eff_calc * (ABS(P.ship_qty) * CASE
        WHEN P.deb_cred_cd = 'H'
        THEN - 1
        ELSE 1
        END) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_wh_fa_val,
  CASE
  WHEN CASE
    WHEN F.client_id IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN ROUND(CAST(pr_wh.net_val_eff_calc * (ABS(P.ship_qty) * CASE
        WHEN P.deb_cred_cd = 'H'
        THEN - 1
        ELSE 1
        END) AS NUMERIC), 4)
  ELSE 0
  END AS sfo_total_wh_net_fa_val,
 P.item_movement_record_id,
 P.item_movement_record_pos_id
FROM ldl_p_lew_core_ac.v_item_movement_record_pos_2 AS P
 LEFT JOIN (SELECT WH.loc_sid,
   WH.client_id,
   WH.wh_store_mark,
   ST.loc_sid AS loc_sid_store
  FROM ldl_p_lew_core_ac.v_location_2 AS WH
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS ST ON WH.src_wh_id = ST.src_orig_store_nr AND WH.client_id = ST.client_id
  ) AS lm ON P.loc_sid = lm.loc_sid AND P.client_id = lm.client_id /* Anhaengen nur aktueller Stores */
 INNER JOIN ldl_p_lew_bil.v_store_2 AS S ON P.client_id = S.client_id AND COALESCE(lm.loc_sid_store, P.loc_sid) = S.loc_sid_store
     AND S.dwh_actual_fg = 1 /* Artikelstamm */
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS I ON P.client_id = I.client_id AND P.item_sid = I.item_sid AND P.dwh_cal_dt
   BETWEEN I.dwh_valid_from AND I.dwh_valid_to /* edit */ /* Changed in V1.21 from DATE to p.dwh_cal_dt */
   /* Filterung gueltige SFO-Typen */
 INNER JOIN ldl_p_lew_core_ac.v_map_mis_move_type_2 AS SFO ON P.client_id = SFO.client_id AND P.move_type_cd = SFO.move_type_cd
       AND P.move_reason_cd = SFO.move_reason_cd AND (SFO.wh_store_mark = COALESCE(lm.wh_store_mark, 'A') OR SFO.wh_store_mark
       = '99999' /* Platzhalter fuer "egal" ob Filiale/Warehouse */) AND SFO.map_use_id = 1
   /* Normalfall Vollabschrift: map_use_id = 1 */ /* Stand 07/2017: SFO Typen 2 und 3 werden nicht mehr genutzt */
   /* Mapping zum Abschriftengrund (24.11.2015) */
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_pcwo_id_2 AS PCWO ON P.client_id = PCWO.client_id AND P.move_type_cd = PCWO.move_type_cd
     AND P.move_reason_cd = PCWO.move_reason_cd /* Ermittlung WH zu Store */
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown_2 AS W ON P.client_id = W.client_id AND COALESCE(lm.loc_sid_store
    , P.loc_sid) = W.loc_sid_store /* Ermittlung Filial Preis */
 LEFT JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm_2 AS PR ON P.client_id = PR.client_id AND P.item_sid = PR.item_sid
    AND P.loc_sid = PR.loc_sid AND I.uom_sid_base = PR.uom_sid_cond AND P.dwh_cal_dt BETWEEN PR.dwh_valid_from AND PR.dwh_valid_to
   /* Ermittlung WH Preis */
 LEFT JOIN (SELECT D.client_id,
   D.item_sid,
   D.loc_sid,
   D.uom_sid_cond,
   D.dwh_valid_from,
   D.dwh_valid_to,
   D.net_val_eff_calc,
   D.cond_val_eff_calc
  FROM ldl_p_lew_bil.v_item_loc_sales_cond_denorm_2 AS D
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS WH0 ON D.client_id = WH0.client_id AND D.loc_sid = WH0.loc_sid AND UPPER(WH0
      .wh_store_mark) = 'B' /* Warehouse */) AS pr_wh ON P.client_id = pr_wh.client_id AND P.item_sid = pr_wh.item_sid
    AND W.loc_sid_wh = pr_wh.loc_sid AND I.uom_sid_base = pr_wh.uom_sid_cond AND P.dwh_cal_dt BETWEEN pr_wh.dwh_valid_from
   AND pr_wh.dwh_valid_to /* Ermittlung WG Zuordnung ueber Hierarchie (nicht ueber Artikel_2 STammdaten) */
 LEFT JOIN ldl_p_lew_bil.v_item_hierarchy_2 AS H ON P.client_id = H.client_id AND P.item_sid = H.item_sid
   /* Ermittlung Umrechnungsfaktor fuer Basismengeneinheit in SI Einheit */
 LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_2 AS UOM ON P.client_id = UOM.client_id AND P.uom_sid_capt = UOM.uom_sid
   /* Referenz zu Artikelart zur Filterung der Artikelarten */
 INNER JOIN ldl_p_lew_core_ac.v_item_type_2 AS TT ON I.client_id = TT.client_id AND I.item_type_sid = TT.item_type_sid
   /* Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind */
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG ON TT.client_id = IG.client_id AND TT.src_mtart = IG.item_type_cd
     AND IG.item_type_grp_cd IN ('BAGLEVY', 'ADJ') /* Ermittlung Foodaction Flag */
 LEFT JOIN ldl_p_lew_bil.v_item_foodaction_hist_2 AS F ON P.client_id = F.client_id AND P.item_sid = F.item_sid AND P.dwh_cal_dt
   BETWEEN F.dwh_valid_from AND F.dwh_valid_to
WHERE IG.client_id IS NULL;