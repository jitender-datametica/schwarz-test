
CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_AUSNAHME
-- EK-3243293 Änderung pruef_ids / 19.02.2013 sschuecke
-- RITM0354239 Erweiterung Exceptions 250/252 / 17.05.2017 sschuecke
--SPEC0044639 Erweiterung pruef_id 700,001,005/lsvi0303
--SPEC0044639 Erweiterung pruef_id 002/lsvi0303
--SPEC0070820 Änderung pruef_id 253/nwag2310
--SPEC0147775 Erweiterung pruef_id 254/richternic
--NSR4005022 Filter auf wup_id <> 0 / sschuecke 21.09.2023
--NSR4167019 Filter auf kdis/dismm/wlk1-Listung / nwag2310 9.1.2024
(
art_id
,wup_id
,nb_id
,mandant_id
,dat_plan
,pruef_id
--,z_arbeitsgebiet_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO

AS

   SELECT
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.dat_plan,
   v01.pruef_id
   --,CASE WHEN z_arbeitsgebiet_id = 0 THEN 'Z' WHEN z_arbeitsgebiet_id = 1 THEN 'S' ELSE ' ' END AS z_arbeitsgebiet_id
   FROM dbp_view.v_ausnahme v01

   JOIN dbp_view.v_tag t
   ON v01.dat_plan = t.dat
   AND t.akt_kj >= -2

   JOIN dbp_view.v_art_wup_status_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v01.art_id = v02.art_id
   AND v01.dat_plan BETWEEN v02.dat_von AND v02.dat_bis
   AND v02.dispomerkmal IN ('S2', '10', '12', '14')
   AND v02.kdis = 0 

   WHERE ( v01.pruef_id IN (202,203,205,206,207,209,210,214,216,218,223,225,231,700)
   AND v01.mandant_id <> 1
   AND v01.z_arbeitsgebiet_id = 1
   AND v01.wup_id <> 0

   OR (v01.mandant_id <> 1
   AND v01.nb_id <> -111
   AND v01.pruef_id IN (250,252,001,005,002,253,254)
   AND v01.z_arbeitsgebiet_id = 0
   AND v01.wup_id <> 0) )

   AND EXISTS (	SELECT 1
	FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER v03
	WHERE v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND v01.art_id = v03.art_id
   AND v01.dat_plan BETWEEN v03.dat_von AND v03.dat_bis	)
   ;