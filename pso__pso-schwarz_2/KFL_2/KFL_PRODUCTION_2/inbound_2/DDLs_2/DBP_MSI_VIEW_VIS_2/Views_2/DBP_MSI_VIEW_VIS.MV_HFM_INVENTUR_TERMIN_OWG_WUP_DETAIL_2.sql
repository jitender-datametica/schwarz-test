CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HFM_INVENTUR_TERMIN_OWG_WUP_DETAIL_2(
  MANDANT_ID
 ,WUP_ID
 ,NB_ID
 ,DAT_PLAN_ZAEHLUNG
 ,INVENTURART_INT_ID
 ,OWG_ID
 ,ARTHIERTYP_ID
 ,DAT_VORLETZTE_ZAEHLUNG
 ,WRG_ID
 ,ANFANGSBESTAND
 ,WARENZUGANG
 ,WARENZUGANG_DZL
 ,WARENZUGANG_DZL_KORR
 ,WARENZUGANG_ZL
 ,WARENZUGANG_ZL_KORR
 ,WARENZUGANG_RETOURE
 ,ABSCHRIFTEN_OHNE_DIEBSTAHL
 ,WERBEGUTSCHRIFTEN
 ,ABSCHRIFTEN_OPERATIV
 ,ABSCHRIFTEN_TA_VT_SONSTIGE
 ,ENDBESTAND_RECHNERISCH
 ,ENDBESTAND_GEZAEHLT
 ,UMSATZ_SOLL
) AS

	-- 17112021 - snik - creation in SF
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 owd.mandant_id
 , wup.aktuell_wup_id 														                    AS wup_id
 , owd.nb_id
 , owd.dat_plan_zaehlung
 , owd.inventurart_int_id
 , owd.owg_id
 , owd.arthiertyp_id
 , owd.dat_vorletzte_zaehlung
 , owd.wrg_id
 , owd.anfangsbestand
 , owd.warenzugang
 , owd.warenzugang_dzl
 , owd.warenzugang_dzl_korr
 , owd.warenzugang_zl
 , owd.warenzugang_zl_korr
 , owd.warenzugang_retoure
 , owd.abschriften_ohne_diebstahl
 , owd.werbegutschriften
 , owd.abschriften_operativ
 , owd.abschriften_ta_vt_sonstige
 , owd.endbestand_rechnerisch
 , owd.endbestand_gezaehlt
 , owd.umsatz_soll
FROM DBP_VIEW.V_HFM_INVENTUR_TERMIN_OWG_WUP_DETAIL_2 owd

INNER JOIN dbp_view.v_wup_2 wup_2
ON owd.mandant_id = wup.mandant_id AND owd.wup_id = wup.wup_id
;