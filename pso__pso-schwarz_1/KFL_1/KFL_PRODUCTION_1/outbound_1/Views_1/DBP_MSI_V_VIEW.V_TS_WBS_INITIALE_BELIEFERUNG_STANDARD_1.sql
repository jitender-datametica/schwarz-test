CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wbs_initiale_belieferung_standard_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), ausliefergruppe_id
OPTIONS(description='ID der Auslieferungsgruppe. Eine_1 Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine_1 Bündelung von Artikeln mit gleichen Eigenschaften, aufgrund welchen sie zusammen ausgeliefert werden können, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkühlware (Fisch, Pizza, Eis, Tiefkühlgemuese), etc.'),
werbe_start_wtag_id OPTIONS(description='Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag ist.'),
werbe_ende_wtag_id OPTIONS(description='Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag ist.'),
anz_tage_werbe_dauer OPTIONS(description='Werbedauer in Tagen.'), init_lief_markt_cluster_id
OPTIONS(description='Markt-Cluster für die initiale Belieferung (1-5). Markt-Cluster sind Gruppierungen von Märkten, welche in eine_1 der fünf Varianten der initialen Belieferung eingeordnet werden. Es ist nicht geklärt wie die Zuordnung zu einem Cluster geschieht, bzw. was die Kriterien für die Cluster sind.Die Zuordnung von Markt zu Markt-Cluster wird in einer separaten Excel-Datei gepflegt.'),
estimation_id
OPTIONS(description='With this ID the user can decide in which way the estimation for WBS TP2 should be calculated.ID 0 = no estimationID 1 = calculate normal estimation processID 2 = only fill up maximum capacity (Berechnung fuer die Werbung in WBS, aber nur um das Regal aufzufuellen)'),
anz_ame_split_grenze
OPTIONS(description='Schwellwert, unter dem eine_1 Menge, unabhängig von allen Einstellung in anderen Feldern, mit 100 % geliefert wird. Der Wert entspricht also einer Grenze, bis zu der von unten keinerlei Form von Split bei der initialen Belieferung erfolgen darf, sondern erst darüber. 100% initiale Belieferung in AME und es erfolgt kein Split bei der initialen Belieferung.'),
auto_split_fg
OPTIONS(description='Flag: Sagt aus, ob die initiale Belieferung automatisch geteilt (split) werden soll. Relevant bei Auto-Split.'),
auto_split_prozent
OPTIONS(description='Prozentwert, der bei Auto-Split den Anteil der initialen Belieferung angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Auto-Split.'),
anz_pal_auto_split_grenze
OPTIONS(description='Anzahl Paletten, ab der die Liefermenge der initialen Belieferung auf mehrere Liefertage aufgeteilt wird. Relevant bei Auto-Split.'),
anz_tage_vor_akt_lieferstart_auto_split_ame
OPTIONS(description='Anzahl Tage vor Aktion_1, ab wann die initiale Belieferung bei Kolli-Ware (AME) beginnen kann. Relevant bei Auto-Split.'),
anz_tage_vor_akt_lieferstart_auto_split_pal
OPTIONS(description='Anzahl Tage vor Aktion_1, ab wann die initiale Belieferung bei Paletten-Ware beginnen kann. Relevant bei Auto-Split.'),
anz_tage_auto_split_pal
OPTIONS(description='Anzahl Liefertage, auf welche die initiale Belieferung mit Paletten-Ware aufgeteilt werden kann. Relevant bei Auto-Split.'),
anz_tage_fix_split_mhd_grenze
OPTIONS(description='MHD-Grenze in Tagen, ab welcher für die initiale Belieferung die Prozent-Werte aus "UNTER_MHD" oder "UEBER_MHD" verwendet werden. Relevant für Fix-Split.'),
unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 7 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 6 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 5 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 4 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 3 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 2 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 1 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 0 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 1 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 2 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 3 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 4 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 5 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 6 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 7 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 8 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 9 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und wenn ANZ_TAGE_FIX_SPLIT_MHD_GRENZE nicht überschritten ist.'),
ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 7 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 6 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 5 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 4 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 3 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 2 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 1 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 0 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 1 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 2 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 3 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 4 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 5 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 6 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 7 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 8 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
OPTIONS(description='Prozentwert, der den Anteil der initialen Belieferung 9 Tage vor/nach Werbestart angibt (gemessen an der gesamt berechneten Werbemenge). Relevant bei Fix-Split und bei Überschreitung der ANZ_TAGE_FIX_SPLIT_MHD_GRENZE.'),
anz_tage_phase_switch_i
OPTIONS(description='Anzahl Tage vor Aktion_1, an denen WBS Switch I stattfindet (Übertragung der Bestellmengen an die VZ-Dispo)'),
anz_tage_phase_switch_ii
OPTIONS(description='Anzahl Tage vor Aktion_1, an denen WBS Switch II stattfindet (Aktuell Platzhalter, keine WBS Aktivitäten)'),
anz_tage_phase_switch_iii
OPTIONS(description='Anzahl Tage vor Aktion_1, an denen WBS Switch III stattfindet (Start Berechnungszeitraum der initialen Belieferung)'),
anz_tage_phase_switch_iv
OPTIONS(description='Anzahl Tage vor Aktion_1, an denen WBS Switch IV stattfindet (Ende Berechnungszeitraum der initialen Belieferung)'))
OPTIONS(DESCRIPTION = `Die Tabelle wird als Basis für Customizing der Erst-Belieferung von WBS TP2 benötigt. Die Tabelle wird Initial einmal über SQL und danach über den Transaktionsservice vom Frontend geladen. Die Informationen aus der Tabelle werden verwendet, um festzulegen, wie die Erstlieferung der Werbemengen aufgeteilt wird. Es ist z.B. möglich, die gesamte Menge (100%) an Aktionswaren vor der Aktion_1 zu liefern, allerdings is es üblich, sie in separate Lieferungen aufzuteilen. Eine_1 Aufteilung könnte 60%-40% sein -> d.h. 60% vor Aktionsbeginn und 40% am zweiten Tag_1 der Aktion. Es ist auch möglich, z.B. nur 70% vor der Aktion_1 zu liefern und den Rest auf der Grundlage der Berechnung der TP1-Anpassung zu versenden.`)
AS SELECT mandant_id,
 ausliefergruppe_id,
 werbe_start_wtag_id,
 werbe_ende_wtag_id,
 anz_tage_werbe_dauer,
 init_lief_markt_cluster_id,
 estimation_id,
 anz_ame_split_grenze,
 auto_split_fg,
 auto_split_prozent,
 anz_pal_auto_split_grenze,
 anz_tage_vor_akt_lieferstart_auto_split_ame,
 anz_tage_vor_akt_lieferstart_auto_split_pal,
 anz_tage_auto_split_pal,
 anz_tage_fix_split_mhd_grenze,
 unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 anz_tage_phase_switch_i,
 anz_tage_phase_switch_ii,
 anz_tage_phase_switch_iii,
 anz_tage_phase_switch_iv
FROM kfl_production_dbp_msi_data.ts_wbs_initiale_belieferung_standard_1;