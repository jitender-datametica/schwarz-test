CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_int.mv_gp
--25.02.2021 lsvi0303: AP0049751, SPEC0097117 IVN Attribute - ivn field added
--27.09.2021 snik1809: AP0085198, SPEC0118722 - added markant_id
(
  gp_id
, mandant_id
, dat_von
, agb_id
, dat_bis
, iso_id
, eigenverpackung_id
, eigenmarke_id
, audit_id
, audit_dat
, anlieferung_id
, gp_name
, gp_strasse
, gp_plz
, gp_ort
, land_id
, region_id
, sap_region_id
, hgp_id
, zek_id
, lieferzeit
, zahlungsziel_id
, ampel_flg
, gln_bbnr
, gln_bsnr
, gln_bubkz
, iln_id
, ivn
, markant_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.gp_id
,v01.mandant_id
,v01.dat_von
,v01.agb_id
,v01.dat_bis
,v01.iso_id
,v01.eigenverpackung_id
,v01.eigenmarke_id
,v01.audit_id
,v01.audit_dat
,v01.anlieferung_id
,v01.gp_name
,v01.gp_strasse
,v01.gp_plz
,v01.gp_ort
,v01.land_id
,v01.region_id
,v02.sap_region_id
,v01.hgp_id
,v01.zek_id
,v01.lieferzeit
,v01.zahlungsziel_id
,1
,v01.gln_bbnr
,v01.gln_bsnr
,v01.gln_bubkz
,NULL AS iln_id
,v01.ivn
,v01.markant_id

FROM dbp_view.v_gp v01, dbp_view.v_region v02
WHERE v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.land_id
AND v01.region_id = v02.region_id
AND v01.gp_id NOT BETWEEN 10000 AND 999999;