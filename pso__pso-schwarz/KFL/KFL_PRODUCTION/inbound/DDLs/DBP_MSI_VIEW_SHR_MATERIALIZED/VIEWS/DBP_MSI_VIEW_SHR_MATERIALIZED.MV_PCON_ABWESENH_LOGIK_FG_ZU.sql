create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_PCON_ABWESENH_LOGIK_FG_ZU(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	ABWESENHEIT_ID,
	KJMO_BIS,
	KJMO_VON,
	LOGIK_KZ,
	LANGZEIT_ABWESEND_FG,
	PFLEGE_FG,
	BESCHAEFTIGUNGS_VERBOT_FG,
	KRANKHEIT_UNFALL_FG,
	SONSTIGE_ABWESENHEIT_FG,
	FREIGESTELLT_FG,
	MUTTERSCHUTZ_FG,
	ELTERNZEIT_FG,
	FG_AENDERN
) as

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
-- wird als Dummy benoetigt in MSI 
   1 as fg_aendern
   FROM dbp_view.v_pcon_abwesenh_logik_fg_zu v01
   left join DBP_MSI_VIEW_SHR_MATERIALIZED.mv_mandant v02
   on 	v01.mandant_id = v02.mandant_id;