CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_WETTER_TAG_STUNDE (
      MANDANT_ID,
      WUP_ID,
      NB_ID,
      DAT,
      ZEIT_STUNDE,
      DATZEIT_LETZTES_UPDATE,
      TEMPERATUR,
      WETTERZUSTAND_ID,
      WINDGESCHWINDIGKEIT,
      REGENRISIKO
) AS

   -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT 
      v01.mandant_id
      , wup.aktuell_wup_id AS wup_id
      , v01.nb_id
      , v01.dat
      , v01.zeit_stunde
      , v01.datzeit_letztes_update
      , v01.temperatur
      , v01.wetterzustand_id
      , v01.windgeschwindigkeit
      , v01.regenrisiko
FROM dbp_view.v_wup_wetter_tag_stunde v01

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

;