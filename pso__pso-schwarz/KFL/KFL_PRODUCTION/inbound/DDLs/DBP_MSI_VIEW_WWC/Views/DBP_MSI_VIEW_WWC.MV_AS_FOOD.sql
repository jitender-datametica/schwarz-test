CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_AS_FOOD(
	ART_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT_AUSLISTUNG,
	GP_ID,
	PHASE_STATUS,
	ERL_FG,
	DAT_FINAL,
	MENGE_STARTBESTAND,
	VK_NETTO,
	MENGE_ENDBESTAND,
	ERL_KZ,
	DAT_AEND,
	PROZESS_AKTIV
) AS
   SELECT
   v01.art_id, 
   v01.mandant_id, 
   v01.nb_id, 
   v01.wup_id, 
   v01.dat_auslistung, 
   v01.gp_id, 
   v01.phase_status, 
   v01.erl_fg, 
   v01.dat_final, 
   v01.menge_startbestand, 
   v01.vk_netto, 
   v01.menge_endbestand, 
   v01.erl_kz, 
   v01.dat_aend,
  CASE  
	WHEN dat_final < CURRENT_DATE  AND erl_fg <> ('0') 
    THEN 'X'
	ELSE '0'
	END AS prozess_aktiv        
   FROM dbp_view.v_as_food v01
   WHERE phase_status =1;