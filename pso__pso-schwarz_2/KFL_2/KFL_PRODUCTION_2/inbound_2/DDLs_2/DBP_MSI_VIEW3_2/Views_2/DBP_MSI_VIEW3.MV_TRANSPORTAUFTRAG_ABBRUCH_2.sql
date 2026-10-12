CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG_ABBRUCH_2

(

transport_beleg_id

,mandant_id

,lagernummer_id

,wup_id

,nb_id

,abbr_pos_id

,dat_abbr

,zeit_abbr

,abbruch_dt

,ebene_wechsel_fg

)

AS

   SELECT

    transport_beleg_id, mandant_id, lagernummer_id, wup_id, nb_id, abbr_pos_id, dat_abbr,zeit_abbr

  --, TO_TIME(TO_VARCHAR(COALESCE(zeit_abbr,'00:00:00'))) AS zeit_abbr

  --, (CAST(CAST(dat_abbr AS CHAR(11))||COALESCE(CAST(zeit_abbr AS CHAR(8)),'00:00:00') AS TIMESTAMP)) AS abbruch_dt

  , TIMESTAMP_FROM_PARTS(dat_abbr, to_char(zeit_abbr)) AS abbruch_dt

  , ebene_wechsel_fg

   FROM dbp_view.v_transportauftrag_abbruch_2;