CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_PCON_ABWESENH_LOGIK_FG_ZU_2
--Ersterstellung AWol2209
(
mandant_id
,mandant_bez
,mandant_kbez
, abwesenheit_id
, kjmo_bis
, kjmo_von
, logik_kz
, langzeit_abwesend_fg
, pflege_fg
, beschaeftigungs_verbot_fg
, krankheit_unfall_fg
, sonstige_abwesenheit_fg
, freigestellt_fg
, mutterschutz_fg
, elternzeit_fg
-- wird als Dummy_2 benoetigt in MSI 
, fg_aendern
)
AS

   SELECT
   v01.mandant_id, 
   v02.mandant_bez,
   v02.mandant_kbez,
   v01.abwesenheit_id, 
   v01.kjmo_bis, 
   v01.kjmo_von, 
   v01.logik_kz, 
   v01.langzeit_abwesend_fg, 
   v01.pflege_fg, 
   v01.beschaeftigungs_verbot_fg, 
   v01.krankheit_unfall_fg, 
   v01.sonstige_abwesenheit_fg, 
   v01.freigestellt_fg, 
   v01.mutterschutz_fg, 
   v01.elternzeit_fg,
-- wird als Dummy_2 benoetigt in MSI 
   1 as fg_aendern
   FROM dbp_view.v_pcon_abwesenh_logik_fg_zu_2 v01
   left join dbp_msi_view_shr.mv_mandant_2 v02
   on 	v01.mandant_id = v02.mandant_id
;