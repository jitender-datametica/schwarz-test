CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_kmo.mv_gp_1
--25.02.2021 lsvi0303: AP0049751, SPEC0097117 IVN Attribute - ivn field added
--27.09.2021 snik1809: AP0085198, SPEC0118722 - added markant_id
(
  mandant_id
, gp_id
, gp_name
, zek_id
, land_id
, zahlungsziel_id
, ivn
, markant_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
SELECT
 v01.mandant_id
,v01.gp_id
,v01.gp_name
,v01.zek_id
,v01.land_id
,v01.zahlungsziel_id
,v01.ivn
,v01.markant_id
FROM dbp_view.v_gp_1 v01
WHERE v01.mandant_id <> 1
AND einkaufsorganisation_id <> -1;