/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_ITEM_LOC_SFO_ZERO_WRITEOFF_1
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
# 1.12  07.02.2018    Thole.Jens                 V_ORG_STORE_SKEY_1 eliminiert und durch einfachen Join auf V_LOCATION_1 ersetzt. Test_1 mit Altversion ergab Identitaet.
# 1.13  28.02.2018    Taubkin. Slavik            Umstellung auf last_known Views
# 1.14  02.03.2018    Meister.Ulrich             Spaltenkommentare wieder hinzugefuegt
# 1.15  12.03.2018    Webster.Stuart             Update logic for val_pr_diff_sfo to match that on CoEx (OP#:230101 Patch:20170830_1444_Adjustment_Views_Metrics_DWH_Support )
# 1.16  18.04.2018    Ulrich Meister             deactivate adjustment of quantities to SI entities
# 1.17  19.04.2018    Knopp.Timo                 Modification of access to core table lew_core.t_map_mis_move_type_1 / map_mis_move_type_deliv after renaming core-Table
# 1.18  19.04.2018    Knopp,Timo                 Modification of access to core table lew_core.t_map_mis_move_type_1 / map_mis_move_type_deliv after renaming core-Table
# 1.19  25.04.2018    Ulrich Meister             store price now taken from the original loc_sid, not from the mapped loc_sid (in case of wh-writeoffs)
# 1.20  15.05.2018    Ulrich Meister             Konsolidierung Aenderungen 1.16.-1.19.
# 1.18  02.07.2018    Michael Ueding             Ermittlung WH Preis angepasst (Empfehlung von TGO)
# 1.19  03.07.2018    Michael Ueding             Korrektur Datenbankreferenz.
# 1.21  13.07.2020    Ekaterina Novgorodtseva    20200713_2531_item_loc_zero_writeoff
#                                                Changed logic in Artikelstamm to check the whether 
#                                                dwh_cal_dt instead of DATE fits in the validity_1 period.
# 1.22  18.12.2020    Thole.Jens                 Bugfix zu INC1927004 "AT / MIS lead / Abschriften_1 + PV im GJ 19 viel zu niedrig". Die in der Basistabelle vorliegende ship_qty hat 
#                                                wilde Vorzeichenfehler aufgrund mehrere hist. Aenderungen der Ladeparadigmen. Es wurde das urspruengliche Ladeparadigma hier nun hart codiert,
#                                                um den Datenbestand der Basistabelle nicht aendern zu muessen.
#                                                Es gilt nun wieder: Holl-Haben-KZ: ('H' -> negativ; sonst (i.a.'S') -> positiv)
# 1.23  19.02.2021    Prasanna Ranjan            REP2-9080 - Include item_1 types ZKM and ZVM from USA and Serbia
# 1.24  21.07.2021    Christian Marose           Fehlerhafte Reihenfolge bei den Comment-Statements korrigiert
# 1.25  14.09.2021    Marcin Malec               REP2-10349 - Rollback of REP2-9080 (should not apply for pv, writeoff, only sales_1)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_LOC_SFO_ZERO_WRITEOFF_1 COMMENT = 'View'
( 
     client_id                                  COMMENT 'Landeskennzeichen'
    ,loc_sid_store                              COMMENT 'enthaelt surrogate Key des Stores'
    ,orig_store_nr                              COMMENT 'WAWI Quellsystemschluessel'
    ,item_sid                                   COMMENT 'Surrogate Key Item_1'
    ,booking_date                               COMMENT 'Buchungsdatum Artikelbeleg'	
    ,booking_month                              COMMENT 'Monat_1 Buchungsdatum Artikelbeleg'
    ,src_subitemgrp_cd                          COMMENT 'Subitemgroup / WAWI CD'
    ,loc_sid_wh                                 COMMENT 'Warehouse - Eindeutige Identifizierung einer Lokation ueber alle Mandanten/Laender'
    ,orig_wh_nr                                 COMMENT 'Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH)'
    ,sfo_wawi_id                                COMMENT 'Klassifizierung des Abschriftenbeleges'
    ,map_use_cd                                 COMMENT 'Default Wert = 4'
    ,pcwo_reason_id                             COMMENT 'Eindeutige ID des Abschriften_1- bzw. PV-Grundes. Landesspezifische Abschriftengruende haben ID > 100.'
    ,ship_qty                                   COMMENT 'Menge in Erfassungsmengeneinheit - rohes Feld aus P_LEW_CORE.t_item_movement_record_pos_1; vorzeichenfehlerbehaftet'
    ,ship_qty_corr                              COMMENT 'Menge in Erfassungsmengeneinheit - [vorzeichenkorrigiert]'
    ,numerator_si                               COMMENT 'Zaehler fuer Umrechnung in SI Mengeneinheit'
    ,denominator_si                             COMMENT 'Nenner fuer Umrechnung in SI Mengeneinheit'
    ,sfo_total_si_qty                           COMMENT 'Menge (ggf. umgerechnet in SI Mengeneinheit) - [vorzeichenkorrigiert]'
    ,sfo_total_qty                              COMMENT 'Menge (in Erfassungsmengeneinheit, nicht umgerechnet in SI Mengeneinheit) - [vorzeichenkorrigiert]'
    ,sfo_wrtoff_zero_qty                        COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,sfo_total_store_val                        COMMENT 'GROSS price store * qty [vorzeichenkorrigiert]'
    ,sfo_total_rtl_rl_val                       COMMENT 'GROSS final SFO amount mapped, according to column sfo_type_cd  [vorzeichenkorrigiert]'
    ,sfo_wrtoff_zero_rtl_rl_val                 COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,sfo_total_store_net_val                    COMMENT 'NET price store * qty [vorzeichenkorrigiert]'
    ,sfo_total_rtl_rl_net_val                   COMMENT 'NET final SFO amount mapped, according to column sfo_type_cd [vorzeichenkorrigiert]'
    ,sfo_wrtoff_zero_rtl_rl_net_val             COMMENT 'Logik aus Abinitio in View uebernommen default mit Wert 0'
    ,sfo_total_wh_val                           COMMENT 'GROSS price warehouse * qty [vorzeichenkorrigiert]'
    ,sfo_total_wh_net_val                       COMMENT 'NET price warehouse * qty [vorzeichenkorrigiert]'
    ,val_pr_diff_sfo                            COMMENT 'Val_Pr_k Bez. Einheit sfo'
    ,val_pr_diff_net_sfo                        COMMENT 'Default mit NULL Werte'
    ,foodaction_fg                              COMMENT 'Foodactionflag'
    ,sfo_wrtoff_zero_fa_qty                     COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_qty ansonsten 0'
    ,sfo_total_store_fa_val                     COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann GROSS price store * qty ansonsten 0  [vorzeichenkorrigiert]'
    ,sfo_total_rtl_rl_fa_val                    COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_val ansonsten 0 [vorzeichenkorrigiert]'
    ,sfo_wrtoff_zero_rtl_rl_fa_val              COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_val ansonsten 0'
    ,sfo_total_store_net_fa_val                 COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann NET price store * qty ansonsten 0 [vorzeichenkorrigiert]'
    ,sfo_total_rtl_rl_net_fa_val                COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_total_rtl_rl_net_val ansonsten 0 [vorzeichenkorrigiert]'	
    ,sfo_wrtoff_zero_rtl_rl_net_fa_val          COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann sfo_wrtoff_zero_rtl_rl_net_val  ansonsten 0'	
    ,sfo_total_wh_fa_val                        COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann GROSS price warehouse * qty ansonsten 0 [vorzeichenkorrigiert]'	
    ,sfo_total_wh_net_fa_val                    COMMENT 'Benoetigt fuer die Aggregation - wenn foodaction_flag = 1 dann NET price warehouse * qty ansonsten 0 [vorzeichenkorrigiert]'	
    ,item_movement_record_id                    COMMENT 'Artikelbeleg; SAP-Retail: mkpf.mblnr; SAP-BW: t_bw_2lis_03_bf.mblnr'
    ,item_movement_record_pos_id                COMMENT 'Position im Artikelbeleg; SAP-Retail: mseg.zeile; SAP-BW: t_bw_2lis_03_bf.zeile'	
)

