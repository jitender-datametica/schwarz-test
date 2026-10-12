CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKTION_THEMA_SPR_ZU_2
(
aktion_thema_id
,mandant_id
,spr_id
,aktion_thema_bez
,sap_aktion_thema_bez
,aktion_thema_gruppe_id
)
AS
   SELECT
   v01.aktion_thema_id, v01.mandant_id, v02.spr_id, v02.aktion_thema_bez, v01.aktion_thema_id || '   ' || aktion_thema_bez, v01.aktion_thema_gruppe_id
   FROM dbp_view.v_l_aktion_thema_2 AS v01
   INNER JOIN dbp_view.v_aktion_thema_spr_zu_2 AS v02
   ON  v01.aktion_thema_id = v02.aktion_thema_id
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.mandant_id = 1
   AND   v02.spr_id = 22
   AND   v01.aktion_thema_id <> 'XYZA';