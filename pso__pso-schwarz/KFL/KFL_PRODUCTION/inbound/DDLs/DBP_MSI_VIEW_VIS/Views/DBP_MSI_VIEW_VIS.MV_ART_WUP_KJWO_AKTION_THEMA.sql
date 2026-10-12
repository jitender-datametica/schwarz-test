CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_WUP_KJWO_AKTION_THEMA
AS
   --20181020 - newly created for AP0033986 SPEC0044705 , aszu1204
   --20181112 - view modification to exclude duplicates

   SELECT

   --> key for joining with mv_werbung_kennzahlen_woche
   aawz.mandant_id,
   aawz.wup_id,
   aawz.nb_id,
   t.kjwo,
   aawz.art_id,
   --< end key
   aawz.aktion_thema_id,
   ats.aktion_thema_bez
   FROM dbp_view.v_aktion_art_wup_zu aawz
   JOIN dbp_view.v_aktion a
   ON aawz.mandant_id=a.mandant_id AND aawz.aktion_id=a.aktion_id
   JOIN dbp_view.v_tag t
   ON a.dat_von = t.dat
   JOIN dbp_view.v_aktion_thema_spr_zu ats
   ON aawz.mandant_id=ats.mandant_id AND aawz.aktion_thema_id=ats.aktion_thema_id AND ats.spr_id=22
   WHERE a.mandant_id=1  --aktionsthema = nur DE, gibt es nicht im Ausland
   AND dat_sperrung IS NULL AND preisaktiviert_fg = 1 --fachl. Filter
   AND a.dat_von BETWEEN '2016-01-01' AND CURRENT_DATE
   AND aawz.aktion_thema_id <> '0495'
   QUALIFY ROW_NUMBER() OVER (PARTITION BY aawz.mandant_id,
   aawz.wup_id,
   aawz.nb_id,
   t.kjwo,
   aawz.art_id
   ORDER BY aawz.aktion_id DESC NULLS LAST) = 1;