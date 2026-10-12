CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_WME_AME_WUP_STATUS_ZU_2
AS

/* ZUORDNUNG : Aktion_2 WME AME Status_2 pro Filiale
-- 20220727 ssch0611 : Review. Level set to WUP_2 (not WG). New Status_2 FG + Filter. 
*/

SELECT
  ein_hol.mandant_id
, ein_hol.nb_id
, ein_hol.wup_id
, ein_hol.aktion_id
, MAX(CASE WHEN ein_hol.status_einholung_id = 9 THEN 1 ELSE 0 END) AS aktion_wme_ame_status_fg
FROM dbp_data.aktion_werbemengen_einholung_2 ein_hol

WHERE ein_hol.dat_bis >= CURRENT_DATE

GROUP BY
  ein_hol.mandant_id
, ein_hol.nb_id
, ein_hol.wup_id
, ein_hol.aktion_id;