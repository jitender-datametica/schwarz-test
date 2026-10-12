CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WBS_AKTION_ABSATZ_BEREINIGT as
   SELECT
  mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat,
   aktion_id,
   bewart_id,
   menge_bereinigt
   FROM dbp_view.v_wbs_aktion_absatz_bereinigt
   WHERE mandant_id=1
;