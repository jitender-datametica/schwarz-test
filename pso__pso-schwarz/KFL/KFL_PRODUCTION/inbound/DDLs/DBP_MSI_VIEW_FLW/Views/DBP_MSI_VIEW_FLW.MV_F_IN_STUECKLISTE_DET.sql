CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_IN_STUECKLISTE_DET
-- 26.10.2011 system_id entfernt
-- 21.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--,system_id
,in_art_id
,stueckliste_typ_id
,stueckliste_id
,stueckliste_pos_id
,loesch_fg
,stueckliste_pos_typ_id
,komponentenmenge
,komponentenmenge_einh_id
,kalk_rlv_fg
)
AS
   SELECT mandant_id, flw_art_id AS in_art_id, stueckliste_typ_id, stueckliste_id, stueckliste_pos_id, loesch_fg, stueckliste_pos_typ_id, komponentenmenge, komponentenmenge_einh_id, kalk_rlv_fg
   FROM dbp_view.v_flw_stueckliste_det;