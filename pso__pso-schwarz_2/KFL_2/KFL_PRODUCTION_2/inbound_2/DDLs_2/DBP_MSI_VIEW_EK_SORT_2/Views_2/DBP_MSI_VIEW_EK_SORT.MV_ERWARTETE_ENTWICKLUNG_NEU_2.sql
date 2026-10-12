CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_ERWARTETE_ENTWICKLUNG_NEU_2
-- Erweiterung um KL-WG Hierarchie Felder fr KMO / sschuecke11.06.2018
-- Erweiterung um kl_sm_id / sschuecke 30.08.2018
-- nderung fr Pilot DE / cbru1709 04.12.2018
-- Neues Feld kjwo_update / cbru1709 21.01.2019
-- UNION mit knstlich erzeugten Daten fr sm_id und ksm_id / cbru1709 04.04.2019

(
 mandant_id
,kjmo
,kjwo_update
,matching_id
,wrg_id
,owg_id
,wg_id
,wug_id
,sm_id
,ksm_id
,ost_basis_pflege
,ost_gross_pflege
,sued_ost_pflege
,sued_west_pflege
,west_pflege
,nord_pflege
,umsatz_hr
,absatz_hr
,rohertrag_hr

)
AS
   SELECT

    mandant_id, kjmo, kjwo_update, matching_id, wrg_id, owg_id, wg_id, wug_id, sm_id, ksm_id, decode(trim(ost_basis_pflege),'u','x',trim(ost_basis_pflege)), decode(trim(ost_gross_pflege),'u','x',trim(ost_gross_pflege)), decode(trim(sued_ost_pflege),'u','x',trim(sued_ost_pflege)), decode(trim(sued_west_pflege),'u','x',trim(sued_west_pflege)), decode(trim(west_pflege),'u','x',trim(west_pflege)), decode(trim(nord_pflege),'u','x',trim(nord_pflege)), umsatz_hr, absatz_hr, rohertrag_hr

   FROM dbp_msi_v_view.v_erwartete_entwicklung_2

   UNION

   SELECT

    v01.mandant_id, v01.kjmo, v01.kjwo_update, v01.matching_id, v01.wrg_id, v01.owg_id, v01.wg_id, v01.wug_id, v02.sm_id, v02.ksm_id, decode(trim(v01.ost_basis_pflege),'u','x',trim(v01.ost_basis_pflege)), decode(trim(v01.ost_gross_pflege),'u','x',trim(v01.ost_gross_pflege)), decode(trim(v01.sued_ost_pflege),'u','x',trim(v01.sued_ost_pflege)), decode(trim(v01.sued_west_pflege),'u','x',trim(v01.sued_west_pflege)), decode(trim(v01.west_pflege),'u','x',trim(v01.west_pflege)), decode(trim(v01.nord_pflege),'u','x',trim(v01.nord_pflege)), 0 as umsatz_hr, 0 as absatz_hr, 0 as rohertrag_hr

   FROM dbp_msi_v_view.v_erwartete_entwicklung_2  v01
   CROSS JOIN (
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K1' as ksm_id) f UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K2' as ksm_id) g UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K3' as ksm_id) h UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K4' as ksm_id) i UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K5' as ksm_id) j UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K6' as ksm_id) k UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K7' as ksm_id) l UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K8' as ksm_id) m UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT -1 as sm_id, 'K9' as ksm_id) n UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT 1 as sm_id, '' as ksm_id) a UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT 2 as sm_id, '' as ksm_id) b UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT 3 as sm_id, '' as ksm_id) c UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT 4 as sm_id, '' as ksm_id) d UNION ALL
   SELECT sm_id, ksm_id FROM (SELECT 5 as sm_id, '' as ksm_id) e) v02
   WHERE (v01.mandant_id = 1 and v02.ksm_id = '') or v01.mandant_id <> 1;