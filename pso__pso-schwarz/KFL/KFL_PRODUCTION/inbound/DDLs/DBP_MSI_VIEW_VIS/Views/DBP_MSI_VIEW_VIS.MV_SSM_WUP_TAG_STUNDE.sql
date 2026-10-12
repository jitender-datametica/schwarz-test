CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SSM_WUP_TAG_STUNDE(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	WUP_BEREICH_ID,
	WUP_ABT_ID,
	SSM_CLUSTER_ID,
	SSM_PROZESS_ID,
	DAT,
	ZEIT_STUNDE,
	ZEIT_15MIN,
	SSM_AUFWAND_TYP_ID,
	WERT,
	WERT_GERUNDET
) AS

	-- 09.04.2020 SNIK1809 AP0052955-SPEC0067085
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 wts.mandant_id
 , wup.aktuell_wup_id 													AS wup_id
 , wts.nb_id
 , wts.wup_bereich_id
 , wts.wup_abt_id
 , wts.ssm_cluster_id
 , wts.ssm_prozess_id
 , wts.dat
 , wts.zeit_stunde
 , wts.zeit_15min
 , wts.ssm_aufwand_typ_id
 , wts.wert
 , wts.wert_gerundet
FROM DBP_VIEW.V_SSM_WUP_TAG_STUNDE WTS

INNER JOIN dbp_view.v_wup wup
ON wts.mandant_id = wup.mandant_id AND wts.wup_id = wup.wup_id
;

