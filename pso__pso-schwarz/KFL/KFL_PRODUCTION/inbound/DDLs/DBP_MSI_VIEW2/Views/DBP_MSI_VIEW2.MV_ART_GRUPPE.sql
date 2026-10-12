CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_GRUPPE
(
art_gruppe_id
,art_gruppe_bez
,art_gruppe_bereich
,art_gruppe_bemerkung
,art_gruppe_kategorie
,dat_anlage
,dat_aenderung
)
AS
   SELECT

   v01.art_gruppe_id, v01.art_gruppe_bez, v01.art_gruppe_bereich, v01.art_gruppe_bemerkung, v01.art_gruppe_kategorie, v01.dat_anlage, v01.dat_aenderung

   FROM dbp_view.v_art_gruppe v01;