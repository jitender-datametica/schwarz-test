CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_CRM_F_ODS_BON_KOPF_KUNDE_TAG_SUM
(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	KUNDENKARTE_ID,
	CRM_KUNDENKARTE_ART_ID,
	CRM_KONTO_ID,
	CRM_KONTO_TYP_ID,
	DAT,
	KJWO_WW,
	ANZ_BONS
) 
AS
SELECT
-- Neuanlage View SPEC0182891 analog EK_KUNDE / ssch1303 29.03.2023
    k.mandant_id               
   ,k.wup_id
   ,k.nb_id
   ,k.kundenkarte_id
   ,kar.crm_kundenkarte_art_id
   ,kon.crm_konto_id
   ,kon.crm_konto_typ_id
   ,k.dat
   ,v03.kjwo_ww
   ,SUM(k.anz_bons) AS anz_bons

FROM dbp_view.v_crm_kartebew k

JOIN dbp_view.v_crm_l_kundenkarte  kar
  ON kar.kundenkarte_id = k.kundenkarte_id
 AND kar.mandant_id=k.mandant_id

LEFT OUTER JOIN dbp_view.v_crm_l_konto kon
  ON kon.crm_konto_id = kar.crm_konto_id

LEFT OUTER JOIN dbp_view.v_werbewoche_kl v03
  ON k.dat = v03.dat 
 AND k.mandant_id = v03.mandant_id

GROUP BY
    k.mandant_id               
   ,k.wup_id                    
   ,k.nb_id
   ,k.kundenkarte_id
   ,kar.crm_kundenkarte_art_id
   ,kon.crm_konto_id
   ,kon.crm_konto_typ_id
   ,k.dat
   ,v03.kjwo_ww;