CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_DRUCK_STATISTIK_PER_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	EPS_DRUCK_STATISTIK_ID,
	KL_ART_ID,
	ART_ID,
	DATZEIT_ANFORDERUNG,
	DATZEIT_DRUCK,
	DAT,
	DRUCK_ANLASS_ID,
	CONTAINERTYP_ID,
	LAYOUT_GROESSE_ID,
	PAPIERART_ID
) AS

   -- 12.03.2019 dsim0608 - SPEC0049429
   -- 2019-10-30 ssch0611 - Review
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 eps.mandant_id
 , wup.aktuell_wup_id 														   AS wup_id
 , eps.nb_id
 , eps.eps_druck_statistik_id
 , eps.kl_art_id
 , art.art_id
 , eps.datzeit_anforderung
 , eps.datzeit_druck
 , Cast(eps.datzeit_druck AS DATE) 											AS dat
 , eps.druck_anlass_id
 , eps.containertyp_id
 , eps.layout_groesse_id 																	-- not used
 , eps.papierart_id      																	-- not used
FROM dbp_view.v_eps_druck_statistik_per_2 eps

JOIN dbp_view.v_art_2 art_2
ON  eps.mandant_id = art.mandant_id AND eps.kl_art_id = art.kl_art_id

INNER JOIN dbp_view.v_wup_2 wup_2
ON eps.mandant_id = wup.mandant_id AND eps.wup_id = wup.wup_id


WHERE Cast(eps.datzeit_druck AS DATE) >= (SELECT Current_Date - INTERVAL '2 year')
;