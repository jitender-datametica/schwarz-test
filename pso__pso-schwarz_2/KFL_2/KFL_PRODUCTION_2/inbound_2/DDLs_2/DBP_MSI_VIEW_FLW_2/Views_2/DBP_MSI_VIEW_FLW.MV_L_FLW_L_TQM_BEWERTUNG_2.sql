CREATE
OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_TQM_BEWERTUNG_2 -- 26.10.2011 system_id entfernt
(
   tqm_bewertung_id,
   mandant_id --,system_id
,
   fehler_prozent_bis,
   fehler_prozent_von,
   punkte_sap_kf,
   punkte_sap_vk
) AS
SELECT
   sum(1) over (
      order by
         fehler_prozent_bis rows between unbounded preceding
         and current row
   ) tqm_bewertung_id,
   v01.mandant_id,
   cast (
      (
         cast(v01.fehler_prozent_bis as NUMBER(38, 5)) / 100.00
      ) aS NUMBER(38, 5)
   ),
   v01.fehler_prozent_von,
   v01.punkte_sap_kf,
   v01.punkte_sap_vk
FROM
   dbp_view.v_flw_l_tqm_bewertung_2 v01;