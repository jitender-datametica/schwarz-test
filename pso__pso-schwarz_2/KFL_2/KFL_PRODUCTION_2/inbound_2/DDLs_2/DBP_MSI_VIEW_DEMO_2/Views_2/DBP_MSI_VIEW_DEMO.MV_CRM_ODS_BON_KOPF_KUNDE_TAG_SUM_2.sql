CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_CRM_ODS_BON_KOPF_KUNDE_TAG_SUM_2
AS
SELECT

v01.crm_kunde_id,
v01.crm_loyaltyaccount_id,
v01.kundenkarte_id,
v01.crm_kundenkarte_art_id,
v01.wup_id,
v01.nb_id,
v01.mandant_id,
v01.dat,
v01.anz_bons,
v01.ums_brutto,
v01.ums_netto
FROM dbp_view.v_crm_ods_bon_kopf_kunde_tag_sum_2 v01
;


--12.11.2018, AP0021792, srom0404: OWG Umstellung
