CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MHD_ERFASSUNG_WUP_ART_1(
 MANDANT_ID,
 WUP_ID,
 DAT_ERFASSUNG,
 DAT_MHD,
 ART_ID,
 ART_ANZ,
 BASISMENGE_EINH_ID,
 MHD_ERFASSUNG_PRUEF_FG,
 LISTUNG_FG,
 DAT_ERSTELLUNG,
 DAT_AENDERUNG
) AS

	-- 09012023 snik - Creation 
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 ewa.mandant_id
 , wup.aktuell_wup_id 											                              AS wup_id
 , ewa.dat_erfassung
 , ewa.dat_mhd
 , ewa.art_id
 , ewa.art_anz
 , ewa.basismenge_einh_id
 , ewa.mhd_erfassung_pruef_fg
 , ewa.listung_fg
 , ewa.dat_erstellung
 , ewa.dat_aenderung
FROM DBP_VIEW.V_MHD_ERFASSUNG_WUP_ART_1 ewa

INNER JOIN dbp_view.v_wup_1 wup_1
ON ewa.mandant_id = wup.mandant_id AND ewa.wup_id = wup.wup_id

;