AS

SELECT
   p.client_id
  ,COALESCE(lm.loc_sid_store,p.loc_sid) AS loc_sid_store  /* Referenz Store technisch*/
  ,w.src_orig_store_nr AS orig_store_nr /* Referenz Store fachlich*/
  ,p.item_sid  /* Referenz Item_1 technisch*/
  ,p.dwh_cal_dt AS booking_date /* Buchungsdatum Artikelbeleg*/
  ,EXTRACT(MONTH FROM p.dwh_cal_dt) AS booking_month /* Monat_1 Buchungsdatum Artikelbeleg*/
  ,h.src_subitemgrp_cd  /* Referenz Subitemgroup aus Artikelhierarchie fachlich*/
  ,w.loc_sid_wh  /* Referenz Warehouse technisch*/
  ,w.src_wh_id AS orig_wh_nr  /* Referenz Warhouse fachlich (entspricht der wh_id aus WAWI DWH)*/
  ,sfo.mis_sfo_type_id AS sfo_wawi_id  /* Klassifizierung des Abschriftenbeleges*/
  ,sfo.map_use_id AS map_use_cd  /* SFO Typ: Vollabschrift*/
  ,COALESCE(pcwo.mis_pcwo_reason_id, -1) AS pcwo_reason_id /* Referenz Abschriftengrund fachlich*/
  ,p.ship_qty  /* Menge in Erfassungsmengeneinheit*/
  ,ABS(p.ship_qty) * CASE WHEN p.deb_cred_cd='H' THEN (-1) ELSE 1 END ship_qty_corr /* Menge Vorzeichenkorrigiert (JT 20201216 - wegen Bug INC1927004 "AT / MIS lead / Abschriften_1 + PV im GJ 19 viel zu niedrig")*/
  ,COALESCE(uom.numerator_conv_si, 1) AS numerator_si  /* Zaehler fuer Umrechnung in SI Mengeneinheit*/
  ,COALESCE(uom.denominator_conv_si, 1) AS denominator_si  /* Nenner fuer Umrechnung in SI Mengeneinheit*/
   /* Menge (ggf. umgerechnet in SI Mengeneinheit) */
   /* Es wird ab hier nur noch die vorzeichenkorrigierte Menge ship_qty_corr verwendet (JT 20201216 - wegen Bug INC1927004 "AT / MIS lead / Abschriften_1 + PV im GJ 19 viel zu niedrig")*/
   /* Die hier gebildeten 2 Alt-Felder sfo_total_si_qty/sfo_total_qty sind somit ebenfalls vorzeichenkorrigiert. */
   /* Fuer weitere unten liegende Berechungen wurden bereits frueher nur das Feld sfo_total_qty verwandt, so dass weiter nichts geaendert werden musste.*/
  ,ship_qty_corr * (numerator_si/to_number(denominator_si, 18, 4)) AS sfo_total_si_qty
  ,ship_qty_corr AS sfo_total_qty /* Menge in Erfassungsmengenheiheit*/
 /* Menge in Erfassungsmengenheiheit fuer relevante SFO Klassen*/
  ,CASE WHEN sfo.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192)
        THEN sfo_total_qty
        ELSE 0.0000
   END AS sfo_wrtoff_zero_qty
   /* Brutto Betrag Store*/
  ,to_number(pr.cond_val_eff_calc * sfo_total_qty, 18, 4) AS sfo_total_store_val /* Store Bruttopreis * Menge in SI Mengeneinheit*/
  ,to_number(COALESCE(sfo_total_store_val, gross_price_val), 18, 4) AS sfo_total_rtl_rl_val
  ,CASE WHEN sfo.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192) /* fuer relevante SFO Klassen*/
        THEN sfo_total_rtl_rl_val
        ELSE 0.0000
   END sfo_wrtoff_zero_rtl_rl_val
   /* Netto Betrag Store*/
  ,to_number(pr.net_val_eff_calc * sfo_total_qty, 18, 4) AS sfo_total_store_net_val /* Store Nettopreis * Menge in SI Mengeneinheit*/
  ,to_number(COALESCE(sfo_total_store_net_val, net_sales_val), 18, 4) AS sfo_total_rtl_rl_net_val
  ,CASE WHEN sfo.mis_sfo_type_id IN (137, 147, 181, 182, 191, 192) /*fuer relevante SFO Klassen*/
        THEN sfo_total_rtl_rl_net_val
        ELSE 0.0000
   END sfo_wrtoff_zero_rtl_rl_net_val
   /* Betraege WH*/
  ,to_number(pr_wh.cond_val_eff_calc * sfo_total_qty, 18, 4) AS sfo_total_wh_val /* WH Bruttopreis * Menge in SI Mengeneinheit*/
  ,to_number(pr_wh.net_val_eff_calc * sfo_total_qty, 18, 4) AS sfo_total_wh_net_val /* WH Nettopreis * Menge in SI Mengeneinheit*/
   /* Brutto Differenz Store zu WH Preisen * Menge in Erfassungsmengenheiheit*/
  ,to_number(NULL, 18, 4) AS val_pr_diff_sfo /*Berechnung deaktiviert nach Patch 1444 in Eco: ship_qty * (pr.cond_val_eff_calc - pr_wh.cond_val_eff_calc) END  -- Menge * Differenz Brutto Store WH*/
   /* Netto Differenz Store zu WH (als Brutto Differenz ohne Tax wie in aktueller Implementierung)*/
  ,to_number(NULL, 19, 5) AS val_pr_diff_net_sfo /*Berechnung deaktiviert nach Patch 1444 in Eco: Cast(val_pr_diff_sfo * 100 / NullIfZero(pr.tax_rate_calc + 100) AS DECIMAL(19,5)) --Brutto Preisdifferenz ohne Tax*/
   /* Foodction Flag*/
  ,CASE WHEN f.client_id IS NOT NULL
        THEN 1
        ELSE 0
   END AS foodaction_fg
   /* SFO Betrag und Mengen unter Beruecksichtigung des Foodaction Flags*/
  ,CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_qty            ELSE 0 END AS sfo_wrtoff_zero_fa_qty
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_store_val            ELSE 0 END AS sfo_total_store_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_val           ELSE 0 END AS sfo_total_rtl_rl_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_val     ELSE 0 END AS sfo_wrtoff_zero_rtl_rl_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_store_net_val        ELSE 0 END AS sfo_total_store_net_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_rtl_rl_net_val       ELSE 0 END AS sfo_total_rtl_rl_net_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_wrtoff_zero_rtl_rl_net_val ELSE 0 END AS sfo_wrtoff_zero_rtl_rl_net_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_wh_val               ELSE 0 END AS sfo_total_wh_fa_val
  ,CASE WHEN foodaction_fg = 1 THEN sfo_total_wh_net_val           ELSE 0 END AS sfo_total_wh_net_fa_val
  /*Referenz zum Bewegungsdatensatz*/
  ,p.item_movement_record_id
  ,p.item_movement_record_pos_id

