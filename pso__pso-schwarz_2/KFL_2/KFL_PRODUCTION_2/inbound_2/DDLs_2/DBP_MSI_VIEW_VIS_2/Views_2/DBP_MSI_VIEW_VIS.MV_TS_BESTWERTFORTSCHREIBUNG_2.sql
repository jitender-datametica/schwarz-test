CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TS_BESTWERTFORTSCHREIBUNG_2(
  MANDANT_ID
 ,WUP_ID
 ,NB_ID
 ,DAT
 ,OWG_ID
 ,ARTHIERTYP_ID
 ,UMSATZ_PLAN_BRUTTO_OWG
 ,WARENEINGANG_BRUTTO_OWG
 ,SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG
 ,DATZEIT_PFLEGE
 ,WRG_ID
) AS

	--02.22.2022 snik1809 - creation/transport
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 bwf.mandant_id
 , wup.aktuell_wup_id 																AS wup_id
 , bwf.nb_id
 , bwf.dat
 , bwf.owg_id
 , bwf.arthiertyp_id
 , bwf.umsatz_plan_brutto_owg
 , bwf.wareneingang_brutto_owg
 , bwf.schlussbestand_vormonat_brutto_owg
 , bwf.datzeit_pflege
 , bwf.wrg_id

FROM DBP_MSI_V_VIEW.V_TS_BESTWERTFORTSCHREIBUNG_2 bwf

INNER JOIN dbp_view.v_wup_2 wup_2
ON bwf.mandant_id = wup.mandant_id AND bwf.wup_id = wup.wup_id
;