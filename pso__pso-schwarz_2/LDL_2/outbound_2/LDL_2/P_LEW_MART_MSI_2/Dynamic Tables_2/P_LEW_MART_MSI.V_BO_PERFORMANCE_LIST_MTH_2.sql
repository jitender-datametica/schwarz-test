/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO
  Source
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST_2
      V_BO_PERF_CAL_LIST_MTH_2
  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_performance_list_mth.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.

  Comments from the original Teradata DDL:
  Created by Jens Thole
  on 14.06.2018
  Inhalt: finale Zielstruktur der Monatsebenen-Schnittstelle der BO_PERORMANCE_LIST
  Quellen: MART_MSI:t_bo_base_performance_list_2 (alleinige Basisstruktur)
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
  Desweiteren ergibt eine_2 Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status_2 vorliegt,
  der keine Aktivität ermöglicht.
  Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
  Ein Test_2 ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
  Für die Zielstruktur-Kompatibilität wurden die ..._ber-Felder als Duplikate der Originalfelder ausgewiesen
  Desweiteren wurde über diese Felder eine_2 Inline-Summe gebildet und diese jeweils dem überlebenden (Gewinner-)Store zugewiesen.
  Dies ist mit der bisherigen Argumentation obsolet.
  In einer Fehlinterpretation des Namings wurden diese zudem mit einem weiteren Suffix: _top20 versehen, was an dieser Stelle völlig absurd ist,
  da keinerlei Ranking stattfindet - bestenfalls sind diese Felder für das Ranking vorgesehen gewesen. Dies entfällt nun ebenso und deren Platz nehmen die Originale ein
 
  Im Original wurde hierzu zu jedem Salesdatum der in v_cal_month_ber_2 hinterlegte Folgejahrestag zugeordnet und mit diesem nun die gleiche
  Frage wie oben [a),b),c)] beantwortet, um die jeweiligen ..._ber oder ...ber_top20-Derivate zu finden.
  Dies ist hinfällig, wenn man obiger Argumentation analog folgt und alle historischen
  Sales_2-Zeilen konsequent dem Gewinnerstore zuordnet
  Granularität (Gewinnerstore,
                 DatenMonat (für PreviousYear-Felder um ein Jahr ins CurrentYear "shiftet" und dem jeweiligen Current-Monat_2 zugeschlagen),
                 Reportwoche (Week-Page= Wochenauswahl nach MART_MSI:v_bo_perf_cal_list_mth_2;
                               jede der Reportwochen enthält die 4 notwendigen Auswahlintervalle, unterschieden nach
                                                        * Plandaten / Istdaten
                                                    sowie nach
                                                        * CurrentYear / PreviousYear
                              Startpunkt ist der jeweils der RepWoche zugeordnete Geschäftsjahresanfang (für PY: ein Jahr in die Vergangenheit)
                              Endpunkt ist der jeweils der RepWoche zugeordnete, modifizierte Wochenendtag (für Plan der zugeordnete Planmonatsendtag); PY -analyog ein Jahr davon zurück
                             )
                 )
  Es findet ein Ranking der Stores innerhalb seiner Warehouse-Monats-Gruppe_2 nach diversen Kennzahle statt, die leider in der Zielsignatur nicht vorkommen,
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
  - rnk_prod: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld act_productivity)
  - rnk_prod_net: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld act_productivity)
  - rnk_diff_py_val_retail_pct: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld diff_py_val_retail_pct)
  - rnk_diff_py_val_retail_net_pct: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld diff_py_val_retail_net_pct)
  - rnk_val_retail_incr_adj: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld val_retail_incr_adj)
  - rnk_val_retail_net_incr_adj: Ranking der Stores pro Warehouse-Monat_2 nach Produktivität auf Basis Bruttoumsatz (Feld val_retail_net_incr_adj)
    Die Rankings (rnk_diff_py_val_retail_pct,rnk_diff_py_val_retail_net_pct) sind naturgemäß absolut gleich zu (rnk_val_retail_incr_adj,rnk_val_retail_net_incr_adj)
    Früher waren diese unterschiedlich!. Für die letzte Rankingruppe wurde eine_2 Summe über alle die "[A,B,C]-Regel" einhaltenden Umsätze über alle Verliererstores nur dem Gewinnerstore zugewiesen.
    Da früher alle Stores ausgewiesen wurden (auch die Verlierer) hatten die Umsatzvalue-Varianten für den Gewinnerstore differierende Werte.
    Beipiel val_retail:
    Feld val_retail_asis enthielt die (nackten) Werte aus der Umsatzlieferung
    Feld val_retail_ber  enthielt die (nackten) Werte aus der Umsatzlieferung, eingeschränkt auf die "[A,B,C]-Regel" - (eigene Analysen fanden keinen Fall einer Differenz - aber gut, prinzipiell ist's möglich).
    Feld val_retail_ber_top20 enthielt die (nackten) Werte aus der Umsatzlieferungdes eigenen Stores eingeschränkt auf die "[A,B,C]-Regel", sowie alle Werte der in diesen Store eingegangenen historischen Stores,
    sofern auch deren Umsätze der "[A,B,C]-Regel" genügten.
    Da nun val_retail_incr_adj auf Basis der ..._ber_top20-Varianten gebildet wurde und diff_py_val_retail_pct auf Bais der ...asis-Varianten, konnten die Rankings damals abweichen.
    Nun gibt es sozusagen nur noch die TOP20-Werte, da wir von vornherein auf Gewinnerstorebene operieren. und die "[A,B,C]-Regel" wird ignoriert aufgrund obiger Argumentation
*/



CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_bo_performance_list_mth_2
OPTIONS(DESCRIPTION = 'SCHNITTSTELLENVIEW CUBE-BELADUNG BO. PERFORMANCELIST MONTH')
AS
/* sinnlos-Duplikat: */ /* Inline-Verdichtung über alle Stores eines Warehouse */
/* Abhängig von time_range_class: wenn CurrenYear, dann cy_month, wenn PreviousYear, dann um ein Jahr nach vorn in die Zukunft: cy_month+100
                                Wir "schieben" also Vorjahreswerte in die jeweilige Tageszeile des aktuellen Jahres */
/* Abhängig von time_range_class: wenn CurrenYear, dann Faktendatum, wenn PreviousYear, dann um ein Jahr nach vorn in die Zukunft: Add_Months(dat_plantime, 12) */
/* Zuordnungswoche: klammert alle Tage seit Geschäftsjahresanfang bis zum modifizierten Wochenende der angegebenen Woche_2, bzw. Planungsendemonat */
/* Plan previous year */ /* Results current year */ /* Results previous year */
/* Wegfall der Felder val_retail_ber, val_retail_net_ber,cnt_customer_ber
                           -------------------------------------------------------------------------
                             Früher wurden Auswahlen getroffen bzgl der Frage,
                             ob das Datum des Umsatzes
                                     a) im Raum zwischen den Store-Attributen (WAWI) dat_calc_start_py und dat_calc_end_py liegen
                                      b) bzw. in ein hinten offenes Intervall dieser Attribute fallen
                                      c) bzw. auch hinter das Intervall fallen - bei wegfusionierten Stores
                              Die dies erfüllenden Umsatzeilen wiesen die Felder val_retail, val_retail_net,cnt_customer erneut aus - diesmal mit dem Suffix "_ber" .
                              Hierbei trat der (theoretische) Fall auf, daß bei nicht gesetztem CALC_Start-Datum der Wert ausgeblendet wurde (was wohl nicht intendiert war)
                              Desweiteren ergibt eine_2 logische Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status_2 vorliegt,
                              der keine Aktivität ermöglicht.
                              Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
                              Ein Test_2 ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
                              Wegfall der Felder val_retail_ber_top20, val_retail_net_ber_top20
                           ----------------------------------------------------------------------------------
                              Desweiteren wurde über diese Felder eine_2 Inline-Summe gebildet und diese jeweils dem überlebenden (Gewinner-)Store zugewiesen.
                              Dies ist mit der bisherigen Argumentation obsolet.
                              In einer Fehlinterpretation des Namings wurden diese zudem mit einem weiteren Suffix: _top20 versehen, was an dieser Stelle völlig absurd ist,
                              da keinerlei Ranking stattfindet. Dies entfällt nun ebenso.
                             Diskussion des Vorjahreselemente (Suffix PY)
                           -----------------------------------------------
                             Im Original wurde hierzu zu jedem Salesdatum der in v_cal_month_ber_2 hinterlegte Folgejahrestag zugeordnet und mit diesem nun die gleiche Frage beantwortet
                             und die jeweiligen ..._ber oder ...ber_top20-Derivate zu finden. Dies ist hinfällig, wenn man obiger Argumentation folgt und alle historischen
                             Sales_2-Zeilen konsequent dem Gewinnerstore zuordnet */
/* tagesgranular */
/* nimm die Wochen (relativ) 0-7 der Pendantwoche der Woche_2 0 des aktuellen Jahres im Vorjahr
                                  und die Wochen -5 - 0 des aktuellen Jahres
                                  Suche zu jedem so vorausgewähltem Tag_2 den zugehörigen Geschäftsjahresbeginn
                                  (starr der 1.3. des Geschäftsjahres , in welches der Tag_2 fällt)
                                  und das Wochenende (Tag_2 7= Sonntag) der Woche_2; Ist die Woche_2 durch das Monatsende geschnitten, dann der letzte des Monats und in der aktuellen Woche_2 der aktuelle Tag_2)
                                  MaW.: wir bilden also kumulative Wochenauswahlen, die zu jeder der o.a. Wochen jeweils die Sätze seit Geschäftjahresbeginn
                                  bis zum jeweiligen modifizierten Wochenende klammert
                                  Im Plandatenbereich wird das Auswahl-Ende etwas anders geschnitten. Hier wird der Monatsletzte des Monats genommen, in den der erste Tag_2 der Auswahlwoche fällt,
                                  um die Plandaten dieses Monats komplett zu erfassen */
SELECT client_id,
 country_desc,
 country_id,
 country_iso_cd,
 loc_sid_store AS store_id,
 orig_store_nr,
 used_store_desc AS store_desc,
 city,
 src_wh_id AS wh_id,
 used_wh_desc AS wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 week_page_by,
 cy_month_shifted AS cy_month,
 curr_cd AS currency_iso_cd,
 plan_val_turnover,
 plan_val_turnover_net,
 plan_val_turnover_py,
 plan_val_turnover_net_py,
 plan_turnover_calc_ums_diff,
 plan_turnover_calc_ums_dif_net,
 plan_turnover_calc_prod_diff,
 plan_turnover_calc_pro_dif_net,
 plan_sales_qty_calc_abv_diff,
 plan_sales_qty_calc_prod_diff,
 plan_hours_calc_hrs_diff,
 plan_hours_calc_prod_diff,
 plan_val_hours,
 plan_val_hours_py,
 plan_val_inv_training,
 plan_val_inv_training_py,
 val_retail AS val_retail_asis,
 val_retail_net AS val_retail_net_asis,
 val_retail AS val_retail_ber,
 val_retail_net AS val_retail_net_ber,
 val_retail_py AS val_retail_asis_py,
 val_retail_net_py AS val_retail_net_asis_py,
 val_retail_calc_prod_diff,
 val_retail_calc_prod_diff_net,
 val_retail_calc_prod_diff_py,
 val_rtl_calc_prod_dif_net_py,
 cnt_customer AS cnt_customer_asis,
 cnt_customer AS cnt_customer_ber,
 cnt_customer_py AS cnt_customer_asis_py,
 sales_qty_asis AS sales_pieces_ber,
 sales_qty_py AS sales_pieces_py,
 time_working_netto_std,
 time_working_netto_std_py,
 miss_times_perf,
 miss_times_perf_py,
 hrs_calc_prod_diff,
 hrs_calc_prod_diff_py,
 miss_times_perf_calc_prod_diff,
 miss_times_p_calc_prod_diff_py,
 diff_hours,
 sales_qty_asis,
 sales_qty_py,
 plan_sales_qty,
 piece_perf_asis,
 piece_perf_py,
 plan_perf_piece,
 item_price_asis,
 diff_sales_qty_asis_pct,
 diff_piece_perf_asis_pct,
 diff_py_val_piece_perf
 /* Inline-Verdichtung über alle Stores eines Warehouse: Summe jeweils bis zur 20. Rankingposition */,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN val_retail
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_retail_productivity,
 SUM(CASE
   WHEN rnk_prod_net <= 20
   THEN val_retail_net
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_productivity,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_time_wrk_productivity,
 SUM(CASE
   WHEN rnk_prod_net <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_time_wrk_prod_net,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_miss_times_perf_prod,
 SUM(CASE
   WHEN rnk_prod_net <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_miss_times_perf_prod_net,
 SUM(CASE
   WHEN rnk_diff_py_val_retail_pct <= 20
   THEN val_retail
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_retail_for_diff,
 SUM(CASE
   WHEN rnk_diff_py_val_retail_net_pct <= 20
   THEN val_retail_net
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_retail_net_for_diff,
 SUM(CASE
   WHEN rnk_diff_py_val_retail_pct <= 20
   THEN val_retail_py
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_retail_for_diff_py,
 SUM(CASE
   WHEN rnk_diff_py_val_retail_net_pct <= 20
   THEN val_retail_net_py
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_for_diff_py,
 SUM(CASE
   WHEN rnk_val_retail_incr_adj <= 20
   THEN val_retail
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_ret_for_incr_adj,
 SUM(CASE
   WHEN rnk_val_retail_net_incr_adj <= 20
   THEN val_retail_net
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_for_incr_adj,
 SUM(CASE
   WHEN rnk_val_retail_incr_adj <= 20
   THEN val_retail_py
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_ret_py_for_incr_adj,
 SUM(CASE
   WHEN rnk_val_retail_net_incr_adj <= 20
   THEN val_retail_net_py
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_py_incr_adj,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN sales_qty_asis
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_sales_qty_piece_perf,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_time_wrk_piece_perf,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_miss_times_piece_perf
FROM (SELECT cy_month_shifted,
   week_page_by,
   loc_sid_store,
   client_id,
   orig_store_nr,
   used_store_desc,
   src_wh_id,
   used_wh_desc,
   country_id,
   country_desc,
   country_iso_cd,
   city,
   sales_manager_id,
   sales_manager_name,
   account_manager_id,
   account_manager_name,
   curr_cd,
   plan_val_turnover,
   plan_val_turnover_net,
   plan_val_hours,
   plan_val_inv_training,
   plan_val_turnover_py,
   plan_val_turnover_net_py,
   plan_val_hours_py,
   plan_val_inv_training_py,
   val_retail,
   val_retail_net,
   cnt_customer,
   val_retail_py,
   val_retail_net_py,
   cnt_customer_py,
   time_working_netto_std,
   miss_times_perf,
   time_working_netto_std_py,
   miss_times_perf_py,
   sales_qty_asis,
   sales_qty_py,
   plan_sales_qty,
   max_umsdate_per_weekpage,
   max_hrsdate_per_weekpage,
   plan_turnover_calc_ums_diff,
   plan_turnover_calc_ums_dif_net,
   plan_turnover_calc_prod_diff,
   plan_turnover_calc_pro_dif_net,
   plan_sales_qty_calc_abv_diff,
   plan_sales_qty_calc_prod_diff,
   plan_hours_calc_hrs_diff,
   plan_hours_calc_prod_diff,
   val_retail_calc_prod_diff,
   val_retail_calc_prod_diff_net,
   val_retail_calc_prod_diff_py,
   val_rtl_calc_prod_dif_net_py,
   hrs_calc_prod_diff,
   hrs_calc_prod_diff_py,
   miss_times_perf_calc_prod_diff,
   miss_times_p_calc_prod_diff_py,
     (val_retail - val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py) AS val_retail_incr_adj,
     (val_retail_net - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py) AS
   val_retail_net_incr_adj,
    val_retail_calc_prod_diff / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff) AS act_productivity,
    val_retail_calc_prod_diff_net / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff) AS act_productivity_net,
    time_working_netto_std - plan_hours_calc_hrs_diff AS diff_hours,
      (val_retail - val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py) * 100 AS diff_py_val_retail_pct,
      (val_retail_net - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py) * 100 AS
   diff_py_val_retail_net_pct,
      (sales_qty_asis - plan_sales_qty) / IF(plan_sales_qty = 0, NULL, plan_sales_qty) * 100 AS diff_sales_qty_asis_pct
   ,
    sales_qty_asis / IF(time_working_netto_std = 0, NULL, time_working_netto_std) AS piece_perf_asis,
    sales_qty_py / IF(time_working_netto_std_py = 0, NULL, time_working_netto_std_py) AS piece_perf_py,
    plan_sales_qty / IF(plan_val_hours = 0, NULL, plan_val_hours) AS plan_perf_piece,
      (sales_qty_asis / IF(time_working_netto_std = 0, NULL, time_working_netto_std) - plan_sales_qty / IF(plan_val_hours
           = 0, NULL, plan_val_hours)) / IF(plan_sales_qty / IF(plan_val_hours = 0, NULL, plan_val_hours) = 0, NULL,
       plan_sales_qty / IF(plan_val_hours = 0, NULL, plan_val_hours)) * 100 AS diff_piece_perf_asis_pct,
      (sales_qty_asis / IF(time_working_netto_std = 0, NULL, time_working_netto_std) - sales_qty_py / IF(time_working_netto_std_py
           = 0, NULL, time_working_netto_std_py)) / IF(sales_qty_py / IF(time_working_netto_std_py = 0, NULL,
         time_working_netto_std_py) = 0, NULL, sales_qty_py / IF(time_working_netto_std_py = 0, NULL,
        time_working_netto_std_py)) * 100 AS diff_py_val_piece_perf,
   avg_item_price AS item_price_asis,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY (val_retail_calc_prod_diff / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff)) IS NULL,
       val_retail_calc_prod_diff / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff)) AS rnk_prod,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY (val_retail_calc_prod_diff_net / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff)) IS NULL,
       val_retail_calc_prod_diff_net / IF(hrs_calc_prod_diff = 0, NULL, hrs_calc_prod_diff)) AS rnk_prod_net,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY ((val_retail - val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py) * 100) IS NULL, (val_retail -
          val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py) * 100) AS rnk_diff_py_val_retail_pct,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY ((val_retail_net - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py) * 100) IS NULL,
         (val_retail_net - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py) * 100) AS
   rnk_diff_py_val_retail_net_pct,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY ((val_retail - val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py)) IS NULL, (val_retail -
         val_retail_py) / IF(val_retail_py = 0, NULL, val_retail_py)) AS rnk_val_retail_incr_adj,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY ((val_retail_net - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py)) IS NULL, (val_retail_net
          - val_retail_net_py) / IF(val_retail_net_py = 0, NULL, val_retail_net_py)) AS rnk_val_retail_net_incr_adj,
   ROW_NUMBER() OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), CAST(week_page_by AS STRING), cy_month_shifted
    ORDER BY (sales_qty_asis / IF(time_working_netto_std = 0, NULL, time_working_netto_std)) IS NULL, sales_qty_asis /
       IF(time_working_netto_std = 0, NULL, time_working_netto_std)) AS rnk_piece_perf
  FROM (SELECT cy_month_shifted,
     week_page_by,
     loc_sid_store,
     client_id,
     orig_store_nr,
     used_store_desc,
     src_wh_id,
     used_wh_desc,
     country_id,
     country_desc,
     country_iso_cd,
     city,
     sales_manager_id,
     sales_manager_name,
     account_manager_id,
     account_manager_name,
     curr_cd,
     SUM(`_plan_val_turnover`) AS plan_val_turnover,
     SUM(`_plan_val_turnover_net`) AS plan_val_turnover_net,
     SUM(`_plan_val_hours`) AS plan_val_hours,
     SUM(`_plan_val_inv_training`) AS plan_val_inv_training,
     SUM(`_plan_val_turnover_py`) AS plan_val_turnover_py,
     SUM(`_plan_val_turnover_net_py`) AS plan_val_turnover_net_py,
     SUM(`_plan_val_hours_py`) AS plan_val_hours_py,
     SUM(`_plan_val_inv_training_py`) AS plan_val_inv_training_py,
     SUM(`_val_retail`) AS val_retail,
     SUM(`_val_retail_net`) AS val_retail_net,
     SUM(`_cnt_customer`) AS cnt_customer,
     SUM(`_val_retail_py`) AS val_retail_py,
     SUM(`_val_retail_net_py`) AS val_retail_net_py,
     SUM(`_cnt_customer_py`) AS cnt_customer_py,
     SUM(`_time_working_netto_std`) AS time_working_netto_std,
     SUM(`_miss_times_perf`) AS miss_times_perf,
     SUM(`_time_working_netto_std_py`) AS time_working_netto_std_py,
     SUM(`_miss_times_perf_py`) AS miss_times_perf_py,
     SUM(`_sales_qty_asis`) AS sales_qty_asis,
     SUM(`_sales_qty_py`) AS sales_qty_py,
     SUM(`_plan_sales_qty`) AS plan_sales_qty,
     MAX(`_avg_item_price`) AS avg_item_price,
     MAX(max_umsdate_per_weekpage) AS max_umsdate_per_weekpage,
     MAX(max_hrsdate_per_weekpage) AS max_hrsdate_per_weekpage,
     SUM(plan_turnover_calc_ums_diff) AS plan_turnover_calc_ums_diff,
     SUM(plan_turnover_calc_ums_dif_net) AS plan_turnover_calc_ums_dif_net,
     SUM(plan_turnover_calc_prod_diff) AS plan_turnover_calc_prod_diff,
     SUM(plan_turnover_calc_pro_dif_net) AS plan_turnover_calc_pro_dif_net,
     SUM(plan_sales_qty_calc_abv_diff) AS plan_sales_qty_calc_abv_diff,
     SUM(plan_sales_qty_calc_prod_diff) AS plan_sales_qty_calc_prod_diff,
     SUM(plan_hours_calc_hrs_diff) AS plan_hours_calc_hrs_diff,
     SUM(plan_hours_calc_prod_diff) AS plan_hours_calc_prod_diff,
     SUM(val_retail_calc_prod_diff) AS val_retail_calc_prod_diff,
     SUM(val_retail_calc_prod_diff_net) AS val_retail_calc_prod_diff_net,
     SUM(val_retail_calc_prod_diff_py) AS val_retail_calc_prod_diff_py,
     SUM(val_rtl_calc_prod_dif_net_py) AS val_rtl_calc_prod_dif_net_py,
     SUM(hrs_calc_prod_diff) AS hrs_calc_prod_diff,
     SUM(hrs_calc_prod_diff_py) AS hrs_calc_prod_diff_py,
     SUM(miss_times_perf_calc_prod_diff) AS miss_times_perf_calc_prod_diff,
     SUM(miss_times_p_calc_prod_diff_py) AS miss_times_p_calc_prod_diff_py
    FROM (SELECT CASE
        WHEN time_range_class = 'cy'
        THEN cy_month
        WHEN time_range_class = 'py'
        THEN cy_month + 100
        ELSE NULL
        END AS cy_month_shifted,
       week_page_by
       /* Früher wurden die Original-Stores-ausgegeben - unabhängig von der Frage ob dieser Store noch existiert oder längst fusioniert bzw. umgezogen ist
                               wir geben jetzt nur noch aktuelle Stores aus - ihre Vergangenheit (Fusionselemente) ist über die Relocation inkludiert */
       ,
       loc_sid_store
       /* Früher wurde ein Flag angegeben, mit dem die Zeilen untergegangener (umgezogener bzw. wegfusionierter) Stores ausgeblendet werden konnte
                                 , a12.show_store_fg          show_store_fg
                               dieses wurde unter anderem auch im aktuellen Select dazu verwandt, die Summen der Umsätze dieser Stores auf den überlebenden Folgestore inline zu aggregieren.
                               da wir nun alle Zeilen von vornherein alle zum Gewinnerstore schlüsseln, ist dies nicht mehr nötig, da wir auch davon ausgehen, daß Umsätze auch gleichzeitig in beiden
                               Stores vorkommen können (der Gewinnerstore besteht ja u.U auch schon während der Noch-Lebenszeit des unteregangenen),
                               ist jetzt die Result_Datenmenge nicht mehr Unique bzgl TAG_2--STORE */
       ,
       client_id,
       orig_store_nr,
       used_store_desc,
       src_wh_id,
       used_wh_desc,
       country_id,
       country_desc,
       country_iso_cd,
       city,
       sales_manager_id,
       sales_manager_name,
       account_manager_id,
       account_manager_name,
       curr_cd /* Plan current year */,
        CASE
        WHEN time_range_class = 'cy' AND is_plan = 1
        THEN plan_val_turnover
        ELSE 0
        END AS `_plan_val_turnover`,
        CASE
        WHEN time_range_class = 'cy' AND is_plan = 1
        THEN plan_val_turnover
        ELSE 0
        END AS `_plan_val_turnover_net`,
        CASE
        WHEN time_range_class = 'cy' AND is_plan = 1
        THEN plan_val_hours
        ELSE 0
        END AS `_plan_val_hours`,
        CASE
        WHEN time_range_class = 'cy' AND is_plan = 1
        THEN plan_val_inv_training
        ELSE 0
        END AS `_plan_val_inv_training`,
        CASE
        WHEN time_range_class = 'cy' AND is_plan = 1
        THEN plan_sales_pieces
        ELSE 0
        END AS `_plan_sales_qty`,
        CASE
        WHEN time_range_class = 'py' AND is_plan = 1
        THEN plan_val_turnover
        ELSE 0
        END AS `_plan_val_turnover_py`,
        CASE
        WHEN time_range_class = 'py' AND is_plan = 1
        THEN plan_val_turnover
        ELSE 0
        END AS `_plan_val_turnover_net_py`,
        CASE
        WHEN time_range_class = 'py' AND is_plan = 1
        THEN plan_val_hours
        ELSE 0
        END AS `_plan_val_hours_py`,
        CASE
        WHEN time_range_class = 'py' AND is_plan = 1
        THEN plan_val_inv_training
        ELSE 0
        END AS `_plan_val_inv_training_py`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN val_retail
        ELSE 0
        END AS `_val_retail`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN val_retail_net
        ELSE 0
        END AS `_val_retail_net`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN cnt_customer
        ELSE 0
        END AS `_cnt_customer`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN sales_qty_asis
        ELSE 0
        END AS `_sales_qty_asis`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN time_working_netto_std
        ELSE 0
        END AS `_time_working_netto_std`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN miss_times_perf
        ELSE 0
        END AS `_miss_times_perf`,
        CASE
        WHEN time_range_class = 'cy' AND is_real = 1
        THEN avg_item_price
        ELSE 0
        END AS `_avg_item_price`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN val_retail
        ELSE 0
        END AS `_val_retail_py`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN val_retail_net
        ELSE 0
        END AS `_val_retail_net_py`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN cnt_customer
        ELSE 0
        END AS `_cnt_customer_py`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN sales_qty_asis
        ELSE 0
        END AS `_sales_qty_py`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN time_working_netto_std
        ELSE 0
        END AS `_time_working_netto_std_py`,
        CASE
        WHEN time_range_class = 'py' AND is_real = 1
        THEN miss_times_perf
        ELSE 0
        END AS `_miss_times_perf_py`,
       MAX(CASE
         WHEN CASE
           WHEN time_range_class = 'cy' AND is_real = 1
           THEN val_retail
           ELSE 0
           END > 0
         THEN cal_dt
         ELSE NULL
         END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_umsdate_per_weekpage,
       MAX(CASE
         WHEN CASE
           WHEN time_range_class = 'cy' AND is_real = 1
           THEN time_working_netto_std
           ELSE 0
           END > 0
         THEN cal_dt
         ELSE NULL
         END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_hrsdate_per_weekpage,
        CASE
        WHEN CASE
          WHEN time_range_class = 'cy'
          THEN cal_dt
          WHEN time_range_class = 'py'
          THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL 12
            MONTH))
          ELSE NULL
          END <= (MAX(CASE
            WHEN CASE
              WHEN time_range_class = 'cy' AND is_real = 1
              THEN val_retail
              ELSE 0
              END > 0
            THEN cal_dt
            ELSE NULL
            END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
           UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_turnover
         ELSE 0
         END
        ELSE NULL
        END AS plan_turnover_calc_ums_diff,
        CASE
        WHEN CASE
          WHEN time_range_class = 'cy'
          THEN cal_dt
          WHEN time_range_class = 'py'
          THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL 12
            MONTH))
          ELSE NULL
          END <= (MAX(CASE
            WHEN CASE
              WHEN time_range_class = 'cy' AND is_real = 1
              THEN val_retail
              ELSE 0
              END > 0
            THEN cal_dt
            ELSE NULL
            END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
           UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_turnover
         ELSE 0
         END
        ELSE NULL
        END AS plan_turnover_calc_ums_dif_net,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_turnover
         ELSE 0
         END
        ELSE NULL
        END AS plan_turnover_calc_prod_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_turnover
         ELSE 0
         END
        ELSE NULL
        END AS plan_turnover_calc_pro_dif_net,
        CASE
        WHEN CASE
          WHEN time_range_class = 'cy'
          THEN cal_dt
          WHEN time_range_class = 'py'
          THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL 12
            MONTH))
          ELSE NULL
          END <= (MAX(CASE
            WHEN CASE
              WHEN time_range_class = 'cy' AND is_real = 1
              THEN val_retail
              ELSE 0
              END > 0
            THEN cal_dt
            ELSE NULL
            END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
           UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_sales_pieces
         ELSE 0
         END
        ELSE NULL
        END AS plan_sales_qty_calc_abv_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_sales_pieces
         ELSE 0
         END
        ELSE NULL
        END AS plan_sales_qty_calc_prod_diff,
        CASE
        WHEN CASE
          WHEN time_range_class = 'cy'
          THEN cal_dt
          WHEN time_range_class = 'py'
          THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL 12
            MONTH))
          ELSE NULL
          END <= (MAX(CASE
            WHEN CASE
              WHEN time_range_class = 'cy' AND is_real = 1
              THEN time_working_netto_std
              ELSE 0
              END > 0
            THEN cal_dt
            ELSE NULL
            END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING) RANGE BETWEEN
           UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_hours
         ELSE 0
         END
        ELSE NULL
        END AS plan_hours_calc_hrs_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_plan = 1
         THEN plan_val_hours
         ELSE 0
         END
        ELSE NULL
        END AS plan_hours_calc_prod_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_real = 1
         THEN val_retail
         ELSE 0
         END
        ELSE NULL
        END AS val_retail_calc_prod_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_real = 1
         THEN val_retail_net
         ELSE 0
         END
        ELSE NULL
        END AS val_retail_calc_prod_diff_net,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'py' AND is_real = 1
         THEN val_retail
         ELSE 0
         END
        ELSE NULL
        END AS val_retail_calc_prod_diff_py,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'py' AND is_real = 1
         THEN val_retail_net
         ELSE 0
         END
        ELSE NULL
        END AS val_rtl_calc_prod_dif_net_py,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_real = 1
         THEN time_working_netto_std
         ELSE 0
         END
        ELSE NULL
        END AS hrs_calc_prod_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'py' AND is_real = 1
         THEN time_working_netto_std
         ELSE 0
         END
        ELSE NULL
        END AS hrs_calc_prod_diff_py,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'cy' AND is_real = 1
         THEN miss_times_perf
         ELSE 0
         END
        ELSE NULL
        END AS miss_times_perf_calc_prod_diff,
        CASE
        WHEN CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN val_retail
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AND CASE
           WHEN time_range_class = 'cy'
           THEN cal_dt
           WHEN time_range_class = 'py'
           THEN IF(cal_dt = LAST_DAY(cal_dt), LAST_DAY(DATE_ADD(cal_dt, INTERVAL 12 MONTH)), DATE_ADD(cal_dt, INTERVAL
             12 MONTH))
           ELSE NULL
           END <= (MAX(CASE
             WHEN CASE
               WHEN time_range_class = 'cy' AND is_real = 1
               THEN time_working_netto_std
               ELSE 0
               END > 0
             THEN cal_dt
             ELSE NULL
             END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING), CAST(week_page_by AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN CASE
         WHEN time_range_class = 'py' AND is_real = 1
         THEN miss_times_perf
         ELSE 0
         END
        ELSE NULL
        END AS miss_times_p_calc_prod_diff_py
      FROM (SELECT BASE.client_id,
         BASE.loc_sid_store,
         BASE.cal_dt,
         BASE.py_caldt_shifted,
         BASE.cy_week,
         BASE.py_week_shifted,
         BASE.cy_week_seq,
         BASE.py_week_seq_shifted,
         BASE.cy_month,
         BASE.orig_store_nr,
         BASE.used_store_desc,
         BASE.used_closing_dt,
         BASE.city,
         BASE.country_id,
         BASE.country_desc,
         BASE.country_iso_cd,
         BASE.src_wh_id,
         BASE.used_wh_desc,
         BASE.sales_manager_id,
         BASE.sales_manager_name,
         BASE.account_manager_id,
         BASE.account_manager_name,
         BASE.curr_cd,
         BASE.plan_val_turnover,
         BASE.plan_val_turnover_net,
         BASE.plan_val_hours,
         BASE.plan_val_inv_training,
         BASE.val_retail,
         BASE.val_retail_net,
         BASE.cnt_customer,
         BASE.time_working_netto_std,
         BASE.miss_times_perf,
         BASE.sales_qty_asis,
         BASE.avg_item_price,
         BASE.plan_sales_pieces,
         BASE.plan_avg_sales_price,
         BASE.is_daily_level_row,
         BASE.is_weekly_normal_level_row,
         BASE.is_weekly_pyshift_level_row,
         BASE.is_monthly_level_row /* immer disjunkt!! - kein Datensatz fällt gleichzeitig in beide Intervallgruppen */
         ,
          CASE
          WHEN BASE.cal_dt BETWEEN CAL.min_dat_calendar_month AND CAL.max_dat_calendar_month_plan OR BASE.cal_dt BETWEEN
            CAL.min_dat_calendar_month AND CAL.max_dat_calendar_month_act
          THEN 'cy'
          WHEN BASE.cal_dt BETWEEN CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_plan OR BASE.cal_dt
            BETWEEN CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_act
          THEN 'py'
          ELSE NULL
          END AS time_range_class,
          CASE
          WHEN BASE.cal_dt BETWEEN CAL.min_dat_calendar_month AND CAL.max_dat_calendar_month_plan OR BASE.cal_dt BETWEEN
            CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_plan
          THEN 1
          ELSE 0
          END AS is_plan,
          CASE
          WHEN BASE.cal_dt BETWEEN CAL.min_dat_calendar_month AND CAL.max_dat_calendar_month_act OR BASE.cal_dt BETWEEN
            CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_act
          THEN 1
          ELSE 0
          END AS is_real,
         CAL.cy_week AS week_page_by
        FROM ldl_p_lew_mart_msi.v_bo_base_performance_list_2 AS BASE
         INNER JOIN ldl_p_lew_mart_msi.v_bo_perf_cal_list_mth_2 AS CAL ON BASE.cal_dt BETWEEN CAL.min_dat_calendar_month
             AND CAL.max_dat_calendar_month_plan OR BASE.cal_dt BETWEEN CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_plan
              OR BASE.cal_dt BETWEEN CAL.min_dat_calendar_month AND CAL.max_dat_calendar_month_act OR BASE.cal_dt
           BETWEEN CAL.min_dat_calendar_month_py AND CAL.max_dat_calendar_month_py_act
        WHERE BASE.is_monthly_level_row = 1) AS dt) AS crea_pages
    GROUP BY cy_month_shifted,
     week_page_by,
     loc_sid_store,
     client_id
     /* Restattribute gehören nicht zum Schlüssel der Gruppierung, sondern sind letztlich Verlängerung von loc_sid_store bzw. Client */
     ,
     orig_store_nr,
     used_store_desc,
     src_wh_id,
     used_wh_desc,
     country_id,
     country_desc,
     country_iso_cd,
     city,
     sales_manager_id,
     sales_manager_name,
     account_manager_id,
     account_manager_name,
     curr_cd) AS t2) AS rnk;