FROM P_LEW_CORE_AC.v_item_movement_record_pos_1 p

LEFT OUTER JOIN
(
  /*Dies scheinen Warhouse-Locations zu sein die eine_1 ORIG_WH_ID haben, die gleichzeitig auch als ORIG_STORE_NR vorkommt und dementsprechend uebersetzt werden sollen*/
  SELECT
    wh.loc_sid
   ,wh.client_id
   ,wh.wh_store_mark
   ,st.loc_sid loc_sid_store
  FROM P_LEW_CORE_AC.v_location_1 wh /*warehouses*/
  /* Suche alle Locations deren ORIG.Store_Nr mit den WH_IDs der selektierten WH-Zeilen uebereinstimmen*/

  INNER JOIN P_LEW_CORE_AC.v_location_1 st
  ON wh.src_wh_id=st.src_orig_store_nr
    AND wh.client_id=st.client_id
) lm
ON p.loc_sid=lm.loc_sid
  AND p.client_id = lm.client_id
  
/* Anhaengen nur aktueller Stores*/
INNER JOIN P_LEW_BIL.v_store_1 s
ON p.client_id = s.client_id
  AND COALESCE(lm.loc_sid_store,p.loc_sid) = s.loc_sid_store
  AND s.dwh_actual_fg = 1

