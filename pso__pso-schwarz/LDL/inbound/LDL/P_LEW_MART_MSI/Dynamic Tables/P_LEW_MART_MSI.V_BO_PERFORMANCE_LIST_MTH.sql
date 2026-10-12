
/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO
  Source
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST
      V_BO_PERF_CAL_LIST_MTH
  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_performance_list_mth.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.

  Comments from the original Teradata DDL:
  Created by Jens Thole
  on 14.06.2018
  Inhalt: finale Zielstruktur der Monatsebenen-Schnittstelle der BO_PERORMANCE_LIST
  Quellen: MART_MSI:t_bo_base_performance_list (alleinige Basisstruktur)
  Die aus Tages- und Wochenebene bekannte Standardeinschränkung auf Datensätze unterhalb des jeweiligen Store-closing-Datums (Gewinnerstore)
  findet hier NICHT statt (warum auch immer...).
  Relevante Measure-Values werden ermittelt.
 
  SONDERBEDINGUNGEN AUFGRUND VON ÄNDERUNGEN IM VERGLEICH ZUR ÜBERKOMMENEN ALTSTRUKTUR:
  Bereich Umsätze "[A,B,C]-Regel":
  Früher wurden Auswahlen getroffen bzgl der Frage,
  ob das Datum des Umsatzes
      a) im Raum zwischen den Store-Attributen (WAWI) dat_calc_start_py und dat_calc_end_py liegen
      b) bzw. in ein hinten offenes Intervall dieser Attribute fallen
      c) bzw. auch hinter das Intervall fallen - bei wegfusionierten Stores
  Die dies erfüllenden Umsatzeilen wiesen die Felder val_retail, val_retail_net,cnt_customer erneut aus - diesmal mit dem Suffix "_ber" .
  Hierbei trat der (theoretische) Fall auf, daß bei nicht gesetztem CALC_Start-Datum der Wert ausgeblendet wurde (was wohl nicht intendiert war)
  Desweiteren ergibt eine Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status vorliegt,
  der keine Aktivität ermöglicht.
  Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
  Ein Test ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
  Für die Zielstruktur-Kompatibilität wurden die ..._ber-Felder als Duplikate der Originalfelder ausgewiesen
  Desweiteren wurde über diese Felder eine Inline-Summe gebildet und diese jeweils dem überlebenden (Gewinner-)Store zugewiesen.
  Dies ist mit der bisherigen Argumentation obsolet.
  In einer Fehlinterpretation des Namings wurden diese zudem mit einem weiteren Suffix: _top20 versehen, was an dieser Stelle völlig absurd ist,
  da keinerlei Ranking stattfindet - bestenfalls sind diese Felder für das Ranking vorgesehen gewesen. Dies entfällt nun ebenso und deren Platz nehmen die Originale ein
 
  Im Original wurde hierzu zu jedem Salesdatum der in v_cal_month_ber hinterlegte Folgejahrestag zugeordnet und mit diesem nun die gleiche
  Frage wie oben [a),b),c)] beantwortet, um die jeweiligen ..._ber oder ...ber_top20-Derivate zu finden.
  Dies ist hinfällig, wenn man obiger Argumentation analog folgt und alle historischen
  Sales-Zeilen konsequent dem Gewinnerstore zuordnet
  Granularität (Gewinnerstore,
                 DatenMonat (für PreviousYear-Felder um ein Jahr ins CurrentYear "shiftet" und dem jeweiligen Current-Monat zugeschlagen),
                 Reportwoche (Week-Page= Wochenauswahl nach MART_MSI:v_bo_perf_cal_list_mth;
                               jede der Reportwochen enthält die 4 notwendigen Auswahlintervalle, unterschieden nach
                                                        * Plandaten / Istdaten
                                                    sowie nach
                                                        * CurrentYear / PreviousYear
                              Startpunkt ist der jeweils der RepWoche zugeordnete Geschäftsjahresanfang (für PY: ein Jahr in die Vergangenheit)
                              Endpunkt ist der jeweils der RepWoche zugeordnete, modifizierte Wochenendtag (für Plan der zugeordnete Planmonatsendtag); PY -analyog ein Jahr davon zurück
                             )
                 )
  Es findet ein Ranking der Stores innerhalb seiner Warehouse-Monats-Gruppe nach diversen Kennzahle statt, die leider in der Zielsignatur nicht vorkommen,
  aber zum Verständnis diverser Zielfelder benötigt werden statt. Alle Values sind natürlich Gruppensummen bzgl der Zielgranularität
  - val_retail_incr_adj: relatives Jahresdelta des Umsatzes: (val_retail - val_retail_py) / val_retail_py
  - val_retail_net_incr_adj: relatives Jahresdelta des NettoUmsatzes: (val_retail_net - val_retail_net_py) / val_retail_net_py
  - act_productivity: Produktivität auf Basis Bruttoumsatz: val_retail_calc_prod_diff / (hrs_calc_prod_diff+miss_times_perf_calc_prod_diff)
                  letztlich jeweils modifizierte Summen bis zum früheren Datum aus (MaximalesUmsatzdatum; Maximales Arbeitsstundendatum) in der jeweiligen Wochenseite
                        val_retail / (time_working_netto_std + miss_times_perf)
  - act_productivity_net: Produktivität auf Basis Bruttoumsatz: val_retail_calc_prod_diff_net / (hrs_calc_prod_diff+miss_times_perf_calc_prod_diff)
                  letztlich jeweils modifizierte Summen bis zum früheren Datum aus (MaximalesUmsatzdatum; Maximales Arbeitsstundendatum) in der jeweiligen Wochenseite
                        val_retail_net / (time_working_netto_std + miss_times_perf)
  - diff_py_val_retail_pct: relatives Jahresdelta des Umsatzes; val_retail_incr_adj in Prozent
                      100 * (val_retail - val_retail_py) / val_retail_py
  - diff_py_val_retail_net_pct: relatives Jahresdelta des NettoUmsatzes; val_retail_net_incr_adj in Prozent
                      100 * (val_retail_net - val_retail_net_py) / val_retail_net_py
  - rnk_prod: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld act_productivity)
  - rnk_prod_net: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld act_productivity)
  - rnk_diff_py_val_retail_pct: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld diff_py_val_retail_pct)
  - rnk_diff_py_val_retail_net_pct: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld diff_py_val_retail_net_pct)
  - rnk_val_retail_incr_adj: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld val_retail_incr_adj)
  - rnk_val_retail_net_incr_adj: Ranking der Stores pro Warehouse-Monat nach Produktivität auf Basis Bruttoumsatz (Feld val_retail_net_incr_adj)
    Die Rankings (rnk_diff_py_val_retail_pct,rnk_diff_py_val_retail_net_pct) sind naturgemäß absolut gleich zu (rnk_val_retail_incr_adj,rnk_val_retail_net_incr_adj)
    Früher waren diese unterschiedlich!. Für die letzte Rankingruppe wurde eine Summe über alle die "[A,B,C]-Regel" einhaltenden Umsätze über alle Verliererstores nur dem Gewinnerstore zugewiesen.
    Da früher alle Stores ausgewiesen wurden (auch die Verlierer) hatten die Umsatzvalue-Varianten für den Gewinnerstore differierende Werte.
    Beipiel val_retail:
    Feld val_retail_asis enthielt die (nackten) Werte aus der Umsatzlieferung
    Feld val_retail_ber  enthielt die (nackten) Werte aus der Umsatzlieferung, eingeschränkt auf die "[A,B,C]-Regel" - (eigene Analysen fanden keinen Fall einer Differenz - aber gut, prinzipiell ist's möglich).
    Feld val_retail_ber_top20 enthielt die (nackten) Werte aus der Umsatzlieferungdes eigenen Stores eingeschränkt auf die "[A,B,C]-Regel", sowie alle Werte der in diesen Store eingegangenen historischen Stores,
    sofern auch deren Umsätze der "[A,B,C]-Regel" genügten.
    Da nun val_retail_incr_adj auf Basis der ..._ber_top20-Varianten gebildet wurde und diff_py_val_retail_pct auf Bais der ...asis-Varianten, konnten die Rankings damals abweichen.
    Nun gibt es sozusagen nur noch die TOP20-Werte, da wir von vornherein auf Gewinnerstorebene operieren. und die "[A,B,C]-Regel" wird ignoriert aufgrund obiger Argumentation
*/

CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_MTH COMMENT = 'Schnittstellenview Cube-Beladung BO. Performancelist MONTH'
(
    client_id                       COMMENT 'DWH-Client im DWH = LIDL-Land (country)'
  , country_desc                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , country_id                      COMMENT '= client_id'
  , country_iso_cd                  COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , store_id                        COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                   COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                      COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store -> letztlich aus Core:t_location'
  , city                            COMMENT 'AUS CORE.t_address'
  , wh_id                           COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , wh_desc                         COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , sales_manager_id                COMMENT 'AUS BIL:v_location_organization'
  , sales_manager_name              COMMENT 'AUS BIL:v_location_organization'
  , account_manager_id              COMMENT 'AUS BIL:v_location_organization'
  , account_manager_name            COMMENT 'AUS BIL:v_location_organization'
  , week_page_by                    COMMENT 'Wochenseite (für Reporting): Jede Reportingwoche, klammert die 12 der RepWoche vorangehenden Datenwochen (sofern in der Grundauswahl verfügbar)'
  , cy_month                        COMMENT 'Monat zum Fakten-Kalendertag'
  , currency_iso_cd                 COMMENT 'AUS CORE:v_client'
  , plan_val_turnover               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_turnover_py            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_val_turnover_net_py        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_turnover_calc_ums_diff     COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_ums_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!). Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_prod_diff    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_turnover_calc_pro_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!). Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_sales_qty_calc_abv_diff    COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces. Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff   COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces. Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours. Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_hours_calc_prod_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_val_hours                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_hours_py               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_val_inv_training           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_val_inv_training_py        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training). Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_asis                 COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis             COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , val_retail_ber                  COMMENT 'identisch zu Feld val_retail_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_net_ber              COMMENT 'identisch zu Feld val_retail_net_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_asis_py              COMMENT 'CORE:v_agg_sales_store_day.val_retail. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_net_asis_py          COMMENT 'CORE:v_agg_sales_store_day.val_retail_net. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_calc_prod_diff       COMMENT 'CORE:v_agg_sales_store_day.val_retail. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_retail_calc_prod_diff_net   COMMENT 'CORE:v_agg_sales_store_day.val_retail_net. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_retail_calc_prod_diff_py    COMMENT 'CORE:v_agg_sales_store_day.val_retail (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_rtl_calc_prod_dif_net_py    COMMENT 'CORE:v_agg_sales_store_day.val_retail_net (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , cnt_customer_asis               COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , cnt_customer_ber                COMMENT ''
  , cnt_customer_asis_py            COMMENT 'CORE:v_agg_sales_store_day.cnt_customer. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , sales_pieces_ber                COMMENT 'Identisch zu Feld sales_qty_asis (Siehe View-Kopfkommentar im Quelltext)'
  , sales_pieces_py                 COMMENT 'CORE:v_agg_sales_store_day.sales_qty_asis. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , time_working_netto_std          COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , time_working_netto_std_py       COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , miss_times_perf                 COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , miss_times_perf_py              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , hrs_calc_prod_diff              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , hrs_calc_prod_diff_py           COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , miss_times_perf_calc_prod_diff  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , miss_times_p_calc_prod_diff_py  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , diff_hours                      COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'
  , sales_qty_asis                  COMMENT 'Abverkaufte Stück/Kg IST'
  , sales_qty_py                    COMMENT ''
  , plan_sales_qty                  COMMENT 'Plan Abverkaufte Stück/Kg'
  , piece_perf_asis                 COMMENT 'Stückleistung IST'
  , piece_perf_py                   COMMENT 'Stückleistung IST Vergangenes Jahr'
  , plan_perf_piece                 COMMENT 'Plan Stückleistung'
  , item_price_asis                 COMMENT 'Durschnittliche Artikelpreis Ist'
  , diff_sales_qty_asis_pct         COMMENT 'Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'
  , diff_piece_perf_asis_pct        COMMENT 'Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'
  , diff_py_val_piece_perf          COMMENT 'Unterschied zum Vorjahr Stückleistung'
  , top_20_val_retail_productivity  COMMENT 'Warehouse-Monatssumme val_retail_asis der Ranking (Feld rnk_prod) top-20-platzierten  Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_productivity  COMMENT 'Warehouse-Monatssumme val_retail_net_asis der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_time_wrk_productivity    COMMENT 'Warehouse-Monatssumme time_working_netto_std der nach Ranking (Feld rnk_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_time_wrk_prod_net         COMMENT 'Warehouse-Monatssumme time_working_netto_std der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_miss_times_perf_prod     COMMENT 'Warehouse-Monatssumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_miss_times_perf_prod_net  COMMENT 'Warehouse-Monatssumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_for_diff      COMMENT 'Warehouse-Monatssumme val_retail_asis (Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_net_for_diff  COMMENT 'Warehouse-Monatssumme val_retail_net_asis (Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_net_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_for_diff_py   COMMENT 'Warehouse-Monatssumme val_retail_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_for_diff_py   COMMENT 'Warehouse-Monatssumme val_retail_net_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_net_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_ret_for_incr_adj     COMMENT 'Warehouse-Monatssumme val_retail_asis (Umsatz) der nach Ranking (Feld rnk_val_retail_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_for_incr_adj  COMMENT 'Warehouse-Monatssumme val_retail_net_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_net_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_ret_py_for_incr_adj  COMMENT 'Warehouse-Monatssumme val_retail_net_asis (Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_net_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_py_incr_adj   COMMENT 'Warehouse-Monatssumme val_retail_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_sales_qty_piece_perf     COMMENT 'Warehouse-Monatssumme sales_qty_asis der Ranking (Feld rnk_piece_perf) top-20-platzierten  Stores'
  , top_20_time_wrk_piece_perf      COMMENT 'Warehouse-Monatssumme time_working_netto_std der Ranking (Feld rnk_piece_perf) top-20-platzierten  Stores'
  , top_20_miss_times_piece_perf    COMMENT 'Warehouse-Monatssumme miss_times_perf der Ranking (Feld rnk_piece_perf) top-20-platzierten  Stores'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
         client_id
       , country_desc
       , country_id
       , country_iso_cd
       , loc_sid_store                             AS store_id
       , orig_store_nr
       , used_store_desc                           AS store_desc
       , city
       , src_wh_id                                 AS wh_id
       , used_wh_desc                              AS wh_desc
       , sales_manager_id
       , sales_manager_name
       , account_manager_id
       , account_manager_name
       , week_page_by
       , cy_month_shifted                          AS cy_month
       , curr_cd                                   AS currency_iso_cd
       , plan_val_turnover
       , plan_val_turnover_net
       , plan_val_turnover_py
       , plan_val_turnover_net_py
       , plan_turnover_calc_ums_diff
       , plan_turnover_calc_ums_dif_net
       , plan_turnover_calc_prod_diff
       , plan_turnover_calc_pro_dif_net
       , plan_sales_qty_calc_abv_diff
       , plan_sales_qty_calc_prod_diff
       , plan_hours_calc_hrs_diff
       , plan_hours_calc_prod_diff
       , plan_val_hours
       , plan_val_hours_py
       , plan_val_inv_training
       , plan_val_inv_training_py
       , val_retail                                AS val_retail_asis
       , val_retail_net                            AS val_retail_net_asis
       /* sinnlos-Duplikat:  */
       , val_retail                                AS val_retail_ber
       , val_retail_net                            AS val_retail_net_ber
       , val_retail_py                             AS val_retail_asis_py
       , val_retail_net_py                         AS val_retail_net_asis_py
       , val_retail_calc_prod_diff
       , val_retail_calc_prod_diff_net
       , val_retail_calc_prod_diff_py
       , val_rtl_calc_prod_dif_net_py
       , cnt_customer                              AS cnt_customer_asis
       , cnt_customer                              AS cnt_customer_ber
       , cnt_customer_py                           AS cnt_customer_asis_py
       , sales_qty_asis                            AS sales_pieces_ber
       , sales_qty_py                              AS sales_pieces_py 
       , time_working_netto_std
       , time_working_netto_std_py
       , miss_times_perf
       , miss_times_perf_py
       , hrs_calc_prod_diff
       , hrs_calc_prod_diff_py
       , miss_times_perf_calc_prod_diff
       , miss_times_p_calc_prod_diff_py
       , diff_hours
       , sales_qty_asis
       , sales_qty_py
       , plan_sales_qty
       , piece_perf_asis
       , piece_perf_py
       , plan_perf_piece
       , item_price_asis
       , diff_sales_qty_asis_pct
       , diff_piece_perf_asis_pct
       , diff_py_val_piece_perf
       /* Inline-Verdichtung über alle Stores eines Warehouse: Summe jeweils bis zur 20. Rankingposition  */
       , SUM(CASE WHEN rnk_prod <= 20      THEN val_retail             ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_retail_productivity
       , SUM(CASE WHEN rnk_prod_net <= 20  THEN val_retail_net         ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_val_rtl_net_productivity
       , SUM(CASE WHEN rnk_prod <= 20      THEN time_working_netto_std ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_time_wrk_productivity
       , SUM(CASE WHEN rnk_prod_net <= 20  THEN time_working_netto_std ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_time_wrk_prod_net
       , SUM(CASE WHEN rnk_prod <= 20      THEN miss_times_perf        ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_miss_times_perf_prod
       , SUM(CASE WHEN rnk_prod_net <= 20  THEN miss_times_perf        ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_miss_times_perf_prod_net
       , SUM(CASE WHEN rnk_diff_py_val_retail_pct <= 20     THEN val_retail        ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_retail_for_diff
       , SUM(CASE WHEN rnk_diff_py_val_retail_net_pct <= 20 THEN val_retail_net    ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_retail_net_for_diff
       , SUM(CASE WHEN rnk_diff_py_val_retail_pct <= 20     THEN val_retail_py     ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_retail_for_diff_py
       , SUM(CASE WHEN rnk_diff_py_val_retail_net_pct <= 20 THEN val_retail_net_py ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_val_rtl_net_for_diff_py
       , SUM( CASE WHEN rnk_val_retail_incr_adj <= 20 THEN val_retail  ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_ret_for_incr_adj
       , SUM( CASE WHEN rnk_val_retail_net_incr_adj <= 20 THEN val_retail_net  ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_val_rtl_net_for_incr_adj
       , SUM( CASE WHEN rnk_val_retail_incr_adj <= 20 THEN val_retail_py   ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_val_ret_py_for_incr_adj
       , SUM( CASE WHEN rnk_val_retail_net_incr_adj <= 20 THEN val_retail_net_py  ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top20_val_rtl_net_py_incr_adj
       , SUM( CASE WHEN rnk_piece_perf <= 20 THEN sales_qty_asis         ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_sales_qty_piece_perf
       , SUM( CASE WHEN rnk_piece_perf <= 20 THEN time_working_netto_std ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_time_wrk_piece_perf
       , SUM( CASE WHEN rnk_piece_perf <= 20 THEN miss_times_perf        ELSE 0 END)
                                               OVER(PARTITION BY client_id, src_wh_id, week_page_by, cy_month_shifted) AS top_20_miss_times_piece_perf

FROM  (
        SELECT
        agg.cy_month_shifted
               , agg.week_page_by
               , agg.loc_sid_store
               , agg.client_id
               , agg.orig_store_nr
               , agg.used_store_desc
               , agg.src_wh_id
               , agg.used_wh_desc
               , agg.country_id
               , agg.country_desc
               , agg.country_iso_cd
               , agg.city
               , agg.sales_manager_id
               , agg.sales_manager_name
               , agg.account_manager_id
               , agg.account_manager_name
               , agg.curr_cd
               , agg.plan_val_turnover
               , agg.plan_val_turnover_net
               , agg.plan_val_hours
               , agg.plan_val_inv_training
               , agg.plan_val_turnover_py
               , agg.plan_val_turnover_net_py
               , agg.plan_val_hours_py
               , agg.plan_val_inv_training_py
               , agg.val_retail
               , agg.val_retail_net
               , agg.cnt_customer
               , agg.val_retail_py
               , agg.val_retail_net_py
               , agg.cnt_customer_py
               , agg.time_working_netto_std
               , agg.miss_times_perf
               , agg.time_working_netto_std_py
               , agg.miss_times_perf_py
               , agg.sales_qty_asis
               , agg.sales_qty_py
               , agg.plan_sales_qty
               , agg.max_umsdate_per_weekpage
               , agg.max_hrsdate_per_weekpage
               , agg.plan_turnover_calc_ums_diff
               , agg.plan_turnover_calc_ums_dif_net
               , agg.plan_turnover_calc_prod_diff
               , agg.plan_turnover_calc_pro_dif_net
               , agg.plan_sales_qty_calc_abv_diff
               , agg.plan_sales_qty_calc_prod_diff
               , agg.plan_hours_calc_hrs_diff
               , agg.plan_hours_calc_prod_diff
               , agg.val_retail_calc_prod_diff
               , agg.val_retail_calc_prod_diff_net
               , agg.val_retail_calc_prod_diff_py
               , agg.val_rtl_calc_prod_dif_net_py
               , agg.hrs_calc_prod_diff
               , agg.hrs_calc_prod_diff_py
               , agg.miss_times_perf_calc_prod_diff
               , agg.miss_times_p_calc_prod_diff_py
               , (agg.val_retail                   - agg.val_retail_py)                / NULLIFZERO(agg.val_retail_py    )                                       AS val_retail_incr_adj
               , (agg.val_retail_net               - agg.val_retail_net_py)            / NULLIFZERO(agg.val_retail_net_py)                                       AS val_retail_net_incr_adj
               , agg.val_retail_calc_prod_diff     /(NULLIFZERO(agg.hrs_calc_prod_diff))                                                                         AS act_productivity
               , agg.val_retail_calc_prod_diff_net /(NULLIFZERO(agg.hrs_calc_prod_diff))                                                                         AS act_productivity_net
               , agg.time_working_netto_std        - agg.plan_hours_calc_hrs_diff                                                                                AS diff_hours
               , (agg.val_retail                   - agg.val_retail_py     )           / NULLIFZERO (agg.val_retail_py      ) * 100                              AS diff_py_val_retail_pct
               , (agg.val_retail_net               - agg.val_retail_net_py )           / NULLIFZERO (agg.val_retail_net_py  ) * 100                              AS diff_py_val_retail_net_pct
               , (agg.sales_qty_asis               - agg.plan_sales_qty   )            / NULLIFZERO(plan_sales_qty          ) * 100                              AS diff_sales_qty_asis_pct
               , agg.sales_qty_asis /  NULLIFZERO(agg.time_working_netto_std    )                                                                                AS piece_perf_asis
               , agg.sales_qty_py   /  NULLIFZERO(agg.time_working_netto_std_py )                                                                                AS piece_perf_py
               , agg.plan_sales_qty /  NULLIFZERO(agg.plan_val_hours)                                                                                            AS plan_perf_piece
               , (piece_perf_asis   - plan_perf_piece  ) / NULLIFZERO(plan_perf_piece ) * 100                                                                    AS diff_piece_perf_asis_pct
               , (piece_perf_asis   - piece_perf_py    ) / NULLIFZERO(piece_perf_py   ) * 100                                                                    AS diff_py_val_piece_perf
               , agg.avg_item_price                                                                                                                              AS item_price_asis
                          /* Inline-Verdichtung über alle Stores eines Warehouse  */
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY act_productivity           DESC NULLS LAST) AS rnk_prod
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY act_productivity_net       DESC NULLS LAST) AS rnk_prod_net
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY diff_py_val_retail_pct     DESC NULLS LAST) AS rnk_diff_py_val_retail_pct
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY diff_py_val_retail_net_pct DESC NULLS LAST) AS rnk_diff_py_val_retail_net_pct
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY val_retail_incr_adj        DESC NULLS LAST) AS rnk_val_retail_incr_adj
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY val_retail_net_incr_adj    DESC NULLS LAST) AS rnk_val_retail_net_incr_adj
               , ROW_NUMBER () OVER (PARTITION BY agg.client_id, agg.src_wh_id, agg.week_page_by, agg.cy_month_shifted ORDER BY piece_perf_asis            DESC NULLS LAST) AS rnk_piece_perf
        FROM  (
                SELECT    cy_month_shifted
                        , week_page_by
                        , loc_sid_store
                        , client_id
                        , orig_store_nr
                        , used_store_desc
                        , src_wh_id
                        , used_wh_desc
                        , country_id
                        , country_desc
                        , country_iso_cd
                        , city
                        , sales_manager_id
                        , sales_manager_name
                        , account_manager_id
                        , account_manager_name
                        , curr_cd
                        , SUM(_plan_val_turnover)             AS plan_val_turnover
                        , SUM(_plan_val_turnover_net)         AS plan_val_turnover_net
                        , SUM(_plan_val_hours)                AS plan_val_hours
                        , SUM(_plan_val_inv_training)         AS plan_val_inv_training
                        , SUM(_plan_val_turnover_py)          AS plan_val_turnover_py
                        , SUM(_plan_val_turnover_net_py)      AS plan_val_turnover_net_py
                        , SUM(_plan_val_hours_py)             AS plan_val_hours_py
                        , SUM(_plan_val_inv_training_py)      AS plan_val_inv_training_py
                        , SUM(_val_retail)                    AS val_retail
                        , SUM(_val_retail_net)                AS val_retail_net
                        , SUM(_cnt_customer)                  AS cnt_customer
                        , SUM(_val_retail_py)                 AS val_retail_py
                        , SUM(_val_retail_net_py)             AS val_retail_net_py
                        , SUM(_cnt_customer_py)               AS cnt_customer_py
                        , SUM(_time_working_netto_std)        AS time_working_netto_std
                        , SUM(_miss_times_perf)               AS miss_times_perf
                        , SUM(_time_working_netto_std_py)     AS time_working_netto_std_py
                        , SUM(_miss_times_perf_py)            AS miss_times_perf_py
                        , SUM(_sales_qty_asis)                AS sales_qty_asis
                        , SUM(_sales_qty_py)                  AS sales_qty_py
                        , SUM(_plan_sales_qty)                AS plan_sales_qty
                        , MAX(_avg_item_price)                AS avg_item_price
                        , MAX(max_umsdate_per_weekpage)       AS max_umsdate_per_weekpage
                        , MAX(max_hrsdate_per_weekpage)       AS max_hrsdate_per_weekpage
                        , SUM(plan_turnover_calc_ums_diff)    AS plan_turnover_calc_ums_diff
                        , SUM(plan_turnover_calc_ums_dif_net) AS plan_turnover_calc_ums_dif_net
                        , SUM(plan_turnover_calc_prod_diff)   AS plan_turnover_calc_prod_diff
                        , SUM(plan_turnover_calc_pro_dif_net) AS plan_turnover_calc_pro_dif_net
                        , SUM(plan_sales_qty_calc_abv_diff)   AS plan_sales_qty_calc_abv_diff
                        , SUM(plan_sales_qty_calc_prod_diff)  AS plan_sales_qty_calc_prod_diff
                        , SUM(plan_hours_calc_hrs_diff)       AS plan_hours_calc_hrs_diff
                        , SUM(plan_hours_calc_prod_diff)      AS plan_hours_calc_prod_diff
                        , SUM(val_retail_calc_prod_diff)      AS val_retail_calc_prod_diff
                        , SUM(val_retail_calc_prod_diff_net)  AS val_retail_calc_prod_diff_net
                        , SUM(val_retail_calc_prod_diff_py)   AS val_retail_calc_prod_diff_py
                        , SUM(val_rtl_calc_prod_dif_net_py)   AS val_rtl_calc_prod_dif_net_py
                        , SUM(hrs_calc_prod_diff)             AS hrs_calc_prod_diff
                        , SUM(hrs_calc_prod_diff_py)          AS hrs_calc_prod_diff_py
                        , SUM(miss_times_perf_calc_prod_diff) AS miss_times_perf_calc_prod_diff
                        , SUM(miss_times_p_calc_prod_diff_py) AS miss_times_p_calc_prod_diff_py
                FROM  (
                        SELECT
                             /* Abhängig von time_range_class: wenn CurrenYear, dann cy_month, wenn PreviousYear, dann um ein Jahr nach vorn in die Zukunft: cy_month+100
                                Wir "schieben" also Vorjahreswerte in die jeweilige Tageszeile des aktuellen Jahres  */
                             CASE WHEN dt.time_range_class = 'cy' THEN dt.cy_month
                                  WHEN dt.time_range_class = 'py' THEN dt.cy_month + 100
                              END                                                                               AS cy_month_shifted
                             /* Abhängig von time_range_class: wenn CurrenYear, dann Faktendatum, wenn PreviousYear, dann um ein Jahr nach vorn in die Zukunft: Add_Months(dat_plantime, 12)  */
                           , CASE WHEN dt.time_range_class = 'cy' THEN dt.cal_dt
                                  WHEN dt.time_range_class = 'py' THEN ADD_MONTHS(dt.cal_dt, 12)
                              END                                                                               AS dat_calendar
                            /* Zuordnungswoche: klammert alle Tage seit Geschäftsjahresanfang bis zum modifizierten Wochenende der angegebenen Woche, bzw. Planungsendemonat  */
                           , dt.week_page_by
                            /* Früher wurden die Original-Stores-ausgegeben - unabhängig von der Frage ob dieser Store noch existiert oder längst fusioniert bzw. umgezogen ist
                               wir geben jetzt nur noch aktuelle Stores aus - ihre Vergangenheit (Fusionselemente) ist über die Relocation inkludiert  */
                           , dt.loc_sid_store
                            /* Früher wurde ein Flag angegeben, mit dem die Zeilen untergegangener (umgezogener bzw. wegfusionierter) Stores ausgeblendet werden konnte
                                 , a12.show_store_fg          show_store_fg
                               dieses wurde unter anderem auch im aktuellen Select dazu verwandt, die Summen der Umsätze dieser Stores auf den überlebenden Folgestore inline zu aggregieren.
                               da wir nun alle Zeilen von vornherein alle zum Gewinnerstore schlüsseln, ist dies nicht mehr nötig, da wir auch davon ausgehen, daß Umsätze auch gleichzeitig in beiden
                               Stores vorkommen können (der Gewinnerstore besteht ja u.U auch schon während der Noch-Lebenszeit des unteregangenen),
                               ist jetzt die Result_Datenmenge nicht mehr Unique bzgl TAG--STORE */
                           , dt.client_id
                           , dt.orig_store_nr
                           , dt.used_store_desc
                           , dt.src_wh_id
                           , dt.used_wh_desc
                           , dt.country_id
                           , dt.country_desc
                           , dt.country_iso_cd
                           , dt.city
                           , dt.sales_manager_id
                           , dt.sales_manager_name
                           , dt.account_manager_id
                           , dt.account_manager_name
                           , dt.curr_cd
                           /* Plan current year */
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_plan = 1 THEN dt.plan_val_turnover      ELSE 0 END                      AS _plan_val_turnover
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_plan = 1 THEN dt.plan_val_turnover      ELSE 0 END                      AS _plan_val_turnover_net
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_plan = 1 THEN dt.plan_val_hours         ELSE 0 END                      AS _plan_val_hours
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_plan = 1 THEN dt.plan_val_inv_training  ELSE 0 END                      AS _plan_val_inv_training
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_plan = 1 THEN dt.plan_sales_pieces      ELSE 0 END                      AS _plan_sales_qty
                           /* Plan previous year */
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_plan = 1 THEN dt.plan_val_turnover      ELSE 0 END                      AS _plan_val_turnover_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_plan = 1 THEN dt.plan_val_turnover      ELSE 0 END                      AS _plan_val_turnover_net_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_plan = 1 THEN dt.plan_val_hours         ELSE 0 END                      AS _plan_val_hours_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_plan = 1 THEN dt.plan_val_inv_training  ELSE 0 END                      AS _plan_val_inv_training_py
                           /* Results current year */
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.val_retail             ELSE 0 END                      AS _val_retail
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.val_retail_net         ELSE 0 END                      AS _val_retail_net
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.cnt_customer           ELSE 0 END                      AS _cnt_customer
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.sales_qty_asis         ELSE 0 END                      AS _sales_qty_asis
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.time_working_netto_std ELSE 0 END                      AS _time_working_netto_std
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.miss_times_perf        ELSE 0 END                      AS _miss_times_perf
                           , CASE WHEN dt.time_range_class = 'cy' AND dt.is_real = 1 THEN dt.avg_item_price         ELSE 0 END                      AS _avg_item_price
                           /* Results previous year */
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.val_retail             ELSE 0 END                      AS _val_retail_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.val_retail_net         ELSE 0 END                      AS _val_retail_net_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.cnt_customer           ELSE 0 END                      AS _cnt_customer_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.sales_qty_asis         ELSE 0 END                      AS _sales_qty_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.time_working_netto_std ELSE 0 END                      AS _time_working_netto_std_py
                           , CASE WHEN dt.time_range_class = 'py' AND dt.is_real = 1 THEN dt.miss_times_perf        ELSE 0 END                      AS _miss_times_perf_py

                           /* Wegfall der Felder val_retail_ber, val_retail_net_ber,cnt_customer_ber
                           -------------------------------------------------------------------------
                             Früher wurden Auswahlen getroffen bzgl der Frage,
                             ob das Datum des Umsatzes
                                     a) im Raum zwischen den Store-Attributen (WAWI) dat_calc_start_py und dat_calc_end_py liegen
                                      b) bzw. in ein hinten offenes Intervall dieser Attribute fallen
                                      c) bzw. auch hinter das Intervall fallen - bei wegfusionierten Stores
                              Die dies erfüllenden Umsatzeilen wiesen die Felder val_retail, val_retail_net,cnt_customer erneut aus - diesmal mit dem Suffix "_ber" .
                              Hierbei trat der (theoretische) Fall auf, daß bei nicht gesetztem CALC_Start-Datum der Wert ausgeblendet wurde (was wohl nicht intendiert war)
                              Desweiteren ergibt eine logische Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status vorliegt,
                              der keine Aktivität ermöglicht.
                              Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
                              Ein Test ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
                              Wegfall der Felder val_retail_ber_top20, val_retail_net_ber_top20
                           ----------------------------------------------------------------------------------
                              Desweiteren wurde über diese Felder eine Inline-Summe gebildet und diese jeweils dem überlebenden (Gewinner-)Store zugewiesen.
                              Dies ist mit der bisherigen Argumentation obsolet.
                              In einer Fehlinterpretation des Namings wurden diese zudem mit einem weiteren Suffix: _top20 versehen, was an dieser Stelle völlig absurd ist,
                              da keinerlei Ranking stattfindet. Dies entfällt nun ebenso.
                             Diskussion des Vorjahreselemente (Suffix PY)
                           -----------------------------------------------
                             Im Original wurde hierzu zu jedem Salesdatum der in v_cal_month_ber hinterlegte Folgejahrestag zugeordnet und mit diesem nun die gleiche Frage beantwortet
                             und die jeweiligen ..._ber oder ...ber_top20-Derivate zu finden. Dies ist hinfällig, wenn man obiger Argumentation folgt und alle historischen
                             Sales-Zeilen konsequent dem Gewinnerstore zuordnet  */
                           , MAX(CASE WHEN _val_retail             > 0 THEN cal_dt END) OVER (PARTITION BY client_id, loc_sid_store, week_page_by)              AS  max_umsdate_per_weekpage
                           , MAX(CASE WHEN _time_working_netto_std > 0 THEN cal_dt END) OVER (PARTITION BY client_id, loc_sid_store, week_page_by)              AS  max_hrsdate_per_weekpage
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage                                             THEN _plan_val_turnover         END AS plan_turnover_calc_ums_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage                                             THEN _plan_val_turnover_net     END AS plan_turnover_calc_ums_dif_net
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _plan_val_turnover         END AS plan_turnover_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _plan_val_turnover_net     END AS plan_turnover_calc_pro_dif_net
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage                                             THEN _plan_sales_qty            END AS plan_sales_qty_calc_abv_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _plan_sales_qty            END AS plan_sales_qty_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_hrsdate_per_weekpage                                             THEN _plan_val_hours            END AS plan_hours_calc_hrs_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _plan_val_hours            END AS plan_hours_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _val_retail                END AS val_retail_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _val_retail_net            END AS val_retail_calc_prod_diff_net
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _val_retail_py             END AS val_retail_calc_prod_diff_py
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _val_retail_net_py         END AS val_rtl_calc_prod_dif_net_py
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _time_working_netto_std    END AS hrs_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _time_working_netto_std_py END AS hrs_calc_prod_diff_py
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _miss_times_perf           END AS miss_times_perf_calc_prod_diff
                           , CASE WHEN dat_calendar <= max_umsdate_per_weekpage AND dat_calendar<= max_hrsdate_per_weekpage THEN _miss_times_perf_py        END AS miss_times_p_calc_prod_diff_py

                        FROM (
                              SELECT   base.client_id
                                     , base.loc_sid_store
                                     , base.cal_dt
                                     , base.py_caldt_shifted
                                     , base.cy_week
                                     , base.py_week_shifted
                                     , base.cy_week_seq
                                     , base.py_week_seq_shifted
                                     , base.cy_month
                                     , base.orig_store_nr
                                     , base.used_store_desc
                                     , base.used_closing_dt
                                     , base.city
                                     , base.country_id
                                     , base.country_desc
                                     , base.country_iso_cd
                                     , base.src_wh_id
                                     , base.used_wh_desc
                                     , base.sales_manager_id
                                     , base.sales_manager_name
                                     , base.account_manager_id
                                     , base.account_manager_name
                                     , base.curr_cd
                                     , base.plan_val_turnover
                                     , base.plan_val_turnover_net
                                     , base.plan_val_hours
                                     , base.plan_val_inv_training
                                     , base.val_retail
                                     , base.val_retail_net
                                     , base.cnt_customer
                                     , base.time_working_netto_std
                                     , base.miss_times_perf
                                     , base.sales_qty_asis
                                     , base.avg_item_price
                                     , base.plan_sales_pieces
                                     , base.plan_avg_sales_price
                                     , base.is_daily_level_row
                                     , base.is_weekly_normal_level_row
                                     , base.is_weekly_pyshift_level_row
                                     , base.is_monthly_level_row
                                      /* immer disjunkt!! - kein Datensatz fällt gleichzeitig in beide Intervallgruppen */
                                     , CASE WHEN base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_plan
                                              OR base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_act
                                                 THEN 'cy'
                                            WHEN base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_plan
                                              OR base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_act
                                                 THEN 'py'
                                        END                                                                                                        AS time_range_class
                                     , CASE WHEN base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_plan
                                              OR base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_plan
                                                 THEN 1
                                            ELSE 0
                                        END                                                                                                        AS is_plan
                                     , CASE WHEN base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_act
                                              OR base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_act
                                                 THEN 1
                                            ELSE 0
                                        END                                                                                                        AS is_real
                                     , cal.cy_week                                                                                                 AS week_page_by
                             FROM P_LEW_MART_MSI.v_bo_base_performance_list AS base    /* tagesgranular  */
                               /* nimm die Wochen (relativ) 0-7 der Pendantwoche der Woche 0 des aktuellen Jahres im Vorjahr
                                  und die Wochen -5 - 0 des aktuellen Jahres
                                  Suche zu jedem so vorausgewähltem Tag den zugehörigen Geschäftsjahresbeginn
                                  (starr der 1.3. des Geschäftsjahres , in welches der Tag fällt)
                                  und das Wochenende (Tag 7= Sonntag) der Woche; Ist die Woche durch das Monatsende geschnitten, dann der letzte des Monats und in der aktuellen Woche der aktuelle Tag)
                                  MaW.: wir bilden also kumulative Wochenauswahlen, die zu jeder der o.a. Wochen jeweils die Sätze seit Geschäftjahresbeginn
                                  bis zum jeweiligen modifizierten Wochenende klammert
                                  Im Plandatenbereich wird das Auswahl-Ende etwas anders geschnitten. Hier wird der Monatsletzte des Monats genommen, in den der erste Tag der Auswahlwoche fällt,
                                  um die Plandaten dieses Monats komplett zu erfassen  */
                               INNER JOIN P_LEW_MART_MSI.v_bo_perf_cal_list_mth AS cal
                                  ON base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_plan
                                  OR base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_plan
                                  OR base.cal_dt BETWEEN cal.min_dat_calendar_month    AND cal.max_dat_calendar_month_act
                                  OR base.cal_dt BETWEEN cal.min_dat_calendar_month_py AND cal.max_dat_calendar_month_py_act
                             WHERE base.is_monthly_level_row=1
                            ) AS dt
                     ) AS crea_pages
                GROUP BY
                          cy_month_shifted
                        , week_page_by
                        , loc_sid_store
                        , client_id
                        /* Restattribute gehören nicht zum Schlüssel der Gruppierung, sondern sind letztlich Verlängerung von loc_sid_store bzw. Client */
                        , orig_store_nr
                        , used_store_desc
                        , src_wh_id
                        , used_wh_desc
                        , country_id
                        , country_desc
                        , country_iso_cd
                        , city
                        , sales_manager_id
                        , sales_manager_name
                        , account_manager_id
                        , account_manager_name
                        , curr_cd
              ) AS agg
      ) AS  rnk
;
