CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_art_wup_status_per_markt_2
--2025-02-25, nwag2310, switch to EXISTS
AS
   SELECT
   v01.art_id,
   v01.dat_bis,
   v01.dat_von,
   v01.loesch_id,
   v01.mandant_id,
   v01.nb_id,
   v01.wup_id,
   v01.wg_verkett_id,
   v01.fremd_lagerort_id,
   v01.disponent_id,
   v01.system_id,
   v01.pps_plan_kalender_id,
   v01.disposition_rhythmus_id,
   v01.planlieferzeit,
   v01.dispomerkmal,
   v01.we_bearbeitungszeit,
   v01.min_sicherh_bestand,
   v01.anliefer_kalender,
   v01.kdis,
   v01.bezugsweg_id,
   v01.terminierungsgruppe_1_id,
   v01.terminierungsgruppe_2_id,
   v01.terminierungsgruppe_3_id,
   v01.sollbestand,
   v01.dat_loesch_id,
   --Coalesce(v02.aktuelle_listung_fg,0) aktuelle_listung_fg,
   CASE WHEN EXISTS (SELECT 1
FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_2 V02
WHERE CURRENT_DATE-1 BETWEEN V02.DAT_VON AND V02.DAT_BIS
AND V01.MANDANT_ID=V02.MANDANT_ID
AND V01.WUP_ID=V02.WUP_ID
AND V01.ART_ID=V02.ART_ID) THEN 1 ELSE 0 END AS AKTUELLE_LISTUNG_FG,
   v01.min_restlaufzeit
   FROM dbp_view.v_art_wup_status_per_2 v01
 /*  LEFT JOIN
   (SELECT
   mandant_id,
   wup_id,
   nb_id,
   art_id,
   1 AS aktuelle_listung_fg
   FROM dbp_view.v_art_list_wup_zu_per_2
   WHERE CURRENT_DATE -1 BETWEEN dat_von AND dat_bis
   GROUP BY 1,2,3,4) v02
   ON v01.mandant_id=v02.mandant_id
   AND v01.wup_id=v02.wup_id
   AND v01.art_id=v02.art_id */
   WHERE v01.dat_bis = DATE '9999-12-31'
   AND v01.nb_id = 0;