/*Artikelstamm*/
INNER JOIN P_LEW_CORE_AC.v_item_hist_1 i
ON p.client_id = i.client_id
  AND p.item_sid = i.item_sid
  AND p.dwh_cal_dt BETWEEN i.dwh_valid_from AND i.dwh_valid_to                /* edit*/
  /*Changed in V1.21 from DATE to p.dwh_cal_dt*/

/* Filterung gueltige SFO-Typen */
INNER JOIN P_LEW_CORE_AC.v_map_mis_move_type_1 sfo
ON p.client_id = sfo.client_id
  AND p.move_type_cd = sfo.move_type_cd
  AND p.move_reason_cd = sfo.move_reason_cd
  AND (sfo.wh_store_mark = COALESCE(lm.wh_store_mark,'A') OR sfo.wh_store_mark = '99999' /*Platzhalter fuer "egal" ob Filiale/Warehouse*/)
  AND sfo.map_use_id = 1 /* Normalfall Vollabschrift: map_use_id = 1 */
  /*Stand 07/2017: SFO Typen 2 und 3 werden nicht mehr genutzt*/

/* Mapping zum Abschriftengrund (24.11.2015) */
LEFT OUTER JOIN P_LEW_CORE_AC.v_map_mis_pcwo_id_1 pcwo
ON p.client_id = pcwo.client_id
  AND p.move_type_cd = pcwo.move_type_cd
  AND p.move_reason_cd = pcwo.move_reason_cd

