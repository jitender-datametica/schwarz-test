CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_PSP_ELEMENT_2
-- in_psp_element_2 (PRPS)
-- Stammdaten PSP-Element, angereichert um inProjekt und cPro
-- 20151021 ssch0611 : Projekt 0533 Anpassungen
(
mandant_id
, psp_id
, psp_id_char
, psp_bez
, dat_abschluss
, Satus_PSP
, systemstatus_id
, psp_end_nr
, ims_projekt_typ_id
, in_projekt_id
, in_projekt_id_char
, PSP_Projekt
, projekt_nr
, projekt_id
,in_massnahme_typ_id
,dat_massnahme_ende
)
AS
   SELECT
   ipsp.mandant_id, ipsp.psp_id, ipsp.psp_id_char, ipsp.psp_bez, COALESCE(ipsp.dat_abschluss, CAST('1900-01-01' AS DATE)) AS dat_abschluss, ipsp.dat_abschluss  AS Satus_PSP -- doppelt
   , ipst.systemstatus_id, SUBSTRING(psp_id_char, (LENGTH(psp_id_char)), 1)::SMALLINT AS psp_end_nr, ipro.ims_projekt_typ_id, ipro.in_projekt_id, ipro.in_projekt_id_char, ipro.in_projekt_id_char AS PSP_Projekt -- doppelt
   , ipro.projekt_ext_id     AS projekt_nr, cpro.projekt_id, ipro.in_massnahme_typ_id, ipro.dat_massnahme_ende
   FROM dbp_view.v_in_psp_element_2 ipsp

   JOIN dbp_view.v_in_projekt_2 ipro
   ON ipro.mandant_id = ipsp.mandant_id
   AND ipro.in_projekt_id = ipsp.in_projekt_id
   LEFT JOIN dbp_view.v_cpr_projekt_per_2 cpro
   ON  cpro.cpr_ext_id = ipro.projekt_ext_id
   AND cpro.dat_bis = '9999-12-31'
   LEFT JOIN dbp_view.v_ims_psp_ele_sysstat_zu_2 ipst
   ON ipst.psp_id = ipsp.psp_id
   AND ipst.mandant_id = ipsp.mandant_id

   WHERE ipsp.statistisch_fg  = 1 /* Neue Projekte nur statistisch*/;