CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WABI_SUM
(
mandant_id
,wup_id
,nb_id
,aktion_id
,dat
,art_id
,null_bestand_fg
,minus_bestand_fg
,null_absatz_fg
,null_absatz_tag_1_fg
,artbew_menge
,man_bestellung_fg
,man_bestellung_menge
,start_bestand
,ende_bestand
,menge_absatz_af_mittel
,rw_fg
)
AS
   SELECT
   mandant_id, wup_id, nb_id, aktion_id, dat, art_id, null_bestand_fg, minus_bestand_fg, null_absatz_fg, null_absatz_tag_1_fg, artbew_menge, man_bestellung_fg, man_bestellung_menge, start_bestand, ende_bestand, menge_absatz_af_mittel, rw_fg
   FROM dbp_view.v_wabi_sum
   WHERE mandant_id = 1;