/*Ermittlung WH zu Store*/
INNER JOIN P_LEW_BIL.v_store_to_warehouse_lastknown_1 w
ON p.client_id = w.client_id
  AND COALESCE(lm.loc_sid_store,p.loc_sid) = w.loc_sid_store

/*Ermittlung Filial Preis */
LEFT OUTER JOIN P_LEW_BIL.v_item_loc_sales_cond_denorm_1 pr
ON p.client_id = pr.client_id
  AND p.item_sid = pr.item_sid
  AND p.loc_sid = pr.loc_sid
  AND i.uom_sid_base = pr.uom_sid_cond
  AND p.dwh_cal_dt BETWEEN pr.dwh_valid_from AND pr.dwh_valid_to

/*Ermittlung WH Preis */
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
 
  INNER JOIN P_LEW_CORE_AC.v_location_1 wh
  ON wh.client_id = d.client_id 
    AND wh.loc_sid = d.loc_sid
    AND Upper(wh.wh_store_mark) = 'B'  /* Warehouse*/
) pr_wh
ON p.client_id = pr_wh.client_id
  AND p.item_sid = pr_wh.item_sid
  AND w.loc_sid_wh = pr_wh.loc_sid
  AND i.uom_sid_base = pr_wh.uom_sid_cond
  AND p.dwh_cal_dt BETWEEN pr_wh.dwh_valid_from AND pr_wh.dwh_valid_to

/*Ermittlung WG Zuordnung ueber Hierarchie (nicht ueber Artikel_1 STammdaten)*/
LEFT OUTER JOIN P_LEW_BIL.v_item_hierarchy_1 h
ON p.client_id = h.client_id
  AND p.item_sid = h.item_sid

/*Ermittlung Umrechnungsfaktor fuer Basismengeneinheit in SI Einheit*/
LEFT OUTER JOIN P_LEW_CORE_AC.v_unit_of_measurement_1 uom
ON p.client_id = uom.client_id
  AND p.uom_sid_capt = uom.uom_sid

/*Referenz zu Artikelart zur Filterung der Artikelarten*/
INNER JOIN P_LEW_CORE_AC.v_item_type_1 tt
ON i.client_id = tt.client_id
  AND i.item_type_sid = tt.item_type_sid

/*Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind*/
LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore_1 ig
ON tt.client_id = ig.client_id
  AND tt.src_mtart = ig.item_type_cd
  AND ig.item_type_grp_cd IN ('BAGLEVY', 'ADJ')

/*Ermittlung Foodaction Flag */
LEFT OUTER JOIN P_LEW_BIL.v_item_foodaction_hist_1 f
ON p.client_id = f.client_id
  AND p.item_sid = f.item_sid
  AND p.dwh_cal_dt BETWEEN f.dwh_valid_from AND f.dwh_valid_to

WHERE ig.client_id IS NULL /*Ausschluss Artikelarten */
;
