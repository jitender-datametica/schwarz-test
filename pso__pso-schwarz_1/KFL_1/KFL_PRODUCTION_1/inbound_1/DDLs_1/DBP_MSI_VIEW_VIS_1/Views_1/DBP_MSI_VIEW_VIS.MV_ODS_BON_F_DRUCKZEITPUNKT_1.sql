CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_DRUCKZEITPUNKT_1(
	BON_ID,
	WUP_ID,
	MANDANT_ID,
	ZEITSTEMPEL_DRUCK,
	BON_BOOKING,
	DAT_BOOKING,
	BON_ENDE
)  AS

   -- Fakt-View:
   -- Ermitteln des letzten Druckzeitpunktes für Bericht Abholliste
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
   
SELECT
 a.bon_id 
 , wup.aktuell_wup_id 																AS wup_id
 , a.mandant_id
 , a.zeitstempel_druck 
 , k.bon_booking
 , k.dat_booking
 , k.bon_ende
FROM dbp_msi_v_view.v_ods_bon_abhol_liste_1 a

INNER JOIN dbp_v_ods.v_ods_bon_kopf_1 k
ON  k.bon_id     = a.bon_id
AND k.wup_id     = a.wup_id
AND k.mandant_id = a.mandant_id

INNER JOIN dbp_view.v_wup_1 wup_1
ON a.mandant_id = wup.mandant_id AND a.wup_id = wup.wup_id

;
