CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_NGW_EK_1(
MANDANT_ID,
    DAT_LIEF_BEWERTUNG,
    DAT_LIEF_WUNSCH,
    GP_ID,
    WUP_ID,
    NB_ID,
    ART_ID,
    LAGERORT_ID,
    ENDLIEF_FG_EKPO,
    LOESCH_FG_EKPO,
    SELBSTABHOL_FG,
    DIFF_ID,
    SOLL_IST_LIEFERDATUM_DIFF,
    SOLL_IST_LIEFERDATUM_DIFF_LATE,
    MENGE_LIEF_SOLL_KOLLI_VZ,
    MENGE_LIEF_IST_KOLLI_VZ,
    ANZ_DAT_BUCH,
    MENGE_LIEF_IST_KOLLI_MARKT,
    MENGE_LIEF_SOLL_KOLLI_MARKT
) AS
--2025-11-14, AP0299365, dknop, initial
--2025-11-17, dknop, update definition of DIFF_ID, SOLL_IST_LIEFERDATUM_DIFF_LATE
    SELECT
   t0.mandant_id,
t0.dat_lief_bewertung,
t0.dat_lief_wunsch,
t0.gp_id,
t0.wup_id, --vz
t0.nb_id,
t0.art_id,
t0.LAGERORT_ID,
COALESCE(t0.endlief_fg_ekpo,1),
COALESCE(t0.loesch_fg_ekpo,0),
t0.SELBSTABHOL_FG,
--X = Nichtlieferung, V=Verspätung, notwendig für Metrik-Level damit bei Anzahl Tage gesamt der Schnitt wie bisher gerechnet und bei Verspätung das Buchungsdatum nicht doppelt gezählt wird
CASE WHEN t0.dat_buch IN ('1900-01-01' ,'9999-12-31') AND t0.endlief_fg_ekpo = 1 THEN 'X' WHEN t0.dat_buch > t0.DAT_LIEF_BEWERTUNG THEN 'V' 
WHEN t0.dat_buch < t0.DAT_LIEF_BEWERTUNG THEN 'Z'
ELSE '' END AS DIFF_ID,
SUM(t0.SOLL_IST_LIEFERDATUM_DIFF) AS SOLL_IST_LIEFERDATUM_DIFF,
--SUM(CASE WHEN t0.dat_buch <> '9999-12-31' AND t0.dat_buch > t0.DAT_LIEF_BEWERTUNG THEN t0.SOLL_IST_LIEFERDATUM_DIFF else 0 END) AS SOLL_IST_LIEFERDATUM_DIFF_LATE, -- nur versp.
SUM(CASE WHEN t0.dat_buch NOT IN ('1900-01-01' ,'9999-12-31')  AND t0.dat_buch > t0.DAT_LIEF_BEWERTUNG THEN t0.SOLL_IST_LIEFERDATUM_DIFF 
         WHEN t0.dat_buch  IN ('1900-01-01' ,'9999-12-31') AND  t0.ENDlief_fg_ekpo = 0  THEN t0.SOLL_IST_LIEFERDATUM_DIFF
         ELSE 0 END) AS SOLL_IST_LIEFERDATUM_DIFF_LATE, -- nur versp.
SUM(t0.menge_best_kolli_orig) menge_lief_soll_kolli_vz,
SUM(t0.menge_lief_ist_kolli) menge_lief_ist_kolli_vz,
COUNT(DISTINCT  t0.mandant_id , t0.best_beleg_id ,t0.best_beleg_pos_id , t0.dat_buch) anz_dat_buch,
0
,0
    FROM
    dbp_msi_view_scm.mv_dt_lieferantenmanagement_1 t0
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12 

UNION

SELECT

mandant_ID,
NULL AS DAT_LIEF_BEWERTUNG,
DAT_LIEF_SOLL AS DAT_LIEF_WUNSCH,
GP_ID,
WUP_ID,
nb_id,
ART_ID,
LAGERORT_ID,
1 AS ENDlief_fg_ekpo,
0 AS loesch_fg_ekpo,
0 AS SELBSTABHOL_FG,
diff_id,
0 AS SOLL_IST_LIEFERDATUM_DIFF,
0 AS SOLL_IST_LIEFERDATUM_DIFF_LATE,
0 AS MENGE_LIEF_SOLL_KOLLI_VZ,
0 AS MENGE_LIEF_IST_KOLLI_VZ,
0 AS ANZ_DAT_BUCH,
MENGE_LIEF_IST_KOLLI_MARKT,
MENGE_LIEF_SOLL_KOLLI_MARKT

FROM DBP_MSI_VIEW_SCM.MV_DT_FEHLMENGEN_NGW_EK_